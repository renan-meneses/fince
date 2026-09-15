import 'dart:async';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/domain/money.dart';
import '../../../accounts/domain/entities/account.dart';
import '../../../accounts/domain/repositories/account_repository.dart';
import '../../../categories/domain/entities/category.dart';
import '../../../categories/domain/repositories/category_repository.dart';
import '../../../transactions/domain/entities/transaction.dart';
import '../../../transactions/domain/entities/transaction_filter.dart';
import '../../../transactions/domain/repositories/transaction_repository.dart';
import '../../domain/entities/financial_overview.dart';
import '../../domain/repositories/dashboard_repository.dart';

/// Aggregates accounts, transactions, and categories into a reactive
/// [FinancialOverview].
class DashboardRepositoryImpl implements DashboardRepository {
  DashboardRepositoryImpl({
    required AccountRepository accounts,
    required TransactionRepository transactions,
    required CategoryRepository categories,
  })  : _accounts = accounts,
        _transactions = transactions,
        _categories = categories;

  final AccountRepository _accounts;
  final TransactionRepository _transactions;
  final CategoryRepository _categories;

  @override
  Stream<FinancialOverview> watchOverview({
    required DateTime start,
    required DateTime end,
  }) {
    final currentFilter = TransactionFilter(startDate: start, endDate: end);
    final previousStart = start.subtract(end.difference(start));
    final previousFilter = TransactionFilter(
      startDate: previousStart,
      endDate: start,
    );

    final controller = StreamController<FinancialOverview>();

    var accounts = const <Account>[];
    var current = const <Transaction>[];
    var previous = const <Transaction>[];
    var categories = const <Category>[];

    void emit() {
      if (!controller.isClosed) {
        controller.add(
          _compute(
            accounts: accounts,
            current: current,
            previous: previous,
            categories: categories,
          ),
        );
      }
    }

    final subscriptions = <StreamSubscription<dynamic>>[
      _accounts.watchAccounts().listen((v) {
        accounts = v;
        emit();
      }),
      _transactions.watchTransactions(filter: currentFilter).listen((v) {
        current = v;
        emit();
      }),
      _transactions.watchTransactions(filter: previousFilter).listen((v) {
        previous = v;
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

  FinancialOverview _compute({
    required List<Account> accounts,
    required List<Transaction> current,
    required List<Transaction> previous,
    required List<Category> categories,
  }) {
    final currency = accounts.isNotEmpty
        ? accounts.first.currency
        : AppConstants.defaultCurrency;

    int sumOf(Iterable<Transaction> txs, TransactionType type) => txs
        .where((t) => t.type == type && t.amount.currency == currency)
        .fold(0, (sum, t) => sum + t.amount.minorUnits);

    final totalBalance = accounts
        .where((a) => a.currency == currency)
        .fold(0, (sum, a) => sum + a.currentBalance.minorUnits);

    final income = sumOf(current, TransactionType.income);
    final expenses = sumOf(current, TransactionType.expense);
    final result = income - expenses;

    final previousIncome = sumOf(previous, TransactionType.income);
    final previousExpenses = sumOf(previous, TransactionType.expense);
    final previousResult = previousIncome - previousExpenses;
    final variation = previousResult == 0
        ? null
        : (result - previousResult) / previousResult.abs();

    final sorted = [...current]..sort((a, b) => b.date.compareTo(a.date));

    final totalsByCategory = <String, int>{};
    for (final t in current) {
      if (t.type == TransactionType.expense && t.amount.currency == currency) {
        final key = t.categoryId ?? '__none__';
        totalsByCategory[key] = (totalsByCategory[key] ?? 0) + t.amount.minorUnits;
      }
    }

    final categoryTotals = totalsByCategory.entries.map((entry) {
      final category = _findCategory(categories, entry.key);
      return CategoryTotal(
        categoryId: entry.key,
        name: category?.name ?? 'Sem categoria',
        color: category?.color ?? '#64748B',
        icon: category?.icon ?? 'more_horiz',
        total: Money(entry.value, currency),
        percent: expenses == 0 ? 0 : entry.value / expenses,
      );
    }).toList()
      ..sort((a, b) => b.total.compareTo(a.total));

    return FinancialOverview(
      totalBalance: Money(totalBalance, currency),
      income: Money(income, currency),
      expenses: Money(expenses, currency),
      result: Money(result, currency),
      variationPercent: variation,
      recentTransactions: sorted.take(5).toList(),
      expensesByCategory: categoryTotals,
    );
  }

  Category? _findCategory(List<Category> categories, String id) {
    for (final c in categories) {
      if (c.id == id) return c;
    }
    return null;
  }
}
