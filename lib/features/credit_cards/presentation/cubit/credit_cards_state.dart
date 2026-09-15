import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/errors/failure.dart';
import '../../domain/entities/credit_card.dart';

part 'credit_cards_state.freezed.dart';

@freezed
sealed class CreditCardsState with _$CreditCardsState {
  const factory CreditCardsState.loading() = CreditCardsLoading;

  const factory CreditCardsState.loaded(List<CreditCard> cards) =
      CreditCardsLoaded;

  const factory CreditCardsState.failure(Failure failure) = CreditCardsFailure;
}
