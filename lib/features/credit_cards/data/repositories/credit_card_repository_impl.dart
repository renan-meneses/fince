import '../../../../core/domain/money.dart';
import '../../../../core/errors/exception_to_failure.dart';
import '../../domain/entities/credit_card.dart';
import '../../domain/entities/credit_card_invoice.dart';
import '../../domain/entities/installment.dart';
import '../../domain/repositories/credit_card_repository.dart';
import '../datasources/credit_card_local_data_source.dart';

/// Local-first [CreditCardRepository].
class CreditCardRepositoryImpl implements CreditCardRepository {
  CreditCardRepositoryImpl({required CreditCardLocalDataSource local})
      : _local = local;

  final CreditCardLocalDataSource _local;

  @override
  Stream<List<CreditCard>> watchCards() => _local.watchAll();

  @override
  Future<CreditCard> createCard(CreditCard card) async {
    try {
      return await _local.insertCard(card);
    } catch (e) {
      throw mapExceptionToFailure(e);
    }
  }

  @override
  Future<CreditCard> updateCard(CreditCard card) async {
    try {
      return await _local.updateCard(card);
    } catch (e) {
      throw mapExceptionToFailure(e);
    }
  }

  @override
  Future<void> archiveCard(String id) async {
    try {
      await _local.archiveCard(id);
    } catch (e) {
      throw mapExceptionToFailure(e);
    }
  }

  @override
  Future<List<Installment>> registerPurchase({
    required String cardId,
    required String description,
    required Money amount,
    required int installments,
    String? categoryId,
    required DateTime date,
  }) async {
    try {
      return await _local.registerPurchase(
        cardId: cardId,
        description: description,
        amount: amount,
        installments: installments,
        categoryId: categoryId,
        date: date,
      );
    } catch (e) {
      throw mapExceptionToFailure(e);
    }
  }

  @override
  Future<List<CreditCardInvoice>> getInvoices(String cardId) async {
    try {
      return await _local.getInvoices(cardId);
    } catch (e) {
      throw mapExceptionToFailure(e);
    }
  }

  @override
  Future<void> payInvoice({
    required String invoiceId,
    required String accountId,
  }) async {
    try {
      await _local.payInvoice(invoiceId: invoiceId, accountId: accountId);
    } catch (e) {
      throw mapExceptionToFailure(e);
    }
  }
}
