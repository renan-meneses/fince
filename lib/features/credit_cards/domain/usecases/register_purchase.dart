import '../../../../core/domain/money.dart';
import '../../../../core/errors/failure.dart';
import '../entities/installment.dart';
import '../repositories/credit_card_repository.dart';

/// Registers a card purchase and splits it into installments.
class RegisterPurchase {
  const RegisterPurchase(this._repository);

  final CreditCardRepository _repository;

  Future<List<Installment>> call({
    required String cardId,
    required String description,
    required Money amount,
    required int installments,
    String? categoryId,
    required DateTime date,
  }) {
    if (description.trim().isEmpty) {
      throw const ValidationFailure(message: 'Informe uma descrição.');
    }
    if (!amount.isPositive) {
      throw const ValidationFailure(message: 'O valor deve ser maior que zero.');
    }
    if (installments <= 0) {
      throw const ValidationFailure(message: 'Número de parcelas inválido.');
    }
    return _repository.registerPurchase(
      cardId: cardId,
      description: description,
      amount: amount,
      installments: installments,
      categoryId: categoryId,
      date: date,
    );
  }
}
