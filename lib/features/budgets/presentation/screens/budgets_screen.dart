import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/di/injection.dart';
import '../../../../core/errors/error_messages.dart';
import '../../../../core/errors/failure.dart';
import '../../../../core/theme/design_tokens.dart';
import '../../../../core/utils/formatters.dart';
import '../../../../core/widgets/budget_progress_card.dart';
import '../../../../core/widgets/empty_state.dart';
import '../../../../core/widgets/error_view.dart';
import '../../../categories/domain/entities/category.dart';
import '../../../categories/presentation/cubit/categories_cubit.dart';
import '../../../categories/presentation/cubit/categories_state.dart';
import '../../domain/entities/budget_status.dart';
import '../cubit/budgets_cubit.dart';
import '../cubit/budgets_state.dart';

class BudgetsScreen extends StatelessWidget {
  const BudgetsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Orçamentos')),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddDialog(context),
        child: const Icon(Icons.add_rounded),
      ),
      body: SafeArea(
        child: BlocBuilder<BudgetsCubit, BudgetsState>(
          builder: (context, state) => switch (state) {
            BudgetsLoading() =>
              const Center(child: CircularProgressIndicator()),
            BudgetsFailure(:final failure) =>
              ErrorView(message: userMessageFor(failure)),
            BudgetsLoaded(:final budgets) => _BudgetList(budgets: budgets),
          },
        ),
      ),
    );
  }

  Future<void> _showAddDialog(BuildContext context) async {
    final amountController = TextEditingController();
    String? categoryId;

    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => StatefulBuilder(
        builder: (context, setDialogState) {
          final categoriesState = sl<CategoriesCubit>().state;
          final categories = categoriesState is CategoriesLoaded
              ? categoriesState.categories
                  .where((c) => c.type == CategoryType.expense)
                  .toList()
              : <Category>[];
          return AlertDialog(
            title: const Text('Novo orçamento'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                DropdownButtonFormField<String>(
                  decoration: const InputDecoration(labelText: 'Categoria'),
                  items: categories
                      .map(
                        (c) => DropdownMenuItem(
                          value: c.id,
                          child: Text(c.name),
                        ),
                      )
                      .toList(),
                  onChanged: (value) => setDialogState(() => categoryId = value),
                ),
                const SizedBox(height: AppSpacing.md),
                TextField(
                  controller: amountController,
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  decoration: const InputDecoration(
                    labelText: 'Valor',
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
          );
        },
      ),
    );

    if (confirmed == true && categoryId != null) {
      if (!context.mounted) return;
      try {
        final amount = parseMoneyInput(
          amountController.text,
          AppConstants.defaultCurrency,
        );
        final month = context.read<BudgetsCubit>().month;
        await context.read<BudgetsCubit>().createBudget(
              categoryId: categoryId!,
              amount: amount,
              month: month,
            );
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

class _BudgetList extends StatelessWidget {
  const _BudgetList({required this.budgets});

  final List<BudgetStatus> budgets;

  @override
  Widget build(BuildContext context) {
    if (budgets.isEmpty) {
      return const EmptyState(
        icon: Icons.pie_chart_rounded,
        title: 'Nenhum orçamento',
        message: 'Defina limites mensais por categoria.',
      );
    }

    return ListView(
      padding: const EdgeInsets.all(AppSpacing.md),
      children: [
        for (final status in budgets) ...[
          BudgetProgressCard(
            name: status.categoryName,
            spent: status.spent,
            limit: status.budget.amount,
          ),
          const SizedBox(height: AppSpacing.sm),
        ],
      ],
    );
  }
}
