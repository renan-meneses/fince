import 'package:drift/native.dart';
import 'package:fince/core/domain/money.dart';
import 'package:fince/core/errors/failure.dart';
import 'package:fince/core/storage/app_database.dart';
import 'package:fince/features/accounts/data/datasources/account_local_data_source.dart';
import 'package:fince/features/accounts/data/repositories/account_repository_impl.dart';
import 'package:fince/features/accounts/domain/entities/account.dart';
import 'package:fince/features/accounts/domain/usecases/create_account.dart';
import 'package:fince/features/accounts/domain/usecases/transfer_between_accounts.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late AppDatabase db;
  late AccountLocalDataSource local;
  late CreateAccount createAccount;
  late TransferBetweenAccounts transfer;

  setUp(() {
    db = AppDatabase(NativeDatabase.memory());
    local = AccountLocalDataSource(db);
    final repository = AccountRepositoryImpl(local: local);
    createAccount = CreateAccount(repository);
    transfer = TransferBetweenAccounts(repository);
  });

  tearDown(() async {
    await db.close();
  });

  Future<Account> makeAccount(String name, {int balanceMinor = 0}) =>
      createAccount(
        name: name,
        type: AccountType.checking,
        initialBalance: Money(balanceMinor, 'BRL'),
        color: '#0B6E4F',
        icon: 'bank',
      );

  test('transfer preserves net worth and records a transaction', () async {
    final from = await makeAccount('Corrente', balanceMinor: 100000);
    final to = await makeAccount('Poupança', balanceMinor: 50000);

    await transfer(
      fromAccountId: from.id,
      toAccountId: to.id,
      amount: Money(30000, 'BRL'),
    );

    final accounts = await local.getAll();
    final fromAfter = accounts.firstWhere((a) => a.id == from.id);
    final toAfter = accounts.firstWhere((a) => a.id == to.id);

    expect(fromAfter.currentBalance, Money(70000, 'BRL'));
    expect(toAfter.currentBalance, Money(80000, 'BRL'));
    expect(
      fromAfter.currentBalance.minorUnits + toAfter.currentBalance.minorUnits,
      150000,
    );

    final transactions = await db.select(db.transactions).get();
    expect(transactions, hasLength(1));
    expect(transactions.first.type, 'transfer');
    expect(transactions.first.accountId, from.id);
    expect(transactions.first.transferAccountId, to.id);
  });

  test('rejects a transfer between the same account', () async {
    final account = await makeAccount('A', balanceMinor: 100000);

    expect(
      () => transfer(
        fromAccountId: account.id,
        toAccountId: account.id,
        amount: Money(1000, 'BRL'),
      ),
      throwsA(isA<ValidationFailure>()),
    );
  });

  test('rejects a cross-currency transfer', () async {
    final from = await makeAccount('BRL', balanceMinor: 100000);
    final to = await createAccount(
      name: 'USD',
      type: AccountType.checking,
      initialBalance: Money(0, 'USD'),
      color: '#0B6E4F',
      icon: 'bank',
    );

    await expectLater(
      transfer(
        fromAccountId: from.id,
        toAccountId: to.id,
        amount: Money(1000, 'BRL'),
      ),
      throwsA(isA<ValidationFailure>()),
    );
  });
}
