import 'package:uuid/uuid.dart';

import '../../../../core/domain/money.dart';
import '../../../../core/errors/failure.dart';
import '../entities/transaction.dart';
import '../repositories/transaction_repository.dart';

/// Creates a transaction (and its balance effect) with a client UUID.
class CreateTransaction {
  const CreateTransaction(this._repository, {Uuid uuid = const Uuid()})
      : _uuid = uuid;

  final TransactionRepository _repository;
  final Uuid _uuid;

  Future<Transaction> call({
    required String description,
    required Money amount,
    required TransactionType type,
    required String accountId,
    required DateTime date,
    String? categoryId,
    String? subcategoryId,
    PaymentStatus paymentStatus = PaymentStatus.paid,
    String? notes,
    List<String> tags = const [],
  }) {
    if (description.trim().isEmpty) {
      throw const ValidationFailure(message: 'Informe uma descrição.');
    }
    if (!amount.isPositive) {
      throw const ValidationFailure(
        message: 'O valor deve ser maior que zero.',
      );
    }
    final now = DateTime.now().toUtc();
    return _repository.createTransaction(
      Transaction(
        id: _uuid.v4(),
        description: description.trim(),
        amount: amount,
        type: type,
        accountId: accountId,
        categoryId: categoryId,
        subcategoryId: subcategoryId,
        date: date,
        paymentStatus: paymentStatus,
        notes: notes,
        tags: tags,
        createdAt: now,
        updatedAt: now,
      ),
    );
  }
}
