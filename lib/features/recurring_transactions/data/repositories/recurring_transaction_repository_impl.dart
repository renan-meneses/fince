import '../../../../core/errors/exception_to_failure.dart';
import '../../domain/entities/recurring_transaction.dart';
import '../../domain/repositories/recurring_transaction_repository.dart';
import '../datasources/recurring_transaction_local_data_source.dart';

/// Local-first [RecurringTransactionRepository].
class RecurringTransactionRepositoryImpl
    implements RecurringTransactionRepository {
  RecurringTransactionRepositoryImpl({required RecurringTransactionLocalDataSource local})
      : _local = local;

  final RecurringTransactionLocalDataSource _local;

  @override
  Stream<List<RecurringTransaction>> watchAll() => _local.watchAll();

  @override
  Future<RecurringTransaction> create(RecurringTransaction recurring) async {
    try {
      return await _local.insert(recurring);
    } catch (e) {
      throw mapExceptionToFailure(e);
    }
  }

  @override
  Future<RecurringTransaction> update(RecurringTransaction recurring) async {
    try {
      return await _local.update(recurring);
    } catch (e) {
      throw mapExceptionToFailure(e);
    }
  }

  @override
  Future<void> delete(String id) async {
    try {
      await _local.delete(id);
    } catch (e) {
      throw mapExceptionToFailure(e);
    }
  }

  @override
  Future<int> generateDueOccurrences(DateTime now) async {
    try {
      return await _local.generateDueOccurrences(now);
    } catch (e) {
      throw mapExceptionToFailure(e);
    }
  }
}
