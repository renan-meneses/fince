import '../../../../core/domain/money.dart';
import '../../../../core/errors/failure.dart';
import '../repositories/account_repository.dart';

/// Transfers money between two accounts without changing net worth.
class TransferBetweenAccounts {
  const TransferBetweenAccounts(this._repository);

  final AccountRepository _repository;

  Future<void> call({
    required String fromAccountId,
    required String toAccountId,
    required Money amount,
    DateTime? date,
    String? description,
  }) {
    if (fromAccountId == toAccountId) {
      throw const ValidationFailure(
        message: 'As contas de origem e destino devem ser diferentes.',
      );
    }
    if (!amount.isPositive) {
      throw const ValidationFailure(
        message: 'O valor da transferência deve ser maior que zero.',
      );
    }
    return _repository.transfer(
      fromAccountId: fromAccountId,
      toAccountId: toAccountId,
      amount: amount,
      date: date ?? DateTime.now().toUtc(),
      description: description,
    );
  }
}
