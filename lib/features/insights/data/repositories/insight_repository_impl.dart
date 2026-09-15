import '../../../../core/constants/app_constants.dart';
import '../../../../core/domain/money.dart';
import '../../../budgets/domain/repositories/budget_repository.dart';
import '../../../categories/domain/entities/category.dart';
import '../../../categories/domain/repositories/category_repository.dart';
import '../../../transactions/domain/entities/transaction.dart';
import '../../../transactions/domain/entities/transaction_filter.dart';
import '../../../transactions/domain/repositories/transaction_repository.dart';
import '../../domain/entities/financial_insight.dart';
import '../../domain/entities/financial_snapshot.dart';
import '../../domain/repositories/financial_assistant_repository.dart';
import '../../domain/repositories/insight_repository.dart';

/// Builds a [FinancialSnapshot] from app data and delegates to an assistant.
class InsightRepositoryImpl implements InsightRepository {
  InsightRepositoryImpl({
    required TransactionRepository transactions,
    required CategoryRepository categories,
    required BudgetRepository budgets,
    required FinancialAssistantRepository assistant,
  })  : _transactions = transactions,
        _categories = categories,
        _budgets = budgets,
        _assistant = assistant;

  final TransactionRepository _transactions;
  final CategoryRepository _categories;
  final BudgetRepository _budgets;
  final FinancialAssistantRepository _assistant;

  static const _limit = 100000;

  @override
  Future<List<FinancialInsight>> generateInsights({
    required String month,
  }) async {
    final start = DateTime.parse('$month-01');
    final end = DateTime(start.year, start.month + 1, 1);
    final previousStart = DateTime(start.year, start.month - 1, 1);

    final current = await _transactions.getTransactions(
      filter: TransactionFilter(startDate: start, endDate: end),
      limit: _limit,
    );
    final previous = await _transactions.getTransactions(
      filter: TransactionFilter(startDate: previousStart, endDate: start),
      limit: _limit,
    );
    final categories = await _categories.watchCategories().first;
    final budgets = await _budgets.watchBudgets(month).first;

    final currency = current.isEmpty
        ? AppConstants.defaultCurrency
        : current.first.amount.currency;

    final income = _sum(current, TransactionType.income);
    final expenses = _sum(current, TransactionType.expense);

    final snapshot = FinancialSnapshot(
      period: month,
      income: Money(income, currency),
      expenses: Money(expenses, currency),
      expensesByCategory: _group(current, categories, currency),
      previousExpensesByCategory: _group(previous, categories, currency),
      budgets: budgets
          .map(
            (b) => BudgetUsage(
              name: b.categoryName,
              spent: b.spent,
              limit: b.budget.amount,
            ),
          )
          .toList(),
    );

    return _assistant.generateInsights(snapshot);
  }

  int _sum(List<Transaction> txs, TransactionType type) => txs
      .where((t) => t.type == type)
      .fold(0, (sum, t) => sum + t.amount.minorUnits);

  List<CategorySpend> _group(
    List<Transaction> txs,
    List<Category> categories,
    String currency,
  ) {
    final totals = <String, int>{};
    for (final t in txs) {
      if (t.type != TransactionType.expense) continue;
      final key = t.categoryId ?? '__none__';
      totals[key] = (totals[key] ?? 0) + t.amount.minorUnits;
    }
    return totals.entries.map((entry) {
      final category = _findCategory(categories, entry.key);
      return CategorySpend(
        name: category?.name ?? 'Sem categoria',
        amount: Money(entry.value, currency),
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
