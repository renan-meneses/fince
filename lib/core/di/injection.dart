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
import '../../features/auth/data/datasources/auth_local_data_source.dart';
import '../../features/auth/data/datasources/auth_remote_data_source.dart';
import '../../features/auth/data/repositories/auth_repository_impl.dart';
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
import '../../features/recurring_transactions/data/datasources/recurring_transaction_local_data_source.dart';
import '../../features/recurring_transactions/data/repositories/recurring_transaction_repository_impl.dart';
import '../../features/recurring_transactions/domain/repositories/recurring_transaction_repository.dart';
import '../../features/recurring_transactions/domain/usecases/create_recurring_transaction.dart';
import '../../features/recurring_transactions/domain/usecases/delete_recurring_transaction.dart';
import '../../features/recurring_transactions/domain/usecases/generate_due_occurrences.dart';
import '../../features/recurring_transactions/domain/usecases/watch_recurring_transactions.dart';
import '../../features/recurring_transactions/presentation/cubit/recurring_cubit.dart';
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

  _registerAccountsModule();
  _registerCategoriesModule();
  _registerTransactionsModule();
  _registerDashboardModule();
  _registerCreditCardsModule();
  _registerRecurringModule();
  _registerBudgetsModule();
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
    ),
  );
}

void _registerAuthModule() {
  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSource(sl<Dio>()),
  );
  sl.registerLazySingleton<AuthLocalDataSource>(
    () => AuthLocalDataSource(sl<SecureStorage>()),
  );
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(remote: sl(), local: sl()),
  );
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
