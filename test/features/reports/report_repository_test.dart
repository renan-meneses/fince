import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:fince/core/domain/money.dart';
import 'package:fince/core/storage/app_database.dart';
import 'package:fince/features/accounts/data/datasources/account_local_data_source.dart';
import 'package:fince/features/accounts/data/repositories/account_repository_impl.dart';
import 'package:fince/features/categories/data/datasources/category_local_data_source.dart';
import 'package:fince/features/categories/data/repositories/category_repository_impl.dart';
import 'package:fince/features/categories/domain/entities/category.dart';
import 'package:fince/features/reports/data/repositories/report_repository_impl.dart';
import 'package:fince/features/transactions/data/datasources/transaction_local_data_source.dart';
import 'package:fince/features/transactions/data/repositories/transaction_repository_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:uuid/uuid.dart';

void main() {
  late AppDatabase db;
  late CategoryLocalDataSource categories;
  late ReportRepositoryImpl repository;

  setUp(() {
    db = AppDatabase(NativeDatabase.memory());
    categories = CategoryLocalDataSource(db);
    repository = ReportRepositoryImpl(
      transactions: TransactionRepositoryImpl(
        local: TransactionLocalDataSource(db),
      ),
      categories: CategoryRepositoryImpl(local: categories),
      accounts: AccountRepositoryImpl(local: AccountLocalDataSource(db)),
    );
  });

  tearDown(() async {
    await db.close();
  });

  Future<void> insertTransaction({
    required int amount,
    required String type,
    String? categoryId,
    required DateTime date,
  }) async {
    final now = DateTime.now().toUtc();
    await db.into(db.transactions).insert(
          TransactionsCompanion.insert(
            id: const Uuid().v4(),
            description: 'Teste',
            amountMinor: amount,
            currency: 'BRL',
            type: type,
            accountId: 'acc1',
            categoryId: Value(categoryId),
            date: date,
            createdAt: now,
            updatedAt: now,
          ),
        );
  }

  test('reports aggregate income, expenses, and category breakdown', () async {
    await categories.insert(
      const Category(
        id: 'cat1',
        name: 'Alimentação',
        type: CategoryType.expense,
        icon: 'restaurant',
        color: '#E64A19',
        isDefault: false,
      ),
    );

    await insertTransaction(
      amount: 50000,
      type: 'income',
      date: DateTime(2026, 9, 1),
    );
    await insertTransaction(
      amount: 30000,
      type: 'expense',
      categoryId: 'cat1',
      date: DateTime(2026, 9, 5),
    );
    await insertTransaction(
      amount: 20000,
      type: 'expense',
      categoryId: 'cat1',
      date: DateTime(2026, 9, 6),
    );

    final summary = await repository.getIncomeVsExpense(
      start: DateTime(2026, 9, 1),
      end: DateTime(2026, 10, 1),
    );
    expect(summary.income, Money(50000, 'BRL'));
    expect(summary.expenses, Money(50000, 'BRL'));
    expect(summary.result, Money(0, 'BRL'));

    final byCategory = await repository.getExpensesByCategory(
      start: DateTime(2026, 9, 1),
      end: DateTime(2026, 10, 1),
    );
    expect(byCategory, hasLength(1));
    expect(byCategory.first.total, Money(50000, 'BRL'));
    expect(byCategory.first.name, 'Alimentação');

    final cashFlow = await repository.getCashFlow(
      start: DateTime(2026, 9, 1),
      end: DateTime(2026, 10, 1),
    );
    expect(cashFlow, hasLength(1));
    expect(cashFlow.first.income, Money(50000, 'BRL'));
    expect(cashFlow.first.expenses, Money(50000, 'BRL'));
  });
}
