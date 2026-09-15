import 'dart:async';

import '../../../../core/domain/money.dart';
import '../../../../core/errors/exception_to_failure.dart';
import '../../../categories/domain/entities/category.dart';
import '../../../categories/domain/repositories/category_repository.dart';
import '../../../transactions/domain/entities/transaction.dart';
import '../../../transactions/domain/entities/transaction_filter.dart';
import '../../../transactions/domain/repositories/transaction_repository.dart';
import '../../domain/entities/budget.dart';
import '../../domain/entities/budget_status.dart';
import '../../domain/repositories/budget_repository.dart';
import '../datasources/budget_local_data_source.dart';

/// Local-first [BudgetRepository]. Spending is derived reactively from
/// transactions and combined with category metadata.
class BudgetRepositoryImpl implements BudgetRepository {
  BudgetRepositoryImpl({
    required BudgetLocalDataSource local,
    required TransactionRepository transactions,
    required CategoryRepository categories,
  })  : _local = local,
        _transactions = transactions,
        _categories = categories;

  final BudgetLocalDataSource _local;
  final TransactionRepository _transactions;
  final CategoryRepository _categories;

  @override
  Stream<List<BudgetStatus>> watchBudgets(String month) {
    final start = DateTime.parse('$month-01');
    final end = DateTime(start.year, start.month + 1, 1);
    final filter = TransactionFilter(
      type: TransactionType.expense,
      startDate: start,
      endDate: end,
    );

    final controller = StreamController<List<BudgetStatus>>();
    var budgets = const <Budget>[];
    var transactions = const <Transaction>[];
    var categories = const <Category>[];

    void emit() {
      if (!controller.isClosed) {
        controller.add(_compute(budgets, transactions, categories));
      }
    }

    final subscriptions = <StreamSubscription<dynamic>>[
      _local.watchAll(month).listen((v) {
        budgets = v;
        emit();
      }),
      _transactions.watchTransactions(filter: filter).listen((v) {
        transactions = v;
        emit();
      }),
      _categories.watchCategories().listen((v) {
        categories = v;
        emit();
      }),
    ];

    controller.onCancel = () {
      for (final s in subscriptions) {
        s.cancel();
      }
    };

    return controller.stream;
  }

  @override
  Future<Budget> createBudget(Budget budget) async {
    try {
      return await _local.insert(budget);
    } catch (e) {
      throw mapExceptionToFailure(e);
    }
  }

  @override
  Future<Budget> updateBudget(Budget budget) async {
    try {
      return await _local.update(budget);
    } catch (e) {
      throw mapExceptionToFailure(e);
    }
  }

  @override
  Future<void> deleteBudget(String id) async {
    try {
      await _local.delete(id);
    } catch (e) {
      throw mapExceptionToFailure(e);
    }
  }

  List<BudgetStatus> _compute(
    List<Budget> budgets,
    List<Transaction> transactions,
    List<Category> categories,
  ) {
    return budgets.map((budget) {
      var spentMinor = 0;
      for (final t in transactions) {
        if (t.categoryId == budget.categoryId &&
            t.amount.currency == budget.currency) {
          spentMinor += t.amount.minorUnits;
        }
      }
      final spent = Money(spentMinor, budget.currency);
      final category = _findCategory(categories, budget.categoryId);
      return BudgetStatus(
        budget: budget,
        categoryName: category?.name ?? 'Sem categoria',
        categoryColor: category?.color ?? '#64748B',
        categoryIcon: category?.icon ?? 'more_horiz',
        spent: spent,
        remaining: budget.amount - spent,
        percentUsed: budget.amount.isZero
            ? 0
            : spentMinor / budget.amount.minorUnits,
      );
    }).toList();
  }

  Category? _findCategory(List<Category> categories, String id) {
    for (final c in categories) {
      if (c.id == id) return c;
    }
    return null;
  }
}
