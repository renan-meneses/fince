import '../repositories/credit_card_repository.dart';

class PayInvoice {
  const PayInvoice(this._repository);

  final CreditCardRepository _repository;

  Future<void> call({required String invoiceId, required String accountId}) =>
      _repository.payInvoice(invoiceId: invoiceId, accountId: accountId);
}
