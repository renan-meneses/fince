import '../../../../core/domain/money.dart';
import '../entities/account.dart';

/// Account contract (domain port).
abstract interface class AccountRepository {
  /// Reactive stream of all active accounts.
  Stream<List<Account>> watchAccounts();

  Future<Account> createAccount(Account account);

  Future<Account> updateAccount(Account account);

  /// Soft-deletes an account (sets `isActive = false`).
  Future<void> archiveAccount(String id);

  /// Moves money between two accounts atomically, preserving net worth.
  Future<void> transfer({
    required String fromAccountId,
    required String toAccountId,
    required Money amount,
    required DateTime date,
    String? description,
  });
}
