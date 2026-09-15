import 'package:fince/core/errors/failure.dart';
import 'package:fince/features/auth/domain/entities/user.dart';
import 'package:fince/features/auth/domain/repositories/auth_repository.dart';
import 'package:fince/features/auth/domain/usecases/authenticate_with_biometrics.dart';
import 'package:fince/features/auth/domain/usecases/forgot_password.dart';
import 'package:fince/features/auth/domain/usecases/get_current_user.dart';
import 'package:fince/features/auth/domain/usecases/login.dart';
import 'package:fince/features/auth/domain/usecases/logout.dart';
import 'package:fince/features/auth/domain/usecases/register.dart';
import 'package:fince/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:fince/features/auth/presentation/cubit/auth_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class _MockAuthRepository extends Mock implements AuthRepository {}

const _user = User(
  id: 'u1',
  email: 'ada@example.com',
  name: 'Ada',
  avatarUrl: null,
  currency: 'BRL',
  locale: 'pt_BR',
  isActive: true,
);

void main() {
  late _MockAuthRepository repository;
  late AuthCubit cubit;

  setUp(() {
    repository = _MockAuthRepository();
    cubit = AuthCubit(
      login: Login(repository),
      register: Register(repository),
      logout: Logout(repository),
      forgotPassword: ForgotPassword(repository),
      getCurrentUser: GetCurrentUser(repository),
      authenticateWithBiometrics: AuthenticateWithBiometrics(repository),
    );
  });

  group('init', () {
    test('emits authenticated when a session exists', () async {
      when(() => repository.currentUser()).thenAnswer((_) async => _user);

      await cubit.init();

      expect(cubit.state, isA<AuthAuthenticated>());
      expect(cubit.isAuthenticated, isTrue);
    });

    test('emits unauthenticated without a session', () async {
      when(() => repository.currentUser()).thenAnswer((_) async => null);

      await cubit.init();

      expect(cubit.state, isA<AuthUnauthenticated>());
    });
  });

  group('login', () {
    test('emits authenticated on success', () async {
      when(
        () => repository.login(
          email: any(named: 'email'),
          password: any(named: 'password'),
        ),
      ).thenAnswer((_) async => _user);

      await cubit.login(email: 'ada@example.com', password: 's3cret123');

      expect(cubit.state, isA<AuthAuthenticated>());
    });

    test('emits failure on authentication error', () async {
      when(
        () => repository.login(
          email: any(named: 'email'),
          password: any(named: 'password'),
        ),
      ).thenThrow(const AuthenticationFailure());

      await cubit.login(email: 'ada@example.com', password: 'wrong');

      expect(cubit.state, isA<AuthFailure>());
    });
  });

  test('logout emits unauthenticated', () async {
    when(() => repository.logout()).thenAnswer((_) async {});

    await cubit.logout();

    expect(cubit.state, isA<AuthUnauthenticated>());
  });
}
