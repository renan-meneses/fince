import '../../../../core/domain/money.dart';
import '../../../../core/errors/exception_to_failure.dart';
import '../../domain/entities/account.dart';
import '../../domain/repositories/account_repository.dart';
import '../datasources/account_local_data_source.dart';

/// Local-first [AccountRepository]. Remote synchronization is layered on top
/// by the offline sync engine (task 16).
class AccountRepositoryImpl implements AccountRepository {
  AccountRepositoryImpl({required AccountLocalDataSource local}) : _local = local;

  final AccountLocalDataSource _local;

  @override
  Stream<List<Account>> watchAccounts() => _local.watchAll();

  @override
  Future<Account> createAccount(Account account) async {
    try {
      return await _local.insert(account);
    } catch (e) {
      throw mapExceptionToFailure(e);
    }
  }

  @override
  Future<Account> updateAccount(Account account) async {
    try {
      return await _local.update(account);
    } catch (e) {
      throw mapExceptionToFailure(e);
    }
  }

  @override
  Future<void> archiveAccount(String id) async {
    try {
      await _local.archive(id);
    } catch (e) {
      throw mapExceptionToFailure(e);
    }
  }

  @override
  Future<void> transfer({
    required String fromAccountId,
    required String toAccountId,
    required Money amount,
    required DateTime date,
    String? description,
  }) async {
    try {
      await _local.transfer(
        fromId: fromAccountId,
        toId: toAccountId,
        amount: amount,
        date: date,
        description: description,
      );
    } catch (e) {
      throw mapExceptionToFailure(e);
    }
  }
}
