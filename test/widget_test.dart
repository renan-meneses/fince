import 'package:fince/app.dart';
import 'package:fince/core/domain/money.dart';
import 'package:fince/core/router/app_router.dart';
import 'package:fince/features/accounts/domain/repositories/account_repository.dart';
import 'package:fince/features/accounts/domain/usecases/archive_account.dart';
import 'package:fince/features/accounts/domain/usecases/create_account.dart';
import 'package:fince/features/accounts/domain/usecases/transfer_between_accounts.dart';
import 'package:fince/features/accounts/domain/usecases/update_account.dart';
import 'package:fince/features/accounts/domain/usecases/watch_accounts.dart';
import 'package:fince/features/accounts/presentation/cubit/accounts_cubit.dart';
import 'package:fince/features/auth/domain/repositories/auth_repository.dart';
import 'package:fince/features/auth/domain/usecases/authenticate_with_biometrics.dart';
import 'package:fince/features/auth/domain/usecases/forgot_password.dart';
import 'package:fince/features/auth/domain/usecases/get_current_user.dart';
import 'package:fince/features/auth/domain/usecases/login.dart';
import 'package:fince/features/auth/domain/usecases/logout.dart';
import 'package:fince/features/auth/domain/usecases/register.dart';
import 'package:fince/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:fince/features/budgets/domain/repositories/budget_repository.dart';
import 'package:fince/features/budgets/domain/usecases/create_budget.dart';
import 'package:fince/features/budgets/domain/usecases/delete_budget.dart';
import 'package:fince/features/budgets/domain/usecases/watch_budgets.dart';
import 'package:fince/features/budgets/presentation/cubit/budgets_cubit.dart';
import 'package:fince/features/categories/domain/repositories/category_repository.dart';
import 'package:fince/features/categories/domain/usecases/create_category.dart';
import 'package:fince/features/categories/domain/usecases/delete_category.dart';
import 'package:fince/features/categories/domain/usecases/seed_default_categories.dart';
import 'package:fince/features/categories/domain/usecases/watch_categories.dart';
import 'package:fince/features/categories/presentation/cubit/categories_cubit.dart';
import 'package:fince/features/credit_cards/domain/repositories/credit_card_repository.dart';
import 'package:fince/features/credit_cards/domain/usecases/create_card.dart';
import 'package:fince/features/credit_cards/domain/usecases/get_invoices.dart';
import 'package:fince/features/credit_cards/domain/usecases/pay_invoice.dart';
import 'package:fince/features/credit_cards/domain/usecases/register_purchase.dart';
import 'package:fince/features/credit_cards/domain/usecases/watch_cards.dart';
import 'package:fince/features/credit_cards/presentation/cubit/credit_cards_cubit.dart';
import 'package:fince/features/dashboard/domain/entities/financial_overview.dart';
import 'package:fince/features/dashboard/domain/repositories/dashboard_repository.dart';
import 'package:fince/features/dashboard/domain/usecases/watch_overview.dart';
import 'package:fince/features/dashboard/presentation/cubit/dashboard_cubit.dart';
import 'package:fince/features/goals/domain/repositories/goal_repository.dart';
import 'package:fince/features/goals/domain/usecases/create_goal.dart';
import 'package:fince/features/goals/domain/usecases/delete_goal.dart';
import 'package:fince/features/goals/domain/usecases/deposit_to_goal.dart';
import 'package:fince/features/goals/domain/usecases/watch_goals.dart';
import 'package:fince/features/goals/presentation/cubit/goals_cubit.dart';
import 'package:fince/features/insights/domain/repositories/insight_repository.dart';
import 'package:fince/features/insights/domain/usecases/generate_insights.dart';
import 'package:fince/features/insights/presentation/cubit/insights_cubit.dart';
import 'package:fince/features/recurring_transactions/domain/repositories/recurring_transaction_repository.dart';
import 'package:fince/features/recurring_transactions/domain/usecases/delete_recurring_transaction.dart';
import 'package:fince/features/recurring_transactions/domain/usecases/generate_due_occurrences.dart';
import 'package:fince/features/recurring_transactions/domain/usecases/watch_recurring_transactions.dart';
import 'package:fince/features/recurring_transactions/presentation/cubit/recurring_cubit.dart';
import 'package:fince/features/reports/domain/entities/report_entities.dart';
import 'package:fince/features/reports/domain/repositories/report_repository.dart';
import 'package:fince/features/reports/domain/usecases/get_cash_flow.dart';
import 'package:fince/features/reports/domain/usecases/get_expenses_by_account.dart';
import 'package:fince/features/reports/domain/usecases/get_expenses_by_category.dart';
import 'package:fince/features/reports/domain/usecases/get_income_vs_expense.dart';
import 'package:fince/features/reports/presentation/cubit/reports_cubit.dart';
import 'package:fince/features/transactions/domain/entities/transaction_filter.dart';
import 'package:fince/features/transactions/domain/repositories/transaction_repository.dart';
import 'package:fince/features/transactions/domain/usecases/create_transaction.dart';
import 'package:fince/features/transactions/domain/usecases/delete_transaction.dart';
import 'package:fince/features/transactions/domain/usecases/duplicate_transaction.dart';
import 'package:fince/features/transactions/domain/usecases/update_transaction.dart';
import 'package:fince/features/transactions/domain/usecases/watch_transactions.dart';
import 'package:fince/features/transactions/presentation/cubit/transactions_cubit.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class _MockAuthRepository extends Mock implements AuthRepository {}

class _MockAccountRepository extends Mock implements AccountRepository {}

class _MockCategoryRepository extends Mock implements CategoryRepository {}

class _MockTransactionRepository extends Mock implements TransactionRepository {}

class _MockDashboardRepository extends Mock implements DashboardRepository {}

class _MockCreditCardRepository extends Mock
    implements CreditCardRepository {}

class _MockRecurringRepository extends Mock
    implements RecurringTransactionRepository {}

class _MockBudgetRepository extends Mock implements BudgetRepository {}

class _MockGoalRepository extends Mock implements GoalRepository {}

class _MockReportRepository extends Mock implements ReportRepository {}

class _MockInsightRepository extends Mock implements InsightRepository {}

void main() {
  setUpAll(() {
    registerFallbackValue(const TransactionFilter());
    registerFallbackValue(TransactionSort.dateDesc);
    registerFallbackValue(DateTime(2000));
  });

  testWidgets('unauthenticated start redirects to the login screen',
      (tester) async {
    final authRepo = _MockAuthRepository();
    when(() => authRepo.currentUser()).thenAnswer((_) async => null);
    final authCubit = AuthCubit(
      login: Login(authRepo),
      register: Register(authRepo),
      logout: Logout(authRepo),
      forgotPassword: ForgotPassword(authRepo),
      getCurrentUser: GetCurrentUser(authRepo),
      authenticateWithBiometrics: AuthenticateWithBiometrics(authRepo),
    );

    final accountRepo = _MockAccountRepository();
    when(() => accountRepo.watchAccounts())
        .thenAnswer((_) => Stream.value(const []));
    final accountsCubit = AccountsCubit(
      watchAccounts: WatchAccounts(accountRepo),
      createAccount: CreateAccount(accountRepo),
      updateAccount: UpdateAccount(accountRepo),
      archiveAccount: ArchiveAccount(accountRepo),
      transferBetweenAccounts: TransferBetweenAccounts(accountRepo),
    );

    final categoryRepo = _MockCategoryRepository();
    when(() => categoryRepo.watchCategories())
        .thenAnswer((_) => Stream.value(const []));
    when(() => categoryRepo.seedDefaultCategories()).thenAnswer((_) async {});
    final categoriesCubit = CategoriesCubit(
      watchCategories: WatchCategories(categoryRepo),
      createCategory: CreateCategory(categoryRepo),
      deleteCategory: DeleteCategory(categoryRepo),
      seedDefaultCategories: SeedDefaultCategories(categoryRepo),
    );

    final transactionRepo = _MockTransactionRepository();
    when(
      () => transactionRepo.watchTransactions(
        filter: any(named: 'filter'),
        sort: any(named: 'sort'),
      ),
    ).thenAnswer((_) => Stream.value(const []));
    final transactionsCubit = TransactionsCubit(
      watchTransactions: WatchTransactions(transactionRepo),
      createTransaction: CreateTransaction(transactionRepo),
      updateTransaction: UpdateTransaction(transactionRepo),
      deleteTransaction: DeleteTransaction(transactionRepo),
      duplicateTransaction: DuplicateTransaction(transactionRepo),
    );

    final dashboardRepo = _MockDashboardRepository();
    when(
      () => dashboardRepo.watchOverview(
        start: any(named: 'start'),
        end: any(named: 'end'),
      ),
    ).thenAnswer(
      (_) => Stream.value(
        FinancialOverview(
          totalBalance: Money(0, 'BRL'),
          income: Money(0, 'BRL'),
          expenses: Money(0, 'BRL'),
          result: Money(0, 'BRL'),
          variationPercent: null,
          recentTransactions: const [],
          expensesByCategory: const [],
        ),
      ),
    );
    final dashboardCubit = DashboardCubit(
      watchOverview: WatchOverview(dashboardRepo),
    );

    final creditCardRepo = _MockCreditCardRepository();
    when(() => creditCardRepo.watchCards())
        .thenAnswer((_) => Stream.value(const []));
    final creditCardsCubit = CreditCardsCubit(
      watchCards: WatchCards(creditCardRepo),
      createCard: CreateCard(creditCardRepo),
      registerPurchase: RegisterPurchase(creditCardRepo),
      getInvoices: GetInvoices(creditCardRepo),
      payInvoice: PayInvoice(creditCardRepo),
    );

    final recurringRepo = _MockRecurringRepository();
    when(() => recurringRepo.watchAll()).thenAnswer((_) => Stream.value(const []));
    final recurringCubit = RecurringCubit(
      watch: WatchRecurringTransactions(recurringRepo),
      delete: DeleteRecurringTransaction(recurringRepo),
      generate: GenerateDueOccurrences(recurringRepo),
    );

    final budgetRepo = _MockBudgetRepository();
    when(() => budgetRepo.watchBudgets(any()))
        .thenAnswer((_) => Stream.value(const []));
    final budgetsCubit = BudgetsCubit(
      watchBudgets: WatchBudgets(budgetRepo),
      createBudget: CreateBudget(budgetRepo),
      deleteBudget: DeleteBudget(budgetRepo),
    );

    final goalRepo = _MockGoalRepository();
    when(() => goalRepo.watchGoals()).thenAnswer((_) => Stream.value(const []));
    final goalsCubit = GoalsCubit(
      watchGoals: WatchGoals(goalRepo),
      createGoal: CreateGoal(goalRepo),
      deleteGoal: DeleteGoal(goalRepo),
      depositToGoal: DepositToGoal(goalRepo),
    );

    final reportRepo = _MockReportRepository();
    when(
      () => reportRepo.getIncomeVsExpense(
        start: any(named: 'start'),
        end: any(named: 'end'),
      ),
    ).thenAnswer(
      (_) async => IncomeExpenseReport(
        income: Money(0, 'BRL'),
        expenses: Money(0, 'BRL'),
        result: Money(0, 'BRL'),
      ),
    );
    when(
      () => reportRepo.getCashFlow(
        start: any(named: 'start'),
        end: any(named: 'end'),
      ),
    ).thenAnswer((_) async => const []);
    when(
      () => reportRepo.getExpensesByCategory(
        start: any(named: 'start'),
        end: any(named: 'end'),
      ),
    ).thenAnswer((_) async => const []);
    when(
      () => reportRepo.getExpensesByAccount(
        start: any(named: 'start'),
        end: any(named: 'end'),
      ),
    ).thenAnswer((_) async => const []);
    final reportsCubit = ReportsCubit(
      incomeVsExpense: GetIncomeVsExpense(reportRepo),
      cashFlow: GetCashFlow(reportRepo),
      byCategory: GetExpensesByCategory(reportRepo),
      byAccount: GetExpensesByAccount(reportRepo),
    );

    final insightRepo = _MockInsightRepository();
    when(() => insightRepo.generateInsights(month: any(named: 'month')))
        .thenAnswer((_) async => const []);
    final insightsCubit = InsightsCubit(
      generateInsights: GenerateInsights(insightRepo),
    );

    await tester.pumpWidget(
      FinceApp(
        router: AppRouter(
          authCubit,
          accountsCubit,
          categoriesCubit,
          transactionsCubit,
          dashboardCubit,
          creditCardsCubit,
          recurringCubit,
          budgetsCubit,
          goalsCubit,
          reportsCubit,
          insightsCubit,
        ).router,
        authCubit: authCubit,
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Entre na sua conta'), findsOneWidget);
  });
}
