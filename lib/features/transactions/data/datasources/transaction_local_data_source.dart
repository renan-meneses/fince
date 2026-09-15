import 'dart:convert';

import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';

import '../../../../core/domain/money.dart';
import '../../../../core/errors/failure.dart';
import '../../../../core/storage/app_database.dart';
import '../../domain/entities/transaction.dart';
import '../../domain/entities/transaction_filter.dart';

/// Drift-backed local storage for transactions.
///
/// Create/update/delete adjust the linked account balance **atomically** so a
/// transaction and its ledger effect can never diverge.
class TransactionLocalDataSource {
  TransactionLocalDataSource(this._db);

  final AppDatabase _db;

  static const _uuid = Uuid();

  Stream<List<Transaction>> watchAll({
    TransactionFilter filter = const TransactionFilter(),
    TransactionSort sort = TransactionSort.dateDesc,
  }) {
    final query = _db.select(_db.transactions);
    _applyConditions(query, filter);
    query.orderBy([_orderClause(sort)]);
    return query.watch().map((rows) => rows.map(_toEntity).toList());
  }

  Future<List<Transaction>> getAll({
    TransactionFilter filter = const TransactionFilter(),
    TransactionSort sort = TransactionSort.dateDesc,
    int limit = 100,
    int offset = 0,
  }) async {
    final query = _db.select(_db.transactions);
    _applyConditions(query, filter);
    query.orderBy([_orderClause(sort)]);
    query.limit(limit, offset: offset);
    final rows = await query.get();
    return rows.map(_toEntity).toList();
  }

  Future<Transaction> create(Transaction transaction) async {
    await _db.transaction(() async {
      await _applyBalanceEffect(transaction, sign: 1);
      await _db.into(_db.transactions).insert(_toCompanion(transaction));
    });
    return transaction;
  }

  Future<Transaction> update(Transaction transaction) async {
    await _db.transaction(() async {
      final previous = await _getById(transaction.id);
      if (previous != null) {
        await _applyBalanceEffect(previous, sign: -1);
      }
      await _applyBalanceEffect(transaction, sign: 1);
      await (_db.update(_db.transactions)
            ..where((t) => t.id.equals(transaction.id)))
          .write(_toCompanion(transaction));
    });
    return transaction;
  }

  Future<void> delete(String id) async {
    await _db.transaction(() async {
      final previous = await _getById(id);
      if (previous != null) {
        await _applyBalanceEffect(previous, sign: -1);
      }
      await (_db.delete(_db.transactions)..where((t) => t.id.equals(id))).go();
    });
  }

  Future<Transaction> duplicate(String id) async {
    final original = await _getById(id);
    if (original == null) {
      throw const DatabaseFailure(message: 'Transação não encontrada.');
    }
    final now = DateTime.now().toUtc();
    final copy = original.copyWith(
      id: _uuid.v4(),
      date: now,
      paymentStatus: PaymentStatus.pending,
      createdAt: now,
      updatedAt: now,
    );
    return create(copy);
  }

  Future<Transaction?> _getById(String id) async {
    final row = await (_db.select(_db.transactions)
          ..where((t) => t.id.equals(id)))
        .getSingleOrNull();
    return row == null ? null : _toEntity(row);
  }

  void _applyConditions(
    SimpleSelectStatement<Transactions, TransactionRow> query,
    TransactionFilter filter,
  ) {
    if (filter.isEmpty) return;
    query.where((t) {
      final conditions = <Expression<bool>>[
        if (filter.accountId != null) t.accountId.equals(filter.accountId!),
        if (filter.categoryId != null) t.categoryId.equals(filter.categoryId!),
        if (filter.type != null) t.type.equals(filter.type!.name),
        if (filter.startDate != null)
          t.date.isBiggerOrEqualValue(filter.startDate!),
        if (filter.endDate != null)
          t.date.isSmallerOrEqualValue(filter.endDate!),
        if (filter.minAmountMinor != null)
          t.amountMinor.isBiggerOrEqualValue(filter.minAmountMinor!),
        if (filter.maxAmountMinor != null)
          t.amountMinor.isSmallerOrEqualValue(filter.maxAmountMinor!),
        if (filter.status != null)
          t.paymentStatus.equals(filter.status!.name),
        if (filter.query != null && filter.query!.trim().isNotEmpty)
          t.description.contains(filter.query!.trim()),
      ];
      return conditions.reduce((a, b) => a & b);
    });
  }

  OrderingTerm Function($TransactionsTable) _orderClause(
    TransactionSort sort,
  ) =>
      switch (sort) {
        TransactionSort.dateDesc => (t) => OrderingTerm.desc(t.date),
        TransactionSort.dateAsc => (t) => OrderingTerm.asc(t.date),
        TransactionSort.amountDesc => (t) => OrderingTerm.desc(t.amountMinor),
        TransactionSort.amountAsc => (t) => OrderingTerm.asc(t.amountMinor),
      };

  /// Credits/debits the linked account. Transfers are neutral (handled by the
  /// accounts feature). [sign] is +1 to apply, -1 to reverse.
  Future<void> _applyBalanceEffect(Transaction t, {required int sign}) async {
    if (t.type == TransactionType.transfer) return;
    final multiplier = t.type == TransactionType.income ? 1 : -1;
    final delta = t.amount.minorUnits * sign * multiplier;

    final account = await (_db.select(_db.accounts)
          ..where((a) => a.id.equals(t.accountId)))
        .getSingleOrNull();
    if (account == null) {
      throw const DatabaseFailure(message: 'Conta não encontrada.');
    }

    final newBalance = account.currentBalanceMinor + delta;
    await (_db.update(_db.accounts)..where((a) => a.id.equals(t.accountId)))
        .write(AccountsCompanion(currentBalanceMinor: Value(newBalance)));
  }

  Transaction _toEntity(TransactionRow row) => Transaction(
        id: row.id,
        description: row.description,
        amount: Money(row.amountMinor, row.currency),
        type: TransactionType.values.byName(row.type),
        accountId: row.accountId,
        transferAccountId: row.transferAccountId,
        categoryId: row.categoryId,
        subcategoryId: row.subcategoryId,
        date: row.date,
        paymentStatus: PaymentStatus.values.byName(row.paymentStatus),
        notes: row.notes,
        tags: (jsonDecode(row.tags) as List<dynamic>).cast<String>(),
        attachmentPath: row.attachmentPath,
        transferGroupId: row.transferGroupId,
        recurrenceId: row.recurrenceId,
        installmentId: row.installmentId,
        createdAt: row.createdAt,
        updatedAt: row.updatedAt,
      );

  TransactionsCompanion _toCompanion(Transaction t) =>
      TransactionsCompanion.insert(
        id: t.id,
        description: t.description,
        amountMinor: t.amount.minorUnits,
        currency: t.amount.currency,
        type: t.type.name,
        accountId: t.accountId,
        transferAccountId: Value(t.transferAccountId),
        categoryId: Value(t.categoryId),
        subcategoryId: Value(t.subcategoryId),
        date: t.date,
        paymentStatus: Value(t.paymentStatus.name),
        notes: Value(t.notes),
        tags: Value(jsonEncode(t.tags)),
        attachmentPath: Value(t.attachmentPath),
        transferGroupId: Value(t.transferGroupId),
        recurrenceId: Value(t.recurrenceId),
        installmentId: Value(t.installmentId),
        createdAt: t.createdAt,
        updatedAt: t.updatedAt,
      );
}
