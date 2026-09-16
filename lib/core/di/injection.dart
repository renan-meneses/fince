import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import '../../features/accounts/data/datasources/account_local_data_source.dart';
import '../../features/accounts/data/repositories/account_repository_impl.dart';
import '../../features/accounts/domain/repositories/account_repository.dart';
import '../../features/accounts/domain/usecases/archive_account.dart';
import '../../features/accounts/domain/usecases/create_account.dart';
import '../../features/accounts/domain/usecases/transfer_between_accounts.dart';
import '../../features/accounts/domain/usecases/update_account.dart';
import '../../features/accounts/domain/usecases/watch_accounts.dart';
import '../../features/accounts/presentation/cubit/accounts_cubit.dart';
import '../../features/auth/data/repositories/local_auth_repository.dart';
import '../../features/auth/domain/repositories/auth_repository.dart';
import '../../features/auth/domain/usecases/authenticate_with_biometrics.dart';
import '../../features/auth/domain/usecases/forgot_password.dart';
import '../../features/auth/domain/usecases/get_current_user.dart';
import '../../features/auth/domain/usecases/login.dart';
import '../../features/auth/domain/usecases/logout.dart';
import '../../features/auth/domain/usecases/register.dart';
import '../../features/auth/presentation/cubit/auth_cubit.dart';
import '../../features/budgets/data/datasources/budget_local_data_source.dart';
import '../../features/budgets/data/repositories/budget_repository_impl.dart';
import '../../features/budgets/domain/repositories/budget_repository.dart';
import '../../features/budgets/domain/usecases/create_budget.dart';
import '../../features/budgets/domain/usecases/delete_budget.dart';
import '../../features/budgets/domain/usecases/watch_budgets.dart';
import '../../features/budgets/presentation/cubit/budgets_cubit.dart';
import '../../features/categories/data/datasources/category_local_data_source.dart';
import '../../features/categories/data/repositories/category_repository_impl.dart';
import '../../features/categories/domain/repositories/category_repository.dart';
import '../../features/categories/domain/usecases/create_category.dart';
import '../../features/categories/domain/usecases/delete_category.dart';
import '../../features/categories/domain/usecases/seed_default_categories.dart';
import '../../features/categories/domain/usecases/watch_categories.dart';
import '../../features/categories/presentation/cubit/categories_cubit.dart';
import '../../features/credit_cards/data/datasources/credit_card_local_data_source.dart';
import '../../features/credit_cards/data/repositories/credit_card_repository_impl.dart';
import '../../features/credit_cards/domain/repositories/credit_card_repository.dart';
import '../../features/credit_cards/domain/usecases/create_card.dart';
import '../../features/credit_cards/domain/usecases/get_invoices.dart';
import '../../features/credit_cards/domain/usecases/pay_invoice.dart';
import '../../features/credit_cards/domain/usecases/register_purchase.dart';
import '../../features/credit_cards/domain/usecases/watch_cards.dart';
import '../../features/credit_cards/presentation/cubit/credit_cards_cubit.dart';
import '../../features/dashboard/data/repositories/dashboard_repository_impl.dart';
import '../../features/dashboard/domain/repositories/dashboard_repository.dart';
import '../../features/dashboard/domain/usecases/watch_overview.dart';
import '../../features/dashboard/presentation/cubit/dashboard_cubit.dart';
import '../../features/goals/data/datasources/goal_local_data_source.dart';
import '../../features/goals/data/repositories/goal_repository_impl.dart';
import '../../features/goals/domain/repositories/goal_repository.dart';
import '../../features/goals/domain/usecases/create_goal.dart';
import '../../features/goals/domain/usecases/delete_goal.dart';
import '../../features/goals/domain/usecases/deposit_to_goal.dart';
import '../../features/goals/domain/usecases/watch_goals.dart';
import '../../features/goals/presentation/cubit/goals_cubit.dart';
import '../../features/insights/data/repositories/insight_repository_impl.dart';
import '../../features/insights/data/repositories/rule_based_insight_repository.dart';
import '../../features/insights/domain/repositories/financial_assistant_repository.dart';
import '../../features/insights/domain/repositories/insight_repository.dart';
import '../../features/insights/domain/usecases/generate_insights.dart';
import '../../features/insights/presentation/cubit/insights_cubit.dart';
import '../../features/recurring_transactions/data/datasources/recurring_transaction_local_data_source.dart';
import '../../features/recurring_transactions/data/repositories/recurring_transaction_repository_impl.dart';
import '../../features/recurring_transactions/domain/repositories/recurring_transaction_repository.dart';
import '../../features/recurring_transactions/domain/usecases/create_recurring_transaction.dart';
import '../../features/recurring_transactions/domain/usecases/delete_recurring_transaction.dart';
import '../../features/recurring_transactions/domain/usecases/generate_due_occurrences.dart';
import '../../features/recurring_transactions/domain/usecases/watch_recurring_transactions.dart';
import '../../features/recurring_transactions/presentation/cubit/recurring_cubit.dart';
import '../../features/reports/data/repositories/report_repository_impl.dart';
import '../../features/reports/domain/repositories/report_repository.dart';
import '../../features/reports/domain/usecases/get_cash_flow.dart';
import '../../features/reports/domain/usecases/get_expenses_by_account.dart';
import '../../features/reports/domain/usecases/get_expenses_by_category.dart';
import '../../features/reports/domain/usecases/get_income_vs_expense.dart';
import '../../features/reports/presentation/cubit/reports_cubit.dart';
import '../../features/sync/data/datasources/dio_sync_remote_source.dart';
import '../../features/sync/data/datasources/sync_local_data_source.dart';
import '../../features/sync/data/repositories/sync_repository_impl.dart';
import '../../features/sync/data/sync_manager.dart';
import '../../features/sync/domain/repositories/sync_remote_source.dart';
import '../../features/sync/domain/repositories/sync_repository.dart';
import '../../features/transactions/data/datasources/transaction_local_data_source.dart';
import '../../features/transactions/data/repositories/transaction_repository_impl.dart';
import '../../features/transactions/domain/repositories/transaction_repository.dart';
import '../../features/transactions/domain/usecases/create_transaction.dart';
import '../../features/transactions/domain/usecases/delete_transaction.dart';
import '../../features/transactions/domain/usecases/duplicate_transaction.dart';
import '../../features/transactions/domain/usecases/update_transaction.dart';
import '../../features/transactions/domain/usecases/watch_transactions.dart';
import '../../features/transactions/presentation/cubit/transactions_cubit.dart';
import '../config/app_config.dart';
import '../constants/storage_keys.dart';
import '../demo/demo_data_seeder.dart';
import '../network/dio_client.dart';
import '../router/app_router.dart';
import '../storage/app_database.dart';
import '../storage/database_connection.dart';
import '../storage/secure_storage.dart';

/// Composition root. All concrete implementations are registered here and
/// resolved by the presentation layer through their abstractions.
final GetIt sl = GetIt.instance;

/// Registers application-wide singletons and feature modules.
Future<void> configureDependencies(AppConfig config) async {
  sl.registerLazySingleton<AppConfig>(() => config);
  sl.registerLazySingleton<SecureStorage>(SecureStorage.new);
  sl.registerLazySingleton<Dio>(
    () => buildDio(
      config,
      tokenProvider: () => sl<SecureStorage>().read(StorageKeys.accessToken),
    ),
  );

  _registerAuthModule();

  final database = await openAppDatabase();
  sl.registerLazySingleton<AppDatabase>(() => database);

  if (config.demoMode) {
    await DemoDataSeeder().seed(database);
  }

  _registerAccountsModule();
  _registerCategoriesModule();
  _registerTransactionsModule();
  _registerDashboardModule();
  _registerCreditCardsModule();
  _registerRecurringModule();
  _registerBudgetsModule();
  _registerGoalsModule();
  _registerReportsModule();
  _registerInsightsModule();
  _registerSyncModule();
  sl.registerLazySingleton<AppRouter>(
    () => AppRouter(
      sl<AuthCubit>(),
      sl<AccountsCubit>(),
      sl<CategoriesCubit>(),
      sl<TransactionsCubit>(),
      sl<DashboardCubit>(),
      sl<CreditCardsCubit>(),
      sl<RecurringCubit>(),
      sl<BudgetsCubit>(),
      sl<GoalsCubit>(),
      sl<ReportsCubit>(),
      sl<InsightsCubit>(),
    ),
  );
}

void _registerAuthModule() {
  sl.registerLazySingleton<AuthRepository>(() => const LocalAuthRepository());
  sl.registerLazySingleton<Login>(() => Login(sl()));
  sl.registerLazySingleton<Register>(() => Register(sl()));
  sl.registerLazySingleton<Logout>(() => Logout(sl()));
  sl.registerLazySingleton<ForgotPassword>(() => ForgotPassword(sl()));
  sl.registerLazySingleton<GetCurrentUser>(() => GetCurrentUser(sl()));
  sl.registerLazySingleton<AuthenticateWithBiometrics>(
    () => AuthenticateWithBiometrics(sl()),
  );
  sl.registerLazySingleton<AuthCubit>(
    () => AuthCubit(
      login: sl(),
      register: sl(),
      logout: sl(),
      forgotPassword: sl(),
      getCurrentUser: sl(),
      authenticateWithBiometrics: sl(),
    ),
  );
}

void _registerAccountsModule() {
  sl.registerLazySingleton<AccountLocalDataSource>(
    () => AccountLocalDataSource(sl<AppDatabase>()),
  );
  sl.registerLazySingleton<AccountRepository>(
    () => AccountRepositoryImpl(local: sl()),
  );
  sl.registerLazySingleton<WatchAccounts>(() => WatchAccounts(sl()));
  sl.registerLazySingleton<CreateAccount>(() => CreateAccount(sl()));
  sl.registerLazySingleton<UpdateAccount>(() => UpdateAccount(sl()));
  sl.registerLazySingleton<ArchiveAccount>(() => ArchiveAccount(sl()));
  sl.registerLazySingleton<TransferBetweenAccounts>(
    () => TransferBetweenAccounts(sl()),
  );
  sl.registerLazySingleton<AccountsCubit>(
    () => AccountsCubit(
      watchAccounts: sl(),
      createAccount: sl(),
      updateAccount: sl(),
      archiveAccount: sl(),
      transferBetweenAccounts: sl(),
    ),
  );
}

void _registerCategoriesModule() {
  sl.registerLazySingleton<CategoryLocalDataSource>(
    () => CategoryLocalDataSource(sl<AppDatabase>()),
  );
  sl.registerLazySingleton<CategoryRepository>(
    () => CategoryRepositoryImpl(local: sl()),
  );
  sl.registerLazySingleton<WatchCategories>(() => WatchCategories(sl()));
  sl.registerLazySingleton<CreateCategory>(() => CreateCategory(sl()));
  sl.registerLazySingleton<DeleteCategory>(() => DeleteCategory(sl()));
  sl.registerLazySingleton<SeedDefaultCategories>(
    () => SeedDefaultCategories(sl()),
  );
  sl.registerLazySingleton<CategoriesCubit>(
    () => CategoriesCubit(
      watchCategories: sl(),
      createCategory: sl(),
      deleteCategory: sl(),
      seedDefaultCategories: sl(),
    ),
  );
}

void _registerTransactionsModule() {
  sl.registerLazySingleton<TransactionLocalDataSource>(
    () => TransactionLocalDataSource(sl<AppDatabase>()),
  );
  sl.registerLazySingleton<TransactionRepository>(
    () => TransactionRepositoryImpl(local: sl()),
  );
  sl.registerLazySingleton<WatchTransactions>(() => WatchTransactions(sl()));
  sl.registerLazySingleton<CreateTransaction>(() => CreateTransaction(sl()));
  sl.registerLazySingleton<UpdateTransaction>(() => UpdateTransaction(sl()));
  sl.registerLazySingleton<DeleteTransaction>(() => DeleteTransaction(sl()));
  sl.registerLazySingleton<DuplicateTransaction>(
    () => DuplicateTransaction(sl()),
  );
  sl.registerLazySingleton<TransactionsCubit>(
    () => TransactionsCubit(
      watchTransactions: sl(),
      createTransaction: sl(),
      updateTransaction: sl(),
      deleteTransaction: sl(),
      duplicateTransaction: sl(),
    ),
  );
}

void _registerDashboardModule() {
  sl.registerLazySingleton<DashboardRepository>(
    () => DashboardRepositoryImpl(
      accounts: sl(),
      transactions: sl(),
      categories: sl(),
    ),
  );
  sl.registerLazySingleton<WatchOverview>(() => WatchOverview(sl()));
  sl.registerLazySingleton<DashboardCubit>(
    () => DashboardCubit(watchOverview: sl()),
  );
}

void _registerCreditCardsModule() {
  sl.registerLazySingleton<CreditCardLocalDataSource>(
    () => CreditCardLocalDataSource(sl<AppDatabase>()),
  );
  sl.registerLazySingleton<CreditCardRepository>(
    () => CreditCardRepositoryImpl(local: sl()),
  );
  sl.registerLazySingleton<WatchCards>(() => WatchCards(sl()));
  sl.registerLazySingleton<CreateCard>(() => CreateCard(sl()));
  sl.registerLazySingleton<RegisterPurchase>(() => RegisterPurchase(sl()));
  sl.registerLazySingleton<GetInvoices>(() => GetInvoices(sl()));
  sl.registerLazySingleton<PayInvoice>(() => PayInvoice(sl()));
  sl.registerLazySingleton<CreditCardsCubit>(
    () => CreditCardsCubit(
      watchCards: sl(),
      createCard: sl(),
      registerPurchase: sl(),
      getInvoices: sl(),
      payInvoice: sl(),
    ),
  );
}

void _registerRecurringModule() {
  sl.registerLazySingleton<RecurringTransactionLocalDataSource>(
    () => RecurringTransactionLocalDataSource(
      sl<AppDatabase>(),
      sl<TransactionLocalDataSource>(),
    ),
  );
  sl.registerLazySingleton<RecurringTransactionRepository>(
    () => RecurringTransactionRepositoryImpl(local: sl()),
  );
  sl.registerLazySingleton<WatchRecurringTransactions>(
    () => WatchRecurringTransactions(sl()),
  );
  sl.registerLazySingleton<CreateRecurringTransaction>(
    () => CreateRecurringTransaction(sl()),
  );
  sl.registerLazySingleton<DeleteRecurringTransaction>(
    () => DeleteRecurringTransaction(sl()),
  );
  sl.registerLazySingleton<GenerateDueOccurrences>(
    () => GenerateDueOccurrences(sl()),
  );
  sl.registerLazySingleton<RecurringCubit>(
    () => RecurringCubit(watch: sl(), delete: sl(), generate: sl()),
  );
}

void _registerBudgetsModule() {
  sl.registerLazySingleton<BudgetLocalDataSource>(
    () => BudgetLocalDataSource(sl<AppDatabase>()),
  );
  sl.registerLazySingleton<BudgetRepository>(
    () => BudgetRepositoryImpl(
      local: sl(),
      transactions: sl(),
      categories: sl(),
    ),
  );
  sl.registerLazySingleton<WatchBudgets>(() => WatchBudgets(sl()));
  sl.registerLazySingleton<CreateBudget>(() => CreateBudget(sl()));
  sl.registerLazySingleton<DeleteBudget>(() => DeleteBudget(sl()));
  sl.registerLazySingleton<BudgetsCubit>(
    () => BudgetsCubit(
      watchBudgets: sl(),
      createBudget: sl(),
      deleteBudget: sl(),
    ),
  );
}

void _registerGoalsModule() {
  sl.registerLazySingleton<GoalLocalDataSource>(
    () => GoalLocalDataSource(sl<AppDatabase>()),
  );
  sl.registerLazySingleton<GoalRepository>(() => GoalRepositoryImpl(local: sl()));
  sl.registerLazySingleton<WatchGoals>(() => WatchGoals(sl()));
  sl.registerLazySingleton<CreateGoal>(() => CreateGoal(sl()));
  sl.registerLazySingleton<DeleteGoal>(() => DeleteGoal(sl()));
  sl.registerLazySingleton<DepositToGoal>(() => DepositToGoal(sl()));
  sl.registerLazySingleton<GoalsCubit>(
    () => GoalsCubit(
      watchGoals: sl(),
      createGoal: sl(),
      deleteGoal: sl(),
      depositToGoal: sl(),
    ),
  );
}

void _registerReportsModule() {
  sl.registerLazySingleton<ReportRepository>(
    () => ReportRepositoryImpl(
      transactions: sl(),
      categories: sl(),
      accounts: sl(),
    ),
  );
  sl.registerLazySingleton<GetIncomeVsExpense>(() => GetIncomeVsExpense(sl()));
  sl.registerLazySingleton<GetCashFlow>(() => GetCashFlow(sl()));
  sl.registerLazySingleton<GetExpensesByCategory>(
    () => GetExpensesByCategory(sl()),
  );
  sl.registerLazySingleton<GetExpensesByAccount>(
    () => GetExpensesByAccount(sl()),
  );
  sl.registerLazySingleton<ReportsCubit>(
    () => ReportsCubit(
      incomeVsExpense: sl(),
      cashFlow: sl(),
      byCategory: sl(),
      byAccount: sl(),
    ),
  );
}

void _registerInsightsModule() {
  sl.registerLazySingleton<FinancialAssistantRepository>(
    () => RuleBasedInsightRepository(),
  );
  sl.registerLazySingleton<InsightRepository>(
    () => InsightRepositoryImpl(
      transactions: sl(),
      categories: sl(),
      budgets: sl(),
      assistant: sl(),
    ),
  );
  sl.registerLazySingleton<GenerateInsights>(() => GenerateInsights(sl()));
  sl.registerLazySingleton<InsightsCubit>(
    () => InsightsCubit(generateInsights: sl()),
  );
}

void _registerSyncModule() {
  sl.registerLazySingleton<SyncLocalDataSource>(
    () => SyncLocalDataSource(sl<AppDatabase>()),
  );
  sl.registerLazySingleton<SyncRepository>(
    () => SyncRepositoryImpl(local: sl()),
  );
  sl.registerLazySingleton<SyncRemoteSource>(
    () => DioSyncRemoteSource(sl<Dio>()),
  );
  sl.registerLazySingleton<SyncManager>(
    () => SyncManager(repository: sl(), remote: sl()),
  );
}
