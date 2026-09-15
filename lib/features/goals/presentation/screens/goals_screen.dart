import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/errors/error_messages.dart';
import '../../../../core/errors/failure.dart';
import '../../../../core/theme/design_tokens.dart';
import '../../../../core/utils/formatters.dart';
import '../../../../core/widgets/empty_state.dart';
import '../../../../core/widgets/error_view.dart';
import '../../../../core/widgets/goal_progress_card.dart';
import '../../domain/entities/financial_goal.dart';
import '../cubit/goals_cubit.dart';
import '../cubit/goals_state.dart';

class GoalsScreen extends StatelessWidget {
  const GoalsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Metas')),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddDialog(context),
        child: const Icon(Icons.add_rounded),
      ),
      body: SafeArea(
        child: BlocBuilder<GoalsCubit, GoalsState>(
          builder: (context, state) => switch (state) {
            GoalsLoading() => const Center(child: CircularProgressIndicator()),
            GoalsFailure(:final failure) =>
              ErrorView(message: userMessageFor(failure)),
            GoalsLoaded(:final goals) => _GoalList(goals: goals),
          },
        ),
      ),
    );
  }

  Future<void> _showAddDialog(BuildContext context) async {
    final nameController = TextEditingController();
    final amountController = TextEditingController();

    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Nova meta'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              autofocus: true,
              decoration: const InputDecoration(labelText: 'Nome'),
            ),
            const SizedBox(height: AppSpacing.md),
            TextField(
              controller: amountController,
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              decoration: const InputDecoration(
                labelText: 'Valor alvo',
                prefixText: 'R\$ ',
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, false),
            child: const Text('Cancelar'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(dialogContext, true),
            child: const Text('Criar'),
          ),
        ],
      ),
    );

    if (confirmed == true &&
        nameController.text.trim().isNotEmpty &&
        amountController.text.trim().isNotEmpty) {
      if (!context.mounted) return;
      try {
        final amount = parseMoneyInput(
          amountController.text,
          AppConstants.defaultCurrency,
        );
        await context.read<GoalsCubit>().createGoal(
              name: nameController.text.trim(),
              targetAmount: amount,
            );
      } on Failure catch (failure) {
        if (context.mounted) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(userMessageFor(failure))));
        }
      }
    }
    nameController.dispose();
    amountController.dispose();
  }
}

class _GoalList extends StatelessWidget {
  const _GoalList({required this.goals});

  final List<FinancialGoal> goals;

  @override
  Widget build(BuildContext context) {
    if (goals.isEmpty) {
      return const EmptyState(
        icon: Icons.flag_rounded,
        title: 'Nenhuma meta',
        message: 'Crie metas para guardar dinheiro com propósito.',
      );
    }

    return ListView(
      padding: const EdgeInsets.all(AppSpacing.md),
      children: [
        for (final goal in goals) ...[
          GoalProgressCard(
            name: goal.name,
            current: goal.currentAmount,
            target: goal.targetAmount,
            targetDate: goal.targetDate,
          ),
          Align(
            alignment: Alignment.centerRight,
            child: TextButton.icon(
              onPressed: () => _showDepositDialog(context, goal),
              icon: const Icon(Icons.add_circle_outline_rounded),
              label: const Text('Depositar'),
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
        ],
      ],
    );
  }

  Future<void> _showDepositDialog(
    BuildContext context,
    FinancialGoal goal,
  ) async {
    final amountController = TextEditingController();
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text('Depositar em ${goal.name}'),
        content: TextField(
          controller: amountController,
          autofocus: true,
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          decoration: const InputDecoration(
            labelText: 'Valor',
            prefixText: 'R\$ ',
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, false),
            child: const Text('Cancelar'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(dialogContext, true),
            child: const Text('Depositar'),
          ),
        ],
      ),
    );

    if (confirmed == true && amountController.text.trim().isNotEmpty) {
      if (!context.mounted) return;
      try {
        final amount = parseMoneyInput(
          amountController.text,
          AppConstants.defaultCurrency,
        );
        await context.read<GoalsCubit>().deposit(id: goal.id, amount: amount);
      } on Failure catch (failure) {
        if (context.mounted) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(userMessageFor(failure))));
        }
      }
    }
    amountController.dispose();
  }
}
