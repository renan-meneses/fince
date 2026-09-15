import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';

import '../../../../core/domain/money.dart';
import '../../../../core/errors/failure.dart';
import '../../../../core/storage/app_database.dart';
import '../../domain/entities/credit_card.dart';
import '../../domain/entities/credit_card_invoice.dart';
import '../../domain/entities/installment.dart';

/// Drift-backed local storage for credit cards, purchases, installments, and
/// invoices. Mutations are atomic.
class CreditCardLocalDataSource {
  CreditCardLocalDataSource(this._db);

  final AppDatabase _db;

  static const _uuid = Uuid();

  Stream<List<CreditCard>> watchAll() {
    final query = _db.select(_db.creditCards)
      ..where((t) => t.isActive.equals(true))
      ..orderBy([(t) => OrderingTerm.asc(t.createdAt)]);
    return query.watch().map((rows) => rows.map(_toCard).toList());
  }

  Future<CreditCard> insertCard(CreditCard card) async {
    await _db.into(_db.creditCards).insert(_toCardCompanion(card));
    return card;
  }

  Future<CreditCard> updateCard(CreditCard card) async {
    await (_db.update(_db.creditCards)..where((t) => t.id.equals(card.id)))
        .write(_toCardCompanion(card));
    return card;
  }

  Future<void> archiveCard(String id) async {
    await (_db.update(_db.creditCards)..where((t) => t.id.equals(id)))
        .write(const CreditCardsCompanion(isActive: Value(false)));
  }

  Future<List<Installment>> registerPurchase({
    required String cardId,
    required String description,
    required Money amount,
    required int installments,
    String? categoryId,
    required DateTime date,
  }) async {
    final parts = splitIntoInstallments(amount, installments);

    return _db.transaction(() async {
      final card = await (_db.select(_db.creditCards)
            ..where((t) => t.id.equals(cardId)))
          .getSingleOrNull();
      if (card == null) {
        throw const DatabaseFailure(message: 'Cartão não encontrado.');
      }
      if (card.currency != amount.currency) {
        throw const ValidationFailure(message: 'Moeda incompatível com o cartão.');
      }

      final now = DateTime.now().toUtc();
      final transactionId = _uuid.v4();

      // The full purchase is recorded as a single expense transaction. It does
      // NOT debit a bank account (it is credit); installments settle later.
      await _db.into(_db.transactions).insert(
            TransactionsCompanion.insert(
              id: transactionId,
              description: description,
              amountMinor: amount.minorUnits,
              currency: amount.currency,
              type: 'expense',
              accountId: cardId,
              categoryId: Value(categoryId),
              date: date,
              createdAt: now,
              updatedAt: now,
            ),
          );

      final created = <Installment>[];
      for (var i = 0; i < parts.length; i++) {
        final dueDate = _addMonths(date, i);
        final invoice = await _getOrCreateInvoice(
          card: card,
          dueDate: dueDate,
          amount: parts[i],
        );
        final installment = Installment(
          id: _uuid.v4(),
          transactionId: transactionId,
          creditCardInvoiceId: invoice.id,
          number: i + 1,
          totalInstallments: parts.length,
          amount: parts[i],
          currency: amount.currency,
          dueDate: dueDate,
          status: InstallmentStatus.pending,
        );
        await _db.into(_db.installments).insert(_toInstallmentCompanion(installment));
        created.add(installment);
      }

      final newAvailable = card.availableLimitMinor - amount.minorUnits;
      await (_db.update(_db.creditCards)..where((t) => t.id.equals(cardId)))
          .write(CreditCardsCompanion(availableLimitMinor: Value(newAvailable)));

      return created;
    });
  }

  Future<List<CreditCardInvoice>> getInvoices(String cardId) async {
    final rows = await (_db.select(_db.creditCardInvoices)
          ..where((t) => t.creditCardId.equals(cardId))
          ..orderBy([(t) => OrderingTerm.desc(t.closingDate)]))
        .get();
    return rows.map(_toInvoice).toList();
  }

  Future<void> payInvoice({
    required String invoiceId,
    required String accountId,
  }) async {
    await _db.transaction(() async {
      final invoice = await (_db.select(_db.creditCardInvoices)
            ..where((t) => t.id.equals(invoiceId)))
          .getSingleOrNull();
      if (invoice == null) {
        throw const DatabaseFailure(message: 'Fatura não encontrada.');
      }
      if (invoice.status == 'paid') {
        throw const ValidationFailure(message: 'Fatura já paga.');
      }

      final card = await (_db.select(_db.creditCards)
            ..where((t) => t.id.equals(invoice.creditCardId)))
          .getSingleOrNull();
      if (card == null) {
        throw const DatabaseFailure(message: 'Cartão não encontrado.');
      }

      final account = await (_db.select(_db.accounts)
            ..where((t) => t.id.equals(accountId)))
          .getSingleOrNull();
      if (account == null) {
        throw const DatabaseFailure(message: 'Conta não encontrada.');
      }

      final remaining = invoice.totalAmountMinor - invoice.paidAmountMinor;
      await (_db.update(_db.accounts)..where((t) => t.id.equals(accountId)))
          .write(
        AccountsCompanion(
          currentBalanceMinor: Value(account.currentBalanceMinor - remaining),
        ),
      );

      final now = DateTime.now().toUtc();
      await (_db.update(_db.creditCardInvoices)
            ..where((t) => t.id.equals(invoiceId)))
          .write(
        CreditCardInvoicesCompanion(
          paidAmountMinor: Value(invoice.totalAmountMinor),
          status: const Value('paid'),
          paidAt: Value(now),
        ),
      );

      await (_db.update(_db.installments)
            ..where((t) => t.creditCardInvoiceId.equals(invoiceId)))
          .write(
        InstallmentsCompanion(
          status: const Value('paid'),
          paidAt: Value(now),
        ),
      );

      await (_db.update(_db.creditCards)..where((t) => t.id.equals(card.id)))
          .write(
        CreditCardsCompanion(
          availableLimitMinor: Value(card.availableLimitMinor + remaining),
        ),
      );
    });
  }

  Future<CreditCardInvoiceRow> _getOrCreateInvoice({
    required CreditCardRow card,
    required DateTime dueDate,
    required Money amount,
  }) async {
    final periodStart = DateTime(dueDate.year, dueDate.month, 1);
    final existing = await (_db.select(_db.creditCardInvoices)
          ..where((t) =>
              t.creditCardId.equals(card.id) &
              t.periodStart.equals(periodStart)))
        .getSingleOrNull();

    if (existing != null) {
      final newTotal = existing.totalAmountMinor + amount.minorUnits;
      await (_db.update(_db.creditCardInvoices)
            ..where((t) => t.id.equals(existing.id)))
          .write(CreditCardInvoicesCompanion(totalAmountMinor: Value(newTotal)));
      return (await (_db.select(_db.creditCardInvoices)
            ..where((t) => t.id.equals(existing.id)))
          .getSingle());
    }

    final invoiceId = _uuid.v4();
    final row = CreditCardInvoicesCompanion.insert(
      id: invoiceId,
      creditCardId: card.id,
      periodStart: periodStart,
      periodEnd: DateTime(dueDate.year, dueDate.month + 1, 0),
      closingDate: DateTime(dueDate.year, dueDate.month, card.closingDay),
      dueDate: DateTime(dueDate.year, dueDate.month, card.dueDay),
      totalAmountMinor: amount.minorUnits,
      currency: amount.currency,
    );
    await _db.into(_db.creditCardInvoices).insert(row);
    return (await (_db.select(_db.creditCardInvoices)
          ..where((t) => t.id.equals(invoiceId)))
        .getSingle());
  }

  DateTime _addMonths(DateTime date, int months) =>
      DateTime(date.year, date.month + months, date.day);

  CreditCard _toCard(CreditCardRow row) => CreditCard(
        id: row.id,
        name: row.name,
        brand: CardBrand.values.byName(row.brand),
        creditLimit: Money(row.creditLimitMinor, row.currency),
        availableLimit: Money(row.availableLimitMinor, row.currency),
        currency: row.currency,
        closingDay: row.closingDay,
        dueDay: row.dueDay,
        linkedAccountId: row.linkedAccountId,
        createdAt: row.createdAt,
        isActive: row.isActive,
      );

  CreditCardInvoice _toInvoice(CreditCardInvoiceRow row) => CreditCardInvoice(
        id: row.id,
        creditCardId: row.creditCardId,
        periodStart: row.periodStart,
        periodEnd: row.periodEnd,
        closingDate: row.closingDate,
        dueDate: row.dueDate,
        totalAmount: Money(row.totalAmountMinor, row.currency),
        paidAmount: Money(row.paidAmountMinor, row.currency),
        currency: row.currency,
        status: InvoiceStatus.values.byName(row.status),
        paidAt: row.paidAt,
      );

  CreditCardsCompanion _toCardCompanion(CreditCard c) =>
      CreditCardsCompanion.insert(
        id: c.id,
        name: c.name,
        brand: c.brand.name,
        creditLimitMinor: c.creditLimit.minorUnits,
        availableLimitMinor: c.availableLimit.minorUnits,
        currency: c.currency,
        closingDay: c.closingDay,
        dueDay: c.dueDay,
        linkedAccountId: Value(c.linkedAccountId),
        createdAt: c.createdAt,
        isActive: Value(c.isActive),
      );

  InstallmentsCompanion _toInstallmentCompanion(Installment i) =>
      InstallmentsCompanion.insert(
        id: i.id,
        transactionId: i.transactionId,
        creditCardInvoiceId: Value(i.creditCardInvoiceId),
        number: i.number,
        totalInstallments: i.totalInstallments,
        amountMinor: i.amount.minorUnits,
        currency: i.currency,
        dueDate: i.dueDate,
        status: Value(i.status.name),
        paidAt: Value(i.paidAt),
      );
}
