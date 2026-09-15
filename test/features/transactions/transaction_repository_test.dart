import 'package:drift/native.dart';
import 'package:fince/core/domain/money.dart';
import 'package:fince/core/storage/app_database.dart';
import 'package:fince/features/accounts/data/datasources/account_local_data_source.dart';
import 'package:fince/features/accounts/domain/entities/account.dart';
import 'package:fince/features/transactions/data/datasources/transaction_local_data_source.dart';
import 'package:fince/features/transactions/data/repositories/transaction_repository_impl.dart';
import 'package:fince/features/transactions/domain/entities/transaction.dart';
import 'package:fince/features/transactions/domain/usecases/create_transaction.dart';
import 'package:fince/features/transactions/domain/usecases/delete_transaction.dart';
import 'package:fince/features/transactions/domain/usecases/duplicate_transaction.dart';
import 'package:fince/features/transactions/domain/usecases/update_transaction.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:uuid/uuid.dart';

void main() {
  late AppDatabase db;
  late AccountLocalDataSource accounts;
  late TransactionLocalDataSource transactions;
  late CreateTransaction createTransaction;
  late UpdateTransaction updateTransaction;
  late DeleteTransaction deleteTransaction;
  late DuplicateTransaction duplicateTransaction;

  setUp(() {
    db = AppDatabase(NativeDatabase.memory());
    accounts = AccountLocalDataSource(db);
    transactions = TransactionLocalDataSource(db);
    final repository = TransactionRepositoryImpl(local: transactions);
    createTransaction = CreateTransaction(repository);
    updateTransaction = UpdateTransaction(repository);
    deleteTransaction = DeleteTransaction(repository);
    duplicateTransaction = DuplicateTransaction(repository);
  });

  tearDown(() async {
    await db.close();
  });

  Future<String> createAccount(String name, int balanceMinor) async {
    final account = Account(
      id: const Uuid().v4(),
      name: name,
      type: AccountType.checking,
      currentBalance: Money(balanceMinor, 'BRL'),
      initialBalance: Money(balanceMinor, 'BRL'),
      currency: 'BRL',
      color: '#0B6E4F',
      icon: 'bank',
      createdAt: DateTime.now().toUtc(),
      isActive: true,
    );
    await accounts.insert(account);
    return account.id;
  }

  Future<int> balanceOf(String accountId) async {
    final row = await (db.select(db.accounts)
          ..where((a) => a.id.equals(accountId)))
        .getSingle();
    return row.currentBalanceMinor;
  }

  test('income transaction credits the account balance', () async {
    final accountId = await createAccount('Conta', 100000);

    await createTransaction(
      description: 'Salário',
      amount: Money(50000, 'BRL'),
      type: TransactionType.income,
      accountId: accountId,
      date: DateTime(2026, 9, 1),
    );

    expect(await balanceOf(accountId), 150000);
    final rows = await db.select(db.transactions).get();
    expect(rows, hasLength(1));
    expect(rows.first.type, 'income');
  });

  test('expense transaction debits the account balance', () async {
    final accountId = await createAccount('Conta', 100000);

    await createTransaction(
      description: 'Aluguel',
      amount: Money(20000, 'BRL'),
      type: TransactionType.expense,
      accountId: accountId,
      date: DateTime(2026, 9, 5),
    );

    expect(await balanceOf(accountId), 80000);
  });

  test('updating a transaction rebalances the account', () async {
    final accountId = await createAccount('Conta', 100000);
    final created = await createTransaction(
      description: 'Salário',
      amount: Money(50000, 'BRL'),
      type: TransactionType.income,
      accountId: accountId,
      date: DateTime(2026, 9, 1),
    );

    await updateTransaction(
      created.copyWith(amount: Money(30000, 'BRL')),
    );

    expect(await balanceOf(accountId), 130000);
  });

  test('deleting a transaction reverses its balance effect', () async {
    final accountId = await createAccount('Conta', 100000);
    final created = await createTransaction(
      description: 'Salário',
      amount: Money(50000, 'BRL'),
      type: TransactionType.income,
      accountId: accountId,
      date: DateTime(2026, 9, 1),
    );

    await deleteTransaction(created.id);

    expect(await balanceOf(accountId), 100000);
    final rows = await db.select(db.transactions).get();
    expect(rows, isEmpty);
  });

  test('duplicating creates a copy with a new id', () async {
    final accountId = await createAccount('Conta', 100000);
    final created = await createTransaction(
      description: 'Netflix',
      amount: Money(3990, 'BRL'),
      type: TransactionType.expense,
      accountId: accountId,
      date: DateTime(2026, 9, 1),
    );

    final copy = await duplicateTransaction(created.id);

    expect(copy.id, isNot(created.id));
    expect(copy.description, created.description);
    expect(copy.paymentStatus, PaymentStatus.pending);
    expect(await db.select(db.transactions).get(), hasLength(2));
  });
}
