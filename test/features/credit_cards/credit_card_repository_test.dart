import 'package:drift/native.dart';
import 'package:fince/core/domain/money.dart';
import 'package:fince/core/storage/app_database.dart';
import 'package:fince/features/credit_cards/data/datasources/credit_card_local_data_source.dart';
import 'package:fince/features/credit_cards/data/repositories/credit_card_repository_impl.dart';
import 'package:fince/features/credit_cards/domain/entities/credit_card.dart';
import 'package:fince/features/credit_cards/domain/entities/installment.dart';
import 'package:fince/features/credit_cards/domain/usecases/create_card.dart';
import 'package:fince/features/credit_cards/domain/usecases/register_purchase.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late AppDatabase db;
  late CreditCardLocalDataSource local;
  late CreateCard createCard;
  late RegisterPurchase registerPurchase;

  setUp(() {
    db = AppDatabase(NativeDatabase.memory());
    local = CreditCardLocalDataSource(db);
    final repository = CreditCardRepositoryImpl(local: local);
    createCard = CreateCard(repository);
    registerPurchase = RegisterPurchase(repository);
  });

  tearDown(() async {
    await db.close();
  });

  test('splitIntoInstallments uses largest-remainder rounding', () {
    final parts = splitIntoInstallments(Money(120000, 'BRL'), 7);

    expect(parts, hasLength(7));
    expect(
      parts.fold(0, (sum, p) => sum + p.minorUnits),
      120000,
      reason: 'parts must sum exactly to the total',
    );
  });

  test('registerPurchase splits a purchase and updates the available limit',
      () async {
    final card = await createCard(
      name: 'Visa',
      brand: CardBrand.visa,
      creditLimit: Money(120000, 'BRL'),
      closingDay: 10,
      dueDay: 5,
    );

    final installments = await registerPurchase(
      cardId: card.id,
      description: 'Smartphone',
      amount: Money(120000, 'BRL'),
      installments: 6,
      date: DateTime(2026, 9, 10),
    );

    expect(installments, hasLength(6));
    expect(installments.map((i) => i.amount.minorUnits), everyElement(20000));
    expect(installments.map((i) => i.totalInstallments), everyElement(6));
    expect(installments.map((i) => i.number).toList(), [1, 2, 3, 4, 5, 6]);
    expect(installments.map((i) => i.transactionId).toSet(), hasLength(1));

    final cardRow = await (db.select(db.creditCards)
          ..where((c) => c.id.equals(card.id)))
        .getSingle();
    expect(cardRow.availableLimitMinor, 0);

    final transactions = await db.select(db.transactions).get();
    expect(transactions, hasLength(1));
    expect(transactions.first.amountMinor, 120000);
    expect(transactions.first.type, 'expense');
  });
}
