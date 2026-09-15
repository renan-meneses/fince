import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/errors/failure.dart';
import '../../domain/entities/transaction.dart';

part 'transactions_state.freezed.dart';

@freezed
sealed class TransactionsState with _$TransactionsState {
  const factory TransactionsState.loading() = TransactionsLoading;

  const factory TransactionsState.loaded(List<Transaction> transactions) =
      TransactionsLoaded;

  const factory TransactionsState.failure(Failure failure) =
      TransactionsFailure;
}
