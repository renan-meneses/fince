import 'package:fince/core/errors/failure.dart';
import 'package:fince/features/auth/data/repositories/local_auth_repository.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const repository = LocalAuthRepository();

  test('currentUser returns the local user without login', () async {
    final user = await repository.currentUser();

    expect(user, isNotNull);
    expect(user!.name, 'Usuário local');
    expect(user.isActive, isTrue);
  });

  test('login is unavailable offline (reserved for cloud sync)', () async {
    await expectLater(
      repository.login(email: 'x@y.com', password: 'wrong'),
      throwsA(isA<AuthenticationFailure>()),
    );
  });
}
