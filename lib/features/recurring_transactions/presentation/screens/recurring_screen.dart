import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/errors/error_messages.dart';
import '../../../../core/theme/design_tokens.dart';
import '../../../../core/widgets/empty_state.dart';
import '../../../../core/widgets/error_view.dart';
import '../../domain/entities/recurring_transaction.dart';
import '../cubit/recurring_cubit.dart';
import '../cubit/recurring_state.dart';

class RecurringScreen extends StatelessWidget {
  const RecurringScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Recorrências'),
        actions: [
          IconButton(
            icon: const Icon(Icons.autorenew_rounded),
            tooltip: 'Gerar vencimentos',
            onPressed: () => context.read<RecurringCubit>().generateNow(),
          ),
        ],
      ),
      body: SafeArea(
        child: BlocBuilder<RecurringCubit, RecurringState>(
          builder: (context, state) => switch (state) {
            RecurringLoading() =>
              const Center(child: CircularProgressIndicator()),
            RecurringFailure(:final failure) =>
              ErrorView(message: userMessageFor(failure)),
            RecurringLoaded(:final items) => _RecurringList(items: items),
          },
        ),
      ),
    );
  }
}

class _RecurringList extends StatelessWidget {
  const _RecurringList({required this.items});

  final List<RecurringTransaction> items;

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) {
      return const EmptyState(
        icon: Icons.repeat_rounded,
        title: 'Nenhuma recorrência',
        message: 'Configure receitas ou despesas recorrentes.',
      );
    }

    return ListView.separated(
      padding: const EdgeInsets.all(AppSpacing.md),
      itemCount: items.length,
      separatorBuilder: (_, _) => const Divider(height: 1),
      itemBuilder: (context, index) {
        final item = items[index];
        return ListTile(
          contentPadding: EdgeInsets.zero,
          leading: const Icon(Icons.repeat_rounded),
          title: Text(item.description),
          subtitle: Text(
            '${_frequencyLabel(item.rule.frequency)} · '
            '${item.amount.format()}',
          ),
          trailing: IconButton(
            icon: const Icon(Icons.delete_outline_rounded),
            onPressed: () => context.read<RecurringCubit>().delete(item.id),
          ),
        );
      },
    );
  }

  String _frequencyLabel(RecurrenceFrequency frequency) => switch (frequency) {
        RecurrenceFrequency.daily => 'Diária',
        RecurrenceFrequency.weekly => 'Semanal',
        RecurrenceFrequency.monthly => 'Mensal',
        RecurrenceFrequency.yearly => 'Anual',
        RecurrenceFrequency.custom => 'Personalizada',
      };
}
