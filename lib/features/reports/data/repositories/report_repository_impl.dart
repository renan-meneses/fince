import '../../../../core/constants/app_constants.dart';
import '../../../../core/domain/money.dart';
import '../../../../core/utils/date_utils.dart';
import '../../../accounts/domain/entities/account.dart';
import '../../../accounts/domain/repositories/account_repository.dart';
import '../../../categories/domain/entities/category.dart';
import '../../../categories/domain/repositories/category_repository.dart';
import '../../../transactions/domain/entities/transaction.dart';
import '../../../transactions/domain/entities/transaction_filter.dart';
import '../../../transactions/domain/repositories/transaction_repository.dart';
import '../../domain/entities/report_entities.dart';
import '../../domain/repositories/report_repository.dart';

/// Local-first [ReportRepository] built on read-only aggregations.
class ReportRepositoryImpl implements ReportRepository {
  ReportRepositoryImpl({
    required TransactionRepository transactions,
    required CategoryRepository categories,
    required AccountRepository accounts,
  })  : _transactions = transactions,
        _categories = categories,
        _accounts = accounts;

  final TransactionRepository _transactions;
  final CategoryRepository _categories;
  final AccountRepository _accounts;

  // Reports aggregate full datasets; a large limit avoids pagination here.
  static const _reportLimit = 100000;

  @override
  Future<IncomeExpenseReport> getIncomeVsExpense({
    required DateTime start,
    required DateTime end,
  }) async {
    final txs = await _transactions.getTransactions(
      filter: TransactionFilter(startDate: start, endDate: end),
      limit: _reportLimit,
    );
    final currency = _currencyOf(txs);
    final income = _sum(txs, TransactionType.income);
    final expenses = _sum(txs, TransactionType.expense);
    return IncomeExpenseReport(
      income: Money(income, currency),
      expenses: Money(expenses, currency),
      result: Money(income - expenses, currency),
    );
  }

  @override
  Future<List<CashFlowPoint>> getCashFlow({
    required DateTime start,
    required DateTime end,
  }) async {
    final txs = await _transactions.getTransactions(
      filter: TransactionFilter(startDate: start, endDate: end),
      limit: _reportLimit,
    );
    final currency = _currencyOf(txs);

    final byMonth = <String, ({int income, int expenses})>{};
    for (final t in txs) {
      final key = monthKey(t.date);
      final current = byMonth[key] ?? (income: 0, expenses: 0);
      byMonth[key] = switch (t.type) {
        TransactionType.income => (income: current.income + t.amount.minorUnits, expenses: current.expenses),
        TransactionType.expense => (income: current.income, expenses: current.expenses + t.amount.minorUnits),
        TransactionType.transfer => current,
      };
    }

    final keys = byMonth.keys.toList()..sort();
    return keys
        .map(
          (key) => CashFlowPoint(
            period: key,
            income: Money(byMonth[key]!.income, currency),
            expenses: Money(byMonth[key]!.expenses, currency),
          ),
        )
        .toList();
  }

  @override
  Future<List<CategoryReport>> getExpensesByCategory({
    required DateTime start,
    required DateTime end,
  }) async {
    final txs = await _transactions.getTransactions(
      filter: TransactionFilter(
        type: TransactionType.expense,
        startDate: start,
        endDate: end,
      ),
      limit: _reportLimit,
    );
    final categories = await _categories.watchCategories().first;
    final currency = _currencyOf(txs);

    final totals = <String, int>{};
    for (final t in txs) {
      final key = t.categoryId ?? '__none__';
      totals[key] = (totals[key] ?? 0) + t.amount.minorUnits;
    }
    final totalExpense = totals.values.fold(0, (a, b) => a + b);

    final result = totals.entries.map((entry) {
      final category = _findCategory(categories, entry.key);
      return CategoryReport(
        categoryId: entry.key,
        name: category?.name ?? 'Sem categoria',
        color: category?.color ?? '#64748B',
        total: Money(entry.value, currency),
        percent: totalExpense == 0 ? 0 : entry.value / totalExpense,
      );
    }).toList()
      ..sort((a, b) => b.total.compareTo(a.total));
    return result;
  }

  @override
  Future<List<AccountReport>> getExpensesByAccount({
    required DateTime start,
    required DateTime end,
  }) async {
    final txs = await _transactions.getTransactions(
      filter: TransactionFilter(
        type: TransactionType.expense,
        startDate: start,
        endDate: end,
      ),
      limit: _reportLimit,
    );
    final accounts = await _accounts.watchAccounts().first;
    final currency = _currencyOf(txs);

    final totals = <String, int>{};
    for (final t in txs) {
      totals[t.accountId] = (totals[t.accountId] ?? 0) + t.amount.minorUnits;
    }

    final result = totals.entries.map((entry) {
      final account = _findAccount(accounts, entry.key);
      return AccountReport(
        accountId: entry.key,
        name: account?.name ?? entry.key,
        total: Money(entry.value, currency),
      );
    }).toList()
      ..sort((a, b) => b.total.compareTo(a.total));
    return result;
  }

  int _sum(List<Transaction> txs, TransactionType type) => txs
      .where((t) => t.type == type)
      .fold(0, (sum, t) => sum + t.amount.minorUnits);

  String _currencyOf(List<Transaction> txs) =>
      txs.isEmpty ? AppConstants.defaultCurrency : txs.first.amount.currency;

  Category? _findCategory(List<Category> categories, String id) {
    for (final c in categories) {
      if (c.id == id) return c;
    }
    return null;
  }

  Account? _findAccount(List<Account> accounts, String id) {
    for (final a in accounts) {
      if (a.id == id) return a;
    }
    return null;
  }
}
