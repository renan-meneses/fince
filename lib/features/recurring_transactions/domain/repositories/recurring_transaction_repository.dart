import '../entities/recurring_transaction.dart';

/// Recurring transaction contract (domain port).
abstract interface class RecurringTransactionRepository {
  Stream<List<RecurringTransaction>> watchAll();

  Future<RecurringTransaction> create(RecurringTransaction recurring);

  Future<RecurringTransaction> update(RecurringTransaction recurring);

  Future<void> delete(String id);

  /// Generates due occurrences up to [now], returning how many were created.
  /// Idempotent: re-running never duplicates an occurrence.
  Future<int> generateDueOccurrences(DateTime now);
}
