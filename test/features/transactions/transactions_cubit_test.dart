import 'package:fince/core/domain/money.dart';
import 'package:fince/features/transactions/domain/entities/transaction.dart';
import 'package:fince/features/transactions/domain/entities/transaction_filter.dart';
import 'package:fince/features/transactions/domain/repositories/transaction_repository.dart';
import 'package:fince/features/transactions/domain/usecases/create_transaction.dart';
import 'package:fince/features/transactions/domain/usecases/delete_transaction.dart';
import 'package:fince/features/transactions/domain/usecases/duplicate_transaction.dart';
import 'package:fince/features/transactions/domain/usecases/update_transaction.dart';
import 'package:fince/features/transactions/domain/usecases/watch_transactions.dart';
import 'package:fince/features/transactions/presentation/cubit/transactions_cubit.dart';
import 'package:fince/features/transactions/presentation/cubit/transactions_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class _MockTransactionRepository extends Mock
    implements TransactionRepository {}

final _txn = Transaction(
  id: 't1',
  description: 'Salário',
  amount: Money(50000, 'BRL'),
  type: TransactionType.income,
  accountId: 'a1',
  date: DateTime(2026, 9, 1),
  paymentStatus: PaymentStatus.paid,
  tags: const [],
  createdAt: DateTime(2026, 9, 1),
  updatedAt: DateTime(2026, 9, 1),
);

void main() {
  setUpAll(() {
    registerFallbackValue(const TransactionFilter());
    registerFallbackValue(TransactionSort.dateDesc);
  });

  TransactionsCubit buildCubit(_MockTransactionRepository repo) =>
      TransactionsCubit(
        watchTransactions: WatchTransactions(repo),
        createTransaction: CreateTransaction(repo),
        updateTransaction: UpdateTransaction(repo),
        deleteTransaction: DeleteTransaction(repo),
        duplicateTransaction: DuplicateTransaction(repo),
      );

  test('emits loaded transactions from the reactive stream', () async {
    final repo = _MockTransactionRepository();
    when(
      () => repo.watchTransactions(
        filter: any(named: 'filter'),
        sort: any(named: 'sort'),
      ),
    ).thenAnswer((_) => Stream.value([_txn]));

    final cubit = buildCubit(repo);
    await cubit.stream.firstWhere((s) => s is TransactionsLoaded);

    expect(cubit.state, isA<TransactionsLoaded>());
    final state = cubit.state as TransactionsLoaded;
    expect(state.transactions, hasLength(1));
    expect(state.transactions.first.description, 'Salário');
  });

  test('setSearch updates the active query filter', () async {
    final repo = _MockTransactionRepository();
    when(
      () => repo.watchTransactions(
        filter: any(named: 'filter'),
        sort: any(named: 'sort'),
      ),
    ).thenAnswer((_) => Stream.value(const []));

    final cubit = buildCubit(repo);
    await cubit.stream.firstWhere((s) => s is TransactionsLoaded);

    cubit.setSearch('aluguel');

    expect(cubit.filter.query, 'aluguel');
    verify(
      () => repo.watchTransactions(
        filter: any(
          named: 'filter',
          that: isA<TransactionFilter>()
              .having((f) => f.query, 'query', 'aluguel'),
        ),
        sort: any(named: 'sort'),
      ),
    ).called(1);
  });
}
