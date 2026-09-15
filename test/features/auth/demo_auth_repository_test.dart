import 'package:fince/core/errors/failure.dart';
import 'package:fince/features/auth/data/datasources/auth_local_data_source.dart';
import 'package:fince/features/auth/data/models/auth_tokens_model.dart';
import 'package:fince/features/auth/data/models/user_model.dart';
import 'package:fince/features/auth/data/repositories/demo_auth_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class _MockAuthLocalDataSource extends Mock implements AuthLocalDataSource {}

void main() {
  setUpAll(() {
    registerFallbackValue(
      const AuthTokensModel(accessToken: 'x', refreshToken: 'x', expiresIn: 0),
    );
    registerFallbackValue(
      const UserModel(
        id: 'x',
        email: 'x@y.com',
        name: 'x',
        currency: 'BRL',
        locale: 'pt_BR',
        isActive: true,
      ),
    );
  });

  test('login succeeds with the demo credentials', () async {
    final local = _MockAuthLocalDataSource();
    when(() => local.saveTokens(any())).thenAnswer((_) async {});
    when(() => local.saveUser(any())).thenAnswer((_) async {});

    final repository = DemoAuthRepository(local: local);
    final user = await repository.login(
      email: 'demo@fince.app',
      password: 'demo123',
    );

    expect(user.email, 'demo@fince.app');
    expect(user.name, 'Ada Demo');
  });

  test('login rejects wrong credentials', () async {
    final local = _MockAuthLocalDataSource();
    final repository = DemoAuthRepository(local: local);

    await expectLater(
      repository.login(email: 'x@y.com', password: 'wrong'),
      throwsA(isA<AuthenticationFailure>()),
    );
  });
}
