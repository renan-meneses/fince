import 'package:drift/native.dart';
import 'package:fince/core/storage/app_database.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late AppDatabase db;

  setUp(() {
    db = AppDatabase(NativeDatabase.memory());
  });

  tearDown(() async {
    await db.close();
  });

  test('inserts and reads an account', () async {
    await db.into(db.accounts).insert(
          AccountsCompanion.insert(
            id: 'a1',
            name: 'Conta Corrente',
            type: 'checking',
            currentBalanceMinor: 12345,
            initialBalanceMinor: 0,
            currency: 'BRL',
            color: '#0B6E4F',
            icon: 'wallet',
            createdAt: DateTime(2026, 1, 1),
          ),
        );

    final rows = await db.select(db.accounts).get();
    expect(rows, hasLength(1));
    expect(rows.first.name, 'Conta Corrente');
    expect(rows.first.currentBalanceMinor, 12345);
    expect(rows.first.isActive, isTrue);
  });

  test('inserts a transaction and an installment', () async {
    await db.into(db.transactions).insert(
          TransactionsCompanion.insert(
            id: 't1',
            description: 'Aluguel',
            amountMinor: 120000,
            currency: 'BRL',
            type: 'expense',
            accountId: 'a1',
            date: DateTime(2026, 9, 5),
            createdAt: DateTime(2026, 9, 5),
            updatedAt: DateTime(2026, 9, 5),
          ),
        );

    await db.into(db.installments).insert(
          InstallmentsCompanion.insert(
            id: 'i1',
            transactionId: 't1',
            number: 1,
            totalInstallments: 6,
            amountMinor: 20000,
            currency: 'BRL',
            dueDate: DateTime(2026, 9, 5),
          ),
        );

    final transactions = await db.select(db.transactions).get();
    final installments = await db.select(db.installments).get();

    expect(transactions, hasLength(1));
    expect(transactions.first.paymentStatus, 'paid');
    expect(installments, hasLength(1));
    expect(installments.first.number, 1);
    expect(installments.first.totalInstallments, 6);
  });
}
