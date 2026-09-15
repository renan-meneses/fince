import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/errors/error_messages.dart';
import '../../../../core/errors/failure.dart';
import '../../../../core/theme/design_tokens.dart';
import '../../../../core/utils/color_utils.dart';
import '../../../../core/widgets/empty_state.dart';
import '../../../../core/widgets/error_view.dart';
import '../../../../core/widgets/section_header.dart';
import '../../domain/entities/category.dart';
import '../category_meta.dart';
import '../cubit/categories_cubit.dart';
import '../cubit/categories_state.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Categorias')),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddDialog(context),
        child: const Icon(Icons.add_rounded),
      ),
      body: SafeArea(
        child: BlocBuilder<CategoriesCubit, CategoriesState>(
          builder: (context, state) => switch (state) {
            CategoriesLoading() =>
              const Center(child: CircularProgressIndicator()),
            CategoriesFailure(:final failure) =>
              ErrorView(message: userMessageFor(failure)),
            CategoriesLoaded(:final categories) =>
              _CategoryList(categories: categories),
          },
        ),
      ),
    );
  }

  Future<void> _showAddDialog(BuildContext context) async {
    final nameController = TextEditingController();
    var type = CategoryType.expense;

    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => StatefulBuilder(
        builder: (context, setDialogState) => AlertDialog(
          title: const Text('Nova categoria'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                autofocus: true,
                decoration: const InputDecoration(labelText: 'Nome'),
              ),
              const SizedBox(height: AppSpacing.md),
              SegmentedButton<CategoryType>(
                segments: const [
                  ButtonSegment(
                    value: CategoryType.expense,
                    label: Text('Despesa'),
                  ),
                  ButtonSegment(
                    value: CategoryType.income,
                    label: Text('Receita'),
                  ),
                ],
                selected: {type},
                onSelectionChanged: (selection) =>
                    setDialogState(() => type = selection.first),
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
      ),
    );

    if (confirmed == true && nameController.text.trim().isNotEmpty) {
      final meta = defaultCategoryMeta(type);
      if (!context.mounted) return;
      try {
        await context.read<CategoriesCubit>().createCategory(
              name: nameController.text.trim(),
              type: type,
              icon: meta.icon,
              color: meta.color,
            );
      } on Failure catch (failure) {
        if (context.mounted) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(userMessageFor(failure))));
        }
      }
    }
    nameController.dispose();
  }
}

class _CategoryList extends StatelessWidget {
  const _CategoryList({required this.categories});

  final List<Category> categories;

  @override
  Widget build(BuildContext context) {
    if (categories.isEmpty) {
      return const EmptyState(
        icon: Icons.category_rounded,
        title: 'Nenhuma categoria',
        message: 'Crie categorias para organizar suas transações.',
      );
    }

    final expenses =
        categories.where((c) => c.type == CategoryType.expense).toList();
    final incomes =
        categories.where((c) => c.type == CategoryType.income).toList();

    return ListView(
      padding: const EdgeInsets.all(AppSpacing.md),
      children: [
        if (expenses.isNotEmpty) ...[
          const SectionHeader(title: 'Despesas'),
          ...expenses.map((c) => _CategoryTile(category: c)),
        ],
        if (incomes.isNotEmpty) ...[
          const SizedBox(height: AppSpacing.md),
          const SectionHeader(title: 'Receitas'),
          ...incomes.map((c) => _CategoryTile(category: c)),
        ],
      ],
    );
  }
}

class _CategoryTile extends StatelessWidget {
  const _CategoryTile({required this.category});

  final Category category;

  @override
  Widget build(BuildContext context) {
    final color = colorFromHex(category.color);
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: CircleAvatar(
        backgroundColor: color.withValues(alpha: 0.14),
        child: Icon(categoryIconByName(category.icon), color: color, size: 20),
      ),
      title: Text(category.name),
      trailing: category.isDefault
          ? null
          : IconButton(
              icon: const Icon(Icons.delete_outline_rounded),
              onPressed: () => context.read<CategoriesCubit>().deleteCategory(category.id),
            ),
    );
  }
}
