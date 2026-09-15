import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:fince/core/domain/money.dart';
import 'package:fince/core/storage/app_database.dart';
import 'package:fince/features/budgets/data/datasources/budget_local_data_source.dart';
import 'package:fince/features/budgets/data/repositories/budget_repository_impl.dart';
import 'package:fince/features/budgets/domain/entities/budget.dart';
import 'package:fince/features/categories/data/datasources/category_local_data_source.dart';
import 'package:fince/features/categories/data/repositories/category_repository_impl.dart';
import 'package:fince/features/categories/domain/entities/category.dart';
import 'package:fince/features/transactions/data/datasources/transaction_local_data_source.dart';
import 'package:fince/features/transactions/data/repositories/transaction_repository_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:uuid/uuid.dart';

void main() {
  late AppDatabase db;
  late CategoryLocalDataSource categories;
  late BudgetLocalDataSource budgetLocal;
  late BudgetRepositoryImpl repository;

  setUp(() {
    db = AppDatabase(NativeDatabase.memory());
    categories = CategoryLocalDataSource(db);
    budgetLocal = BudgetLocalDataSource(db);
    repository = BudgetRepositoryImpl(
      local: budgetLocal,
      transactions: TransactionRepositoryImpl(
        local: TransactionLocalDataSource(db),
      ),
      categories: CategoryRepositoryImpl(local: categories),
    );
  });

  tearDown(() async {
    await db.close();
  });

  test('computes budget spent, remaining, and percentage', () async {
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
    await budgetLocal.insert(
      Budget(
        id: 'b1',
        categoryId: 'cat1',
        amount: Money(100000, 'BRL'),
        currency: 'BRL',
        month: '2026-09',
        createdAt: DateTime.now().toUtc(),
      ),
    );

    final now = DateTime.now().toUtc();
    for (final amount in [30000, 20000]) {
      await db.into(db.transactions).insert(
            TransactionsCompanion.insert(
              id: const Uuid().v4(),
              description: 'Compra',
              amountMinor: amount,
              currency: 'BRL',
              type: 'expense',
              accountId: 'acc1',
              categoryId: const Value('cat1'),
              date: DateTime(2026, 9, 5),
              createdAt: now,
              updatedAt: now,
            ),
          );
    }

    final statuses = await repository
        .watchBudgets('2026-09')
        .firstWhere(
          (s) =>
              s.isNotEmpty &&
              s.first.spent == Money(50000, 'BRL') &&
              s.first.categoryName == 'Alimentação',
        );

    final status = statuses.first;
    expect(status.spent, Money(50000, 'BRL'));
    expect(status.remaining, Money(50000, 'BRL'));
    expect(status.percentUsed, 0.5);
    expect(status.categoryName, 'Alimentação');
  });
}
