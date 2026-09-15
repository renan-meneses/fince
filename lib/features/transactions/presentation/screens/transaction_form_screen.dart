import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/di/injection.dart';
import '../../../../core/errors/error_messages.dart';
import '../../../../core/errors/failure.dart';
import '../../../../core/theme/design_tokens.dart';
import '../../../../core/utils/formatters.dart';
import '../../../../core/utils/validators.dart';
import '../../../accounts/domain/entities/account.dart';
import '../../../accounts/presentation/cubit/accounts_cubit.dart';
import '../../../accounts/presentation/cubit/accounts_state.dart';
import '../../../categories/domain/entities/category.dart';
import '../../../categories/presentation/cubit/categories_cubit.dart';
import '../../../categories/presentation/cubit/categories_state.dart';
import '../../domain/entities/transaction.dart';
import '../cubit/transactions_cubit.dart';
import '../cubit/transactions_state.dart';

class TransactionFormScreen extends StatefulWidget {
  const TransactionFormScreen({super.key, this.transactionId});

  final String? transactionId;

  bool get isEditing => transactionId != null;

  @override
  State<TransactionFormScreen> createState() => _TransactionFormScreenState();
}

class _TransactionFormScreenState extends State<TransactionFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _descriptionController = TextEditingController();
  final _amountController = TextEditingController();
  final _notesController = TextEditingController();

  TransactionType _type = TransactionType.expense;
  String? _accountId;
  String? _categoryId;
  PaymentStatus _status = PaymentStatus.paid;
  DateTime _date = DateTime.now();
  bool _submitting = false;

  Transaction? get _existing {
    final state = sl<TransactionsCubit>().state;
    if (state is TransactionsLoaded) {
      for (final t in state.transactions) {
        if (t.id == widget.transactionId) return t;
      }
    }
    return null;
  }

  @override
  void initState() {
    super.initState();
    final existing = _existing;
    if (existing != null) {
      _descriptionController.text = existing.description;
      _amountController.text = (existing.amount.minorUnits / 100).toStringAsFixed(2);
      _notesController.text = existing.notes ?? '';
      _type = existing.type;
      _accountId = existing.accountId;
      _categoryId = existing.categoryId;
      _status = existing.paymentStatus;
      _date = existing.date;
    }
  }

  @override
  void dispose() {
    _descriptionController.dispose();
    _amountController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _date,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null) setState(() => _date = picked);
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    if (_accountId == null) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Selecione uma conta.')));
      return;
    }
    setState(() => _submitting = true);
    final cubit = context.read<TransactionsCubit>();
    try {
      final amount = parseMoneyInput(
        _amountController.text,
        AppConstants.defaultCurrency,
      );
      if (widget.isEditing) {
        final existing = _existing!;
        final updated = existing.copyWith(
          description: _descriptionController.text.trim(),
          amount: amount,
          type: _type,
          accountId: _accountId!,
          categoryId: _categoryId,
          date: _date,
          paymentStatus: _status,
          notes: _notesController.text.trim().isEmpty
              ? null
              : _notesController.text.trim(),
          updatedAt: DateTime.now().toUtc(),
        );
        await cubit.updateTransaction(updated);
      } else {
        await cubit.createTransaction(
          description: _descriptionController.text.trim(),
          amount: amount,
          type: _type,
          accountId: _accountId!,
          categoryId: _categoryId,
          date: _date,
          paymentStatus: _status,
          notes: _notesController.text.trim().isEmpty
              ? null
              : _notesController.text.trim(),
        );
      }
      if (mounted) context.pop();
    } on Failure catch (failure) {
      if (mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(userMessageFor(failure))));
      }
    } finally {
      if (mounted) setState(() => _submitting = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.isEditing ? 'Editar transação' : 'Nova transação'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppSpacing.md),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SegmentedButton<TransactionType>(
                  segments: const [
                    ButtonSegment(
                      value: TransactionType.expense,
                      label: Text('Despesa'),
                    ),
                    ButtonSegment(
                      value: TransactionType.income,
                      label: Text('Receita'),
                    ),
                  ],
                  selected: {_type},
                  onSelectionChanged: (selection) =>
                      setState(() => _type = selection.first),
                ),
                const SizedBox(height: AppSpacing.md),
                TextFormField(
                  controller: _descriptionController,
                  textCapitalization: TextCapitalization.sentences,
                  decoration: const InputDecoration(labelText: 'Descrição'),
                  validator: (v) => validateRequired(v, 'Descrição'),
                ),
                const SizedBox(height: AppSpacing.md),
                TextFormField(
                  controller: _amountController,
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  decoration: const InputDecoration(
                    labelText: 'Valor',
                    prefixText: 'R\$ ',
                  ),
                  validator: validateAmount,
                ),
                const SizedBox(height: AppSpacing.md),
                _AccountDropdown(
                  value: _accountId,
                  onChanged: (value) => setState(() => _accountId = value),
                ),
                const SizedBox(height: AppSpacing.md),
                _CategoryDropdown(
                  type: _type,
                  value: _categoryId,
                  onChanged: (value) => setState(() => _categoryId = value),
                ),
                const SizedBox(height: AppSpacing.md),
                DropdownButtonFormField<PaymentStatus>(
                  initialValue: _status,
                  decoration: const InputDecoration(labelText: 'Status'),
                  items: PaymentStatus.values
                      .map(
                        (s) => DropdownMenuItem(value: s, child: Text(s.name)),
                      )
                      .toList(),
                  onChanged: (value) => setState(() => _status = value!),
                ),
                const SizedBox(height: AppSpacing.md),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: const Icon(Icons.event_rounded),
                  title: Text(
                    formatDate(_date),
                  ),
                  trailing: const Icon(Icons.edit_rounded),
                  onTap: _pickDate,
                ),
                const SizedBox(height: AppSpacing.md),
                TextFormField(
                  controller: _notesController,
                  maxLines: 2,
                  decoration: const InputDecoration(
                    labelText: 'Observações (opcional)',
                  ),
                ),
                const SizedBox(height: AppSpacing.xl),
                FilledButton(
                  onPressed: _submitting ? null : _submit,
                  child: _submitting
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : Text(widget.isEditing ? 'Salvar' : 'Adicionar'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _AccountDropdown extends StatelessWidget {
  const _AccountDropdown({required this.value, required this.onChanged});

  final String? value;
  final ValueChanged<String?> onChanged;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AccountsCubit, AccountsState>(
      bloc: sl<AccountsCubit>(),
      builder: (context, state) {
        final accounts = state is AccountsLoaded ? state.accounts : <Account>[];
        return DropdownButtonFormField<String>(
          initialValue: value,
          decoration: const InputDecoration(labelText: 'Conta'),
          items: accounts
              .map((a) => DropdownMenuItem(value: a.id, child: Text(a.name)))
              .toList(),
          onChanged: onChanged,
        );
      },
    );
  }
}

class _CategoryDropdown extends StatelessWidget {
  const _CategoryDropdown({
    required this.type,
    required this.value,
    required this.onChanged,
  });

  final TransactionType type;
  final String? value;
  final ValueChanged<String?> onChanged;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoriesCubit, CategoriesState>(
      bloc: sl<CategoriesCubit>(),
      builder: (context, state) {
        final categories = state is CategoriesLoaded
            ? state.categories
                .where((c) =>
                    c.type ==
                    (type == TransactionType.income
                        ? CategoryType.income
                        : CategoryType.expense))
                .toList()
            : <Category>[];
        return DropdownButtonFormField<String>(
          initialValue: value,
          decoration: const InputDecoration(labelText: 'Categoria'),
          items: categories
              .map((c) => DropdownMenuItem(value: c.id, child: Text(c.name)))
              .toList(),
          onChanged: onChanged,
        );
      },
    );
  }
}
