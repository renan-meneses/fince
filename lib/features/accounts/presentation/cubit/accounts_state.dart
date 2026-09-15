import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/errors/failure.dart';
import '../../domain/entities/account.dart';

part 'accounts_state.freezed.dart';

@freezed
sealed class AccountsState with _$AccountsState {
  const factory AccountsState.loading() = AccountsLoading;

  const factory AccountsState.loaded(List<Account> accounts) = AccountsLoaded;

  const factory AccountsState.failure(Failure failure) = AccountsFailure;
}
