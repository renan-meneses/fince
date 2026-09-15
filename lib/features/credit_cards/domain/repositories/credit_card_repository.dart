import '../../../../core/domain/money.dart';
import '../entities/credit_card.dart';
import '../entities/credit_card_invoice.dart';
import '../entities/installment.dart';

/// Credit card contract (domain port).
abstract interface class CreditCardRepository {
  Stream<List<CreditCard>> watchCards();

  Future<CreditCard> createCard(CreditCard card);

  Future<CreditCard> updateCard(CreditCard card);

  Future<void> archiveCard(String id);

  /// Registers a card purchase, splitting it into [installments] installments.
  Future<List<Installment>> registerPurchase({
    required String cardId,
    required String description,
    required Money amount,
    required int installments,
    String? categoryId,
    required DateTime date,
  });

  Future<List<CreditCardInvoice>> getInvoices(String cardId);

  /// Pays an invoice from a linked account.
  Future<void> payInvoice({required String invoiceId, required String accountId});
}
