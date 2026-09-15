import 'package:fince/app.dart';
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
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class _MockAuthRepository extends Mock implements AuthRepository {}

class _MockAccountRepository extends Mock implements AccountRepository {}

class _MockCategoryRepository extends Mock implements CategoryRepository {}

void main() {
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

    await tester.pumpWidget(
      FinceApp(
        router: AppRouter(authCubit, accountsCubit, categoriesCubit).router,
        authCubit: authCubit,
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Entre na sua conta'), findsOneWidget);
  });
}
