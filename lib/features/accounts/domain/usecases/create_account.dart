import 'package:uuid/uuid.dart';

import '../../../../core/domain/money.dart';
import '../entities/account.dart';
import '../repositories/account_repository.dart';

/// Creates a new account. The id is a client-generated UUID so that a replayed
/// offline create is idempotent.
class CreateAccount {
  const CreateAccount(this._repository, {Uuid uuid = const Uuid()})
      : _uuid = uuid;

  final AccountRepository _repository;
  final Uuid _uuid;

  Future<Account> call({
    required String name,
    required AccountType type,
    required Money initialBalance,
    String? institution,
    required String color,
    required String icon,
  }) {
    final account = Account(
      id: _uuid.v4(),
      name: name,
      type: type,
      currentBalance: initialBalance,
      initialBalance: initialBalance,
      currency: initialBalance.currency,
      institution: institution,
      color: color,
      icon: icon,
      createdAt: DateTime.now().toUtc(),
      isActive: true,
    );
    return _repository.createAccount(account);
  }
}
