import 'package:uuid/uuid.dart';

import '../../../../core/domain/money.dart';
import '../../../transactions/domain/entities/transaction.dart';
import '../entities/recurring_transaction.dart';
import '../repositories/recurring_transaction_repository.dart';

/// Creates a recurring transaction with a client UUID.
class CreateRecurringTransaction {
  const CreateRecurringTransaction(this._repository, {Uuid uuid = const Uuid()})
      : _uuid = uuid;

  final RecurringTransactionRepository _repository;
  final Uuid _uuid;

  Future<RecurringTransaction> call({
    required String description,
    required Money amount,
    required TransactionType type,
    required String accountId,
    String? categoryId,
    required RecurrenceRule rule,
    required DateTime startDate,
    DateTime? endDate,
  }) {
    return _repository.create(
      RecurringTransaction(
        id: _uuid.v4(),
        description: description,
        amount: amount,
        type: type,
        accountId: accountId,
        categoryId: categoryId,
        rule: rule,
        startDate: startDate,
        endDate: endDate,
        nextDueDate: startDate,
        isActive: true,
      ),
    );
  }
}
