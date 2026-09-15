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

    await tester.pumpWidget(
      FinceApp(
        router: AppRouter(
          authCubit,
          accountsCubit,
          categoriesCubit,
          transactionsCubit,
          dashboardCubit,
          creditCardsCubit,
        ).router,
        authCubit: authCubit,
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Entre na sua conta'), findsOneWidget);
  });
}
