import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/domain/money.dart';
import '../../../../core/errors/failure.dart';
import '../../domain/entities/credit_card.dart';
import '../../domain/entities/credit_card_invoice.dart';
import '../../domain/entities/installment.dart';
import '../../domain/usecases/create_card.dart';
import '../../domain/usecases/get_invoices.dart';
import '../../domain/usecases/pay_invoice.dart';
import '../../domain/usecases/register_purchase.dart';
import '../../domain/usecases/watch_cards.dart';
import 'credit_cards_state.dart';

/// Exposes the reactive credit-card list and card actions.
class CreditCardsCubit extends Cubit<CreditCardsState> {
  CreditCardsCubit({
    required WatchCards watchCards,
    required CreateCard createCard,
    required RegisterPurchase registerPurchase,
    required GetInvoices getInvoices,
    required PayInvoice payInvoice,
  })  : _createCard = createCard,
        _registerPurchase = registerPurchase,
        _getInvoices = getInvoices,
        _payInvoice = payInvoice,
        super(const CreditCardsState.loading()) {
    _subscription = watchCards().listen(_onCards, onError: _onError);
  }

  final CreateCard _createCard;
  final RegisterPurchase _registerPurchase;
  final GetInvoices _getInvoices;
  final PayInvoice _payInvoice;

  late final StreamSubscription<List<CreditCard>> _subscription;

  void _onCards(List<CreditCard> cards) {
    if (!isClosed) emit(CreditCardsState.loaded(cards));
  }

  void _onError(Object error) {
    if (!isClosed) {
      emit(CreditCardsState.failure(
        error is Failure ? error : UnknownFailure(message: error.toString()),
      ));
    }
  }

  Future<void> createCard({
    required String name,
    required CardBrand brand,
    required Money creditLimit,
    required int closingDay,
    required int dueDay,
    String? linkedAccountId,
  }) =>
      _createCard(
        name: name,
        brand: brand,
        creditLimit: creditLimit,
        closingDay: closingDay,
        dueDay: dueDay,
        linkedAccountId: linkedAccountId,
      );

  Future<List<Installment>> registerPurchase({
    required String cardId,
    required String description,
    required Money amount,
    required int installments,
    String? categoryId,
    required DateTime date,
  }) =>
      _registerPurchase(
        cardId: cardId,
        description: description,
        amount: amount,
        installments: installments,
        categoryId: categoryId,
        date: date,
      );

  Future<List<CreditCardInvoice>> getInvoices(String cardId) =>
      _getInvoices(cardId);

  Future<void> payInvoice({required String invoiceId, required String accountId}) =>
      _payInvoice(invoiceId: invoiceId, accountId: accountId);

  @override
  Future<void> close() {
    _subscription.cancel();
    return super.close();
  }
}
