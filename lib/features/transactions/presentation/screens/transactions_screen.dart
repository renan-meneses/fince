import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/errors/error_messages.dart';
import '../../../../core/theme/design_tokens.dart';
import '../../../../core/utils/debouncer.dart';
import '../../../../core/utils/formatters.dart';
import '../../../../core/widgets/empty_state.dart';
import '../../../../core/widgets/error_view.dart';
import '../../../../core/widgets/transaction_tile.dart';
import '../../domain/entities/transaction.dart';
import '../../domain/entities/transaction_filter.dart';
import '../cubit/transactions_cubit.dart';
import '../cubit/transactions_state.dart';

class TransactionsScreen extends StatefulWidget {
  const TransactionsScreen({super.key});

  @override
  State<TransactionsScreen> createState() => _TransactionsScreenState();
}

class _TransactionsScreenState extends State<TransactionsScreen> {
  final _searchController = TextEditingController();
  final _debouncer = Debouncer();

  @override
  void dispose() {
    _searchController.dispose();
    _debouncer.cancel();
    super.dispose();
  }

  void _onSearchChanged(String value) {
    _debouncer.run(() {
      if (mounted) context.read<TransactionsCubit>().setSearch(value);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Transações'),
        actions: [
          _SortMenu(cubit: context.read<TransactionsCubit>()),
          IconButton(
            icon: const Icon(Icons.tune_rounded),
            onPressed: () => _openFilterSheet(context),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.push('/transactions/new'),
        child: const Icon(Icons.add_rounded),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(
                AppSpacing.md,
                AppSpacing.xs,
                AppSpacing.md,
                AppSpacing.sm,
              ),
              child: TextField(
                controller: _searchController,
                onChanged: _onSearchChanged,
                decoration: const InputDecoration(
                  hintText: 'Buscar transações…',
                  prefixIcon: Icon(Icons.search_rounded),
                ),
              ),
            ),
            Expanded(
              child: BlocBuilder<TransactionsCubit, TransactionsState>(
                builder: (context, state) => switch (state) {
                  TransactionsLoading() =>
                    const Center(child: CircularProgressIndicator()),
                  TransactionsFailure(:final failure) =>
                    ErrorView(message: userMessageFor(failure)),
                  TransactionsLoaded(:final transactions) =>
                    _TransactionList(transactions: transactions),
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _openFilterSheet(BuildContext context) async {
    final cubit = context.read<TransactionsCubit>();
    final result = await showModalBottomSheet<TransactionFilter>(
      context: context,
      isScrollControlled: true,
      builder: (_) => _FilterSheet(initial: cubit.filter),
    );
    if (result != null) cubit.setFilter(result);
  }
}

class _SortMenu extends StatelessWidget {
  const _SortMenu({required this.cubit});

  final TransactionsCubit cubit;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<TransactionSort>(
      icon: const Icon(Icons.sort_rounded),
      onSelected: cubit.setSort,
      itemBuilder: (context) => const [
        PopupMenuItem(
          value: TransactionSort.dateDesc,
          child: Text('Data (mais recente)'),
        ),
        PopupMenuItem(
          value: TransactionSort.dateAsc,
          child: Text('Data (mais antiga)'),
        ),
        PopupMenuItem(
          value: TransactionSort.amountDesc,
          child: Text('Valor (maior)'),
        ),
        PopupMenuItem(
          value: TransactionSort.amountAsc,
          child: Text('Valor (menor)'),
        ),
      ],
    );
  }
}

class _TransactionList extends StatelessWidget {
  const _TransactionList({required this.transactions});

  final List<Transaction> transactions;

  @override
  Widget build(BuildContext context) {
    if (transactions.isEmpty) {
      return const EmptyState(
        icon: Icons.receipt_long_rounded,
        title: 'Nenhuma transação',
        message: 'Toque em + para registrar uma receita ou despesa.',
      );
    }

    return ListView.separated(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
      itemCount: transactions.length,
      separatorBuilder: (_, _) => const Divider(height: 1),
      itemBuilder: (context, index) {
        final t = transactions[index];
        return TransactionTile(
          title: t.description,
          subtitle: formatDate(t.date),
          amount: t.amount,
          kind: _kindFor(t.type),
          onTap: () => context.push('/transactions/${t.id}'),
        );
      },
    );
  }

  TransactionKind _kindFor(TransactionType type) => switch (type) {
        TransactionType.income => TransactionKind.income,
        TransactionType.expense => TransactionKind.expense,
        TransactionType.transfer => TransactionKind.transfer,
      };
}

class _FilterSheet extends StatelessWidget {
  const _FilterSheet({required this.initial});

  final TransactionFilter initial;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppSpacing.lg),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text('Filtros', style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: AppSpacing.md),
          SegmentedButton<TransactionType?>(
            segments: const [
              ButtonSegment(value: null, label: Text('Todas')),
              ButtonSegment(value: TransactionType.income, label: Text('Receitas')),
              ButtonSegment(value: TransactionType.expense, label: Text('Despesas')),
              ButtonSegment(value: TransactionType.transfer, label: Text('Transf.')),
            ],
            selected: {initial.type},
            onSelectionChanged: (selection) => Navigator.pop(
              context,
              initial.copyWith(type: selection.first),
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          FilledButton.tonal(
            onPressed: () =>
                Navigator.pop(context, const TransactionFilter()),
            child: const Text('Limpar filtros'),
          ),
        ],
      ),
    );
  }
}
