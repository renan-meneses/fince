import 'package:fince/app.dart';
import 'package:fince/core/router/app_router.dart';
import 'package:fince/features/auth/domain/repositories/auth_repository.dart';
import 'package:fince/features/auth/domain/usecases/authenticate_with_biometrics.dart';
import 'package:fince/features/auth/domain/usecases/forgot_password.dart';
import 'package:fince/features/auth/domain/usecases/get_current_user.dart';
import 'package:fince/features/auth/domain/usecases/login.dart';
import 'package:fince/features/auth/domain/usecases/logout.dart';
import 'package:fince/features/auth/domain/usecases/register.dart';
import 'package:fince/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class _MockAuthRepository extends Mock implements AuthRepository {}

AuthCubit _buildCubit(AuthRepository repo) => AuthCubit(
      login: Login(repo),
      register: Register(repo),
      logout: Logout(repo),
      forgotPassword: ForgotPassword(repo),
      getCurrentUser: GetCurrentUser(repo),
      authenticateWithBiometrics: AuthenticateWithBiometrics(repo),
    );

void main() {
  testWidgets('unauthenticated start redirects to the login screen',
      (tester) async {
    final repo = _MockAuthRepository();
    when(() => repo.currentUser()).thenAnswer((_) async => null);

    final cubit = _buildCubit(repo);
    await tester.pumpWidget(
      FinceApp(router: AppRouter(cubit).router, authCubit: cubit),
    );
    await tester.pumpAndSettle();

    expect(find.text('Entre na sua conta'), findsOneWidget);
  });
}
