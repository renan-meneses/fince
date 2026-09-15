import 'package:drift/native.dart';
import 'package:fince/core/domain/money.dart';
import 'package:fince/core/storage/app_database.dart';
import 'package:fince/features/accounts/data/datasources/account_local_data_source.dart';
import 'package:fince/features/accounts/data/repositories/account_repository_impl.dart';
import 'package:fince/features/accounts/domain/entities/account.dart';
import 'package:fince/features/categories/data/datasources/category_local_data_source.dart';
import 'package:fince/features/categories/data/repositories/category_repository_impl.dart';
import 'package:fince/features/categories/domain/entities/category.dart';
import 'package:fince/features/dashboard/data/repositories/dashboard_repository_impl.dart';
import 'package:fince/features/transactions/data/datasources/transaction_local_data_source.dart';
import 'package:fince/features/transactions/data/repositories/transaction_repository_impl.dart';
import 'package:fince/features/transactions/domain/entities/transaction.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:uuid/uuid.dart';

void main() {
  late AppDatabase db;
  late AccountLocalDataSource accounts;
  late TransactionLocalDataSource transactions;
  late CategoryLocalDataSource categories;
  late DashboardRepositoryImpl dashboard;

  setUp(() {
    db = AppDatabase(NativeDatabase.memory());
    accounts = AccountLocalDataSource(db);
    transactions = TransactionLocalDataSource(db);
    categories = CategoryLocalDataSource(db);
    dashboard = DashboardRepositoryImpl(
      accounts: AccountRepositoryImpl(local: accounts),
      transactions: TransactionRepositoryImpl(local: transactions),
      categories: CategoryRepositoryImpl(local: categories),
    );
  });

  tearDown(() async {
    await db.close();
  });

  Future<String> createAccount(int balance) async {
    final account = Account(
      id: const Uuid().v4(),
      name: 'Conta',
      type: AccountType.checking,
      currentBalance: Money(balance, 'BRL'),
      initialBalance: Money(balance, 'BRL'),
      currency: 'BRL',
      color: '#0B6E4F',
      icon: 'bank',
      createdAt: DateTime.now().toUtc(),
      isActive: true,
    );
    await accounts.insert(account);
    return account.id;
  }

  Future<void> createCategory(String id, String name) async {
    await categories.insert(
      Category(
        id: id,
        name: name,
        type: CategoryType.expense,
        icon: 'restaurant',
        color: '#E64A19',
        isDefault: false,
      ),
    );
  }

  Future<void> createTransaction(
    String accountId, {
    required int amount,
    required TransactionType type,
    String? categoryId,
    required DateTime date,
  }) async {
    final now = DateTime.now().toUtc();
    await transactions.create(
      Transaction(
        id: const Uuid().v4(),
        description: 'Teste',
        amount: Money(amount, 'BRL'),
        type: type,
        accountId: accountId,
        categoryId: categoryId,
        date: date,
        paymentStatus: PaymentStatus.paid,
        tags: const [],
        createdAt: now,
        updatedAt: now,
      ),
    );
  }

  test('aggregates balances, income, expenses, and category breakdown',
      () async {
    final accountId = await createAccount(100000);
    await createCategory('cat1', 'Alimentação');
    await createTransaction(
      accountId,
      amount: 50000,
      type: TransactionType.income,
      date: DateTime(2026, 9, 1),
    );
    await createTransaction(
      accountId,
      amount: 20000,
      type: TransactionType.expense,
      categoryId: 'cat1',
      date: DateTime(2026, 9, 5),
    );

    final overview = await dashboard
        .watchOverview(start: DateTime(2026, 9, 1), end: DateTime(2026, 10, 1))
        .firstWhere(
          (o) =>
              o.income == Money(50000, 'BRL') &&
              o.expenses == Money(20000, 'BRL') &&
              o.expensesByCategory.isNotEmpty &&
              o.expensesByCategory.first.name == 'Alimentação',
        );

    expect(overview.totalBalance, Money(130000, 'BRL'));
    expect(overview.result, Money(30000, 'BRL'));
    expect(overview.recentTransactions, hasLength(2));
    expect(overview.expensesByCategory, hasLength(1));
    expect(overview.expensesByCategory.first.name, 'Alimentação');
    expect(overview.expensesByCategory.first.total, Money(20000, 'BRL'));
  });
}
