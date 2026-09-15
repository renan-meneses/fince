import 'package:uuid/uuid.dart';

import '../../features/accounts/data/datasources/account_local_data_source.dart';
import '../../features/accounts/domain/entities/account.dart';
import '../../features/budgets/data/datasources/budget_local_data_source.dart';
import '../../features/budgets/domain/entities/budget.dart';
import '../../features/categories/data/datasources/category_local_data_source.dart';
import '../../features/categories/domain/entities/category.dart';
import '../../features/credit_cards/data/datasources/credit_card_local_data_source.dart';
import '../../features/credit_cards/domain/entities/credit_card.dart';
import '../../features/goals/data/datasources/goal_local_data_source.dart';
import '../../features/goals/domain/entities/financial_goal.dart';
import '../../features/recurring_transactions/data/datasources/recurring_transaction_local_data_source.dart';
import '../../features/recurring_transactions/domain/entities/recurring_transaction.dart';
import '../../features/transactions/data/datasources/transaction_local_data_source.dart';
import '../../features/transactions/domain/entities/transaction.dart';
import '../domain/money.dart';
import '../storage/app_database.dart';
import '../utils/date_utils.dart';

/// Seeds a realistic, internally-consistent demo dataset into the local DB.
///
/// Uses the real local data sources so every balance/ledger invariant holds
/// (income credits, expenses debit, transfers preserve net worth). Idempotent:
/// it does nothing if any account already exists.
class DemoDataSeeder {
  DemoDataSeeder({Uuid uuid = const Uuid()}) : _uuid = uuid;

  final Uuid _uuid;

  Future<void> seed(AppDatabase db) async {
    final accounts = AccountLocalDataSource(db);
    if ((await accounts.getAll()).isNotEmpty) return;

    final categories = CategoryLocalDataSource(db);
    final transactions = TransactionLocalDataSource(db);
    final creditCards = CreditCardLocalDataSource(db);
    final budgets = BudgetLocalDataSource(db);
    final goals = GoalLocalDataSource(db);
    final recurring = RecurringTransactionLocalDataSource(db, transactions);

    await categories.seedDefaults();
    final cats = await categories.watchAll().first;

    final checking =
        await _account(accounts, 'Conta Corrente', AccountType.checking, 500000);
    final savings =
        await _account(accounts, 'Poupança', AccountType.savings, 2000000);
    await _account(accounts, 'Carteira', AccountType.cash, 20000);

    final salary = _catId(cats, 'Salário');
    final rent = _catId(cats, 'Moradia');
    final food = _catId(cats, 'Alimentação');
    final transport = _catId(cats, 'Transporte');
    final subscriptions = _catId(cats, 'Assinaturas');
    final fun = _catId(cats, 'Entretenimento');
    final health = _catId(cats, 'Saúde');

    final now = DateTime.now();
    final thisMonth = _daysAgo(now, 3);
    final lastMonth = _monthAgo(now, 1);

    // Income
    await _txn(transactions, 'Salário', 750000, TransactionType.income,
        checking, salary, thisMonth);
    await _txn(transactions, 'Salário', 750000, TransactionType.income,
        checking, salary, lastMonth);

    // Expenses
    await _txn(transactions, 'Aluguel', 250000, TransactionType.expense,
        checking, rent, _daysAgo(now, 5));
    await _txn(transactions, 'Aluguel', 250000, TransactionType.expense,
        checking, rent, lastMonth);
    await _txn(transactions, 'Supermercado', 82000, TransactionType.expense,
        checking, food, _daysAgo(now, 2));
    await _txn(transactions, 'Supermercado', 74000, TransactionType.expense,
        checking, food, lastMonth);
    await _txn(transactions, 'Uber', 26000, TransactionType.expense, checking,
        transport, _daysAgo(now, 4));
    await _txn(transactions, 'Internet', 12000, TransactionType.expense,
        checking, subscriptions, _daysAgo(now, 6));
    await _txn(transactions, 'Streaming', 4500, TransactionType.expense,
        checking, subscriptions, _daysAgo(now, 7));
    await _txn(transactions, 'Cinema', 15000, TransactionType.expense, checking,
        fun, _daysAgo(now, 8));
    await _txn(transactions, 'Farmácia', 9000, TransactionType.expense,
        checking, health, _daysAgo(now, 1));

    // Transfer (net-worth neutral)
    await accounts.transfer(
      fromId: checking,
      toId: savings,
      amount: Money(100000, 'BRL'),
      date: thisMonth,
    );

    // Credit card + an installment purchase
    final card = await creditCards.insertCard(
      CreditCard(
        id: _uuid.v4(),
        name: 'Visa Gold',
        brand: CardBrand.visa,
        creditLimit: Money(800000, 'BRL'),
        availableLimit: Money(800000, 'BRL'),
        currency: 'BRL',
        closingDay: 10,
        dueDay: 5,
        linkedAccountId: checking,
        createdAt: now.toUtc(),
        isActive: true,
      ),
    );
    await creditCards.registerPurchase(
      cardId: card.id,
      description: 'Notebook',
      amount: Money(240000, 'BRL'),
      installments: 6,
      categoryId: fun,
      date: _daysAgo(now, 10),
    );

    // Budgets
    final monthKeyNow = monthKey(now);
    await budgets.insert(Budget(
      id: _uuid.v4(), categoryId: food, amount: Money(150000, 'BRL'),
      currency: 'BRL', month: monthKeyNow, createdAt: now.toUtc(),
    ));
    await budgets.insert(Budget(
      id: _uuid.v4(), categoryId: transport, amount: Money(60000, 'BRL'),
      currency: 'BRL', month: monthKeyNow, createdAt: now.toUtc(),
    ));
    await budgets.insert(Budget(
      id: _uuid.v4(), categoryId: fun, amount: Money(40000, 'BRL'),
      currency: 'BRL', month: monthKeyNow, createdAt: now.toUtc(),
    ));

    // Goals
    await goals.insert(FinancialGoal(
      id: _uuid.v4(), name: 'Fundo de emergência',
      targetAmount: Money(3000000, 'BRL'), currentAmount: Money(1500000, 'BRL'),
      currency: 'BRL', status: GoalStatus.active, createdAt: now.toUtc(),
    ));
    await goals.insert(FinancialGoal(
      id: _uuid.v4(), name: 'Viagem',
      targetAmount: Money(1000000, 'BRL'), currentAmount: Money(250000, 'BRL'),
      currency: 'BRL', status: GoalStatus.active, createdAt: now.toUtc(),
    ));

    // Recurring transactions
    await recurring.insert(RecurringTransaction(
      id: _uuid.v4(), description: 'Salário', amount: Money(750000, 'BRL'),
      type: TransactionType.income, accountId: checking, categoryId: salary,
      rule: const RecurrenceRule(
        frequency: RecurrenceFrequency.monthly, dayOfMonth: 5),
      startDate: lastMonth, nextDueDate: now, isActive: true,
    ));
    await recurring.insert(RecurringTransaction(
      id: _uuid.v4(), description: 'Aluguel', amount: Money(250000, 'BRL'),
      type: TransactionType.expense, accountId: checking, categoryId: rent,
      rule: const RecurrenceRule(
        frequency: RecurrenceFrequency.monthly, dayOfMonth: 10),
      startDate: lastMonth, nextDueDate: now, isActive: true,
    ));
    await recurring.insert(RecurringTransaction(
      id: _uuid.v4(), description: 'Streaming', amount: Money(4500, 'BRL'),
      type: TransactionType.expense, accountId: checking,
      categoryId: subscriptions,
      rule: const RecurrenceRule(
        frequency: RecurrenceFrequency.monthly, dayOfMonth: 15),
      startDate: lastMonth, nextDueDate: now, isActive: true,
    ));
  }

  Future<String> _account(
    AccountLocalDataSource accounts,
    String name,
    AccountType type,
    int balanceMinor,
  ) async {
    final account = Account(
      id: _uuid.v4(),
      name: name,
      type: type,
      currentBalance: Money(balanceMinor, 'BRL'),
      initialBalance: Money(balanceMinor, 'BRL'),
      currency: 'BRL',
      color: type == AccountType.savings ? '#3B82F6' : '#0B6E4F',
      icon: type == AccountType.cash ? 'cash' : 'bank',
      createdAt: DateTime.now().toUtc(),
      isActive: true,
    );
    await accounts.insert(account);
    return account.id;
  }

  Future<void> _txn(
    TransactionLocalDataSource transactions,
    String description,
    int amountMinor,
    TransactionType type,
    String accountId,
    String categoryId,
    DateTime date,
  ) async {
    final now = DateTime.now().toUtc();
    await transactions.create(
      Transaction(
        id: _uuid.v4(),
        description: description,
        amount: Money(amountMinor, 'BRL'),
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

  String _catId(List<Category> categories, String name) =>
      categories.firstWhere((c) => c.name == name).id;

  DateTime _daysAgo(DateTime now, int days) =>
      DateTime(now.year, now.month, now.day - days);

  DateTime _monthAgo(DateTime now, int months) =>
      DateTime(now.year, now.month - months, now.day);
}
