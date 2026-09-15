import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/domain/money.dart';
import '../../../../core/errors/failure.dart';
import '../../domain/entities/account.dart';
import '../../domain/usecases/archive_account.dart';
import '../../domain/usecases/create_account.dart';
import '../../domain/usecases/transfer_between_accounts.dart';
import '../../domain/usecases/update_account.dart';
import '../../domain/usecases/watch_accounts.dart';
import 'accounts_state.dart';

/// Exposes the reactive account list and mutation actions.
///
/// The list is driven by a Drift `watch` stream, so any local mutation updates
/// the UI automatically. Mutations rethrow [Failure]s so screens can surface
/// a SnackBar without replacing the loaded list.
class AccountsCubit extends Cubit<AccountsState> {
  AccountsCubit({
    required WatchAccounts watchAccounts,
    required CreateAccount createAccount,
    required UpdateAccount updateAccount,
    required ArchiveAccount archiveAccount,
    required TransferBetweenAccounts transferBetweenAccounts,
  })  : _createAccount = createAccount,
        _updateAccount = updateAccount,
        _archiveAccount = archiveAccount,
        _transfer = transferBetweenAccounts,
        super(const AccountsState.loading()) {
    _subscription = watchAccounts().listen(
      _onAccounts,
      onError: _onError,
    );
  }

  final CreateAccount _createAccount;
  final UpdateAccount _updateAccount;
  final ArchiveAccount _archiveAccount;
  final TransferBetweenAccounts _transfer;

  late final StreamSubscription<List<Account>> _subscription;

  void _onAccounts(List<Account> accounts) {
    if (!isClosed) emit(AccountsState.loaded(accounts));
  }

  void _onError(Object error) {
    if (!isClosed) {
      emit(AccountsState.failure(
        error is Failure ? error : UnknownFailure(message: error.toString()),
      ));
    }
  }

  Future<void> createAccount({
    required String name,
    required AccountType type,
    required Money initialBalance,
    String? institution,
    required String color,
    required String icon,
  }) =>
      _createAccount(
        name: name,
        type: type,
        initialBalance: initialBalance,
        institution: institution,
        color: color,
        icon: icon,
      );

  Future<void> updateAccount(Account account) => _updateAccount(account);

  Future<void> archiveAccount(String id) => _archiveAccount(id);

  Future<void> transfer({
    required String fromAccountId,
    required String toAccountId,
    required Money amount,
    String? description,
  }) =>
      _transfer(
        fromAccountId: fromAccountId,
        toAccountId: toAccountId,
        amount: amount,
        description: description,
      );

  @override
  Future<void> close() {
    _subscription.cancel();
    return super.close();
  }
}
