import '../entities/transaction.dart';
import '../entities/transaction_filter.dart';

/// Transaction contract (domain port).
abstract interface class TransactionRepository {
  Stream<List<Transaction>> watchTransactions({
    TransactionFilter filter = const TransactionFilter(),
    TransactionSort sort = TransactionSort.dateDesc,
  });

  Future<List<Transaction>> getTransactions({
    TransactionFilter filter = const TransactionFilter(),
    TransactionSort sort = TransactionSort.dateDesc,
    int limit = 100,
    int offset = 0,
  });

  /// Creates a transaction and atomically updates the account balance.
  Future<Transaction> createTransaction(Transaction transaction);

  /// Updates a transaction, reversing the old balance effect and applying the
  /// new one atomically.
  Future<Transaction> updateTransaction(Transaction transaction);

  /// Deletes a transaction and reverses its balance effect.
  Future<void> deleteTransaction(String id);

  /// Creates a copy of an existing transaction.
  Future<Transaction> duplicateTransaction(String id);
}
