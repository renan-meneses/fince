import 'package:drift/native.dart';
import 'package:fince/core/domain/money.dart';
import 'package:fince/core/storage/app_database.dart';
import 'package:fince/features/accounts/data/datasources/account_local_data_source.dart';
import 'package:fince/features/accounts/domain/entities/account.dart';
import 'package:fince/features/recurring_transactions/data/datasources/recurring_transaction_local_data_source.dart';
import 'package:fince/features/recurring_transactions/data/repositories/recurring_transaction_repository_impl.dart';
import 'package:fince/features/recurring_transactions/domain/entities/recurring_transaction.dart';
import 'package:fince/features/recurring_transactions/domain/usecases/create_recurring_transaction.dart';
import 'package:fince/features/recurring_transactions/domain/usecases/generate_due_occurrences.dart';
import 'package:fince/features/transactions/data/datasources/transaction_local_data_source.dart';
import 'package:fince/features/transactions/domain/entities/transaction.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:uuid/uuid.dart';

void main() {
  late AppDatabase db;
  late AccountLocalDataSource accounts;
  late TransactionLocalDataSource transactions;
  late RecurringTransactionLocalDataSource recurring;
  late CreateRecurringTransaction createRecurring;
  late GenerateDueOccurrences generate;

  setUp(() {
    db = AppDatabase(NativeDatabase.memory());
    accounts = AccountLocalDataSource(db);
    transactions = TransactionLocalDataSource(db);
    recurring = RecurringTransactionLocalDataSource(db, transactions);
    final repository = RecurringTransactionRepositoryImpl(local: recurring);
    createRecurring = CreateRecurringTransaction(repository);
    generate = GenerateDueOccurrences(repository);
  });

  tearDown(() async {
    await db.close();
  });

  test('generates due occurrences idempotently without duplicates', () async {
    final account = Account(
      id: const Uuid().v4(),
      name: 'Conta',
      type: AccountType.checking,
      currentBalance: Money(0, 'BRL'),
      initialBalance: Money(0, 'BRL'),
      currency: 'BRL',
      color: '#0B6E4F',
      icon: 'bank',
      createdAt: DateTime.now().toUtc(),
      isActive: true,
    );
    await accounts.insert(account);

    await createRecurring(
      description: 'Salário',
      amount: Money(50000, 'BRL'),
      type: TransactionType.income,
      accountId: account.id,
      rule: const RecurrenceRule(
        frequency: RecurrenceFrequency.monthly,
        dayOfMonth: 1,
      ),
      startDate: DateTime(2026, 1, 1),
    );

    final generated = await generate(DateTime(2026, 3, 15));
    expect(generated, 3);

    final first = await db.select(db.transactions).get();
    expect(first, hasLength(3));

    final again = await generate(DateTime(2026, 3, 15));
    expect(again, 0);
    expect((await db.select(db.transactions).get()), hasLength(3));

    final accountRow = await (db.select(db.accounts)
          ..where((a) => a.id.equals(account.id)))
        .getSingle();
    expect(accountRow.currentBalanceMinor, 150000);
  });
}
