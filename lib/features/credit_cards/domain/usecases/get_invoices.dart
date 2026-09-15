import '../entities/credit_card_invoice.dart';
import '../repositories/credit_card_repository.dart';

class GetInvoices {
  const GetInvoices(this._repository);

  final CreditCardRepository _repository;

  Future<List<CreditCardInvoice>> call(String cardId) =>
      _repository.getInvoices(cardId);
}
