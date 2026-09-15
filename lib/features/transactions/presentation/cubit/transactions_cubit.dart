import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/domain/money.dart';
import '../../../../core/errors/failure.dart';
import '../../domain/entities/transaction.dart';
import '../../domain/entities/transaction_filter.dart';
import '../../domain/usecases/create_transaction.dart';
import '../../domain/usecases/delete_transaction.dart';
import '../../domain/usecases/duplicate_transaction.dart';
import '../../domain/usecases/update_transaction.dart';
import '../../domain/usecases/watch_transactions.dart';
import 'transactions_state.dart';

/// Exposes a reactive, filterable/sortable transaction list.
class TransactionsCubit extends Cubit<TransactionsState> {
  TransactionsCubit({
    required WatchTransactions watchTransactions,
    required CreateTransaction createTransaction,
    required UpdateTransaction updateTransaction,
    required DeleteTransaction deleteTransaction,
    required DuplicateTransaction duplicateTransaction,
  })  : _watchTransactions = watchTransactions,
        _createTransaction = createTransaction,
        _updateTransaction = updateTransaction,
        _deleteTransaction = deleteTransaction,
        _duplicateTransaction = duplicateTransaction,
        super(const TransactionsState.loading()) {
    _relisten();
  }

  final WatchTransactions _watchTransactions;
  final CreateTransaction _createTransaction;
  final UpdateTransaction _updateTransaction;
  final DeleteTransaction _deleteTransaction;
  final DuplicateTransaction _duplicateTransaction;

  TransactionFilter _filter = const TransactionFilter();
  TransactionSort _sort = TransactionSort.dateDesc;
  StreamSubscription<List<Transaction>>? _subscription;

  TransactionFilter get filter => _filter;
  TransactionSort get sort => _sort;

  void setFilter(TransactionFilter filter) {
    _filter = filter;
    _relisten();
  }

  void setSort(TransactionSort sort) {
    _sort = sort;
    _relisten();
  }

  void setSearch(String query) {
    _filter = _filter.copyWith(query: query);
    _relisten();
  }

  void _relisten() {
    emit(const TransactionsState.loading());
    _subscription?.cancel();
    _subscription = _watchTransactions(filter: _filter, sort: _sort).listen(
      (transactions) {
        if (!isClosed) emit(TransactionsState.loaded(transactions));
      },
      onError: _onError,
    );
  }

  void _onError(Object error) {
    if (!isClosed) {
      emit(TransactionsState.failure(
        error is Failure ? error : UnknownFailure(message: error.toString()),
      ));
    }
  }

  Future<void> createTransaction({
    required String description,
    required Money amount,
    required TransactionType type,
    required String accountId,
    required DateTime date,
    String? categoryId,
    String? subcategoryId,
    PaymentStatus paymentStatus = PaymentStatus.paid,
    String? notes,
    List<String> tags = const [],
  }) =>
      _createTransaction(
        description: description,
        amount: amount,
        type: type,
        accountId: accountId,
        date: date,
        categoryId: categoryId,
        subcategoryId: subcategoryId,
        paymentStatus: paymentStatus,
        notes: notes,
        tags: tags,
      );

  Future<void> updateTransaction(Transaction transaction) =>
      _updateTransaction(transaction);

  Future<void> deleteTransaction(String id) => _deleteTransaction(id);

  Future<void> duplicateTransaction(String id) => _duplicateTransaction(id);

  @override
  Future<void> close() {
    _subscription?.cancel();
    return super.close();
  }
}
