import '../../../../core/errors/exception_to_failure.dart';
import '../../domain/entities/transaction.dart';
import '../../domain/entities/transaction_filter.dart';
import '../../domain/repositories/transaction_repository.dart';
import '../datasources/transaction_local_data_source.dart';

/// Local-first [TransactionRepository].
class TransactionRepositoryImpl implements TransactionRepository {
  TransactionRepositoryImpl({required TransactionLocalDataSource local})
      : _local = local;

  final TransactionLocalDataSource _local;

  @override
  Stream<List<Transaction>> watchTransactions({
    TransactionFilter filter = const TransactionFilter(),
    TransactionSort sort = TransactionSort.dateDesc,
  }) =>
      _local.watchAll(filter: filter, sort: sort);

  @override
  Future<List<Transaction>> getTransactions({
    TransactionFilter filter = const TransactionFilter(),
    TransactionSort sort = TransactionSort.dateDesc,
    int limit = 100,
    int offset = 0,
  }) async {
    try {
      return await _local.getAll(
        filter: filter,
        sort: sort,
        limit: limit,
        offset: offset,
      );
    } catch (e) {
      throw mapExceptionToFailure(e);
    }
  }

  @override
  Future<Transaction> createTransaction(Transaction transaction) async {
    try {
      return await _local.create(transaction);
    } catch (e) {
      throw mapExceptionToFailure(e);
    }
  }

  @override
  Future<Transaction> updateTransaction(Transaction transaction) async {
    try {
      return await _local.update(transaction);
    } catch (e) {
      throw mapExceptionToFailure(e);
    }
  }

  @override
  Future<void> deleteTransaction(String id) async {
    try {
      await _local.delete(id);
    } catch (e) {
      throw mapExceptionToFailure(e);
    }
  }

  @override
  Future<Transaction> duplicateTransaction(String id) async {
    try {
      return await _local.duplicate(id);
    } catch (e) {
      throw mapExceptionToFailure(e);
    }
  }
}
