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
import '../../domain/entities/credit_card.dart';
import '../cubit/credit_cards_cubit.dart';

class CreditCardFormScreen extends StatefulWidget {
  const CreditCardFormScreen({super.key});

  @override
  State<CreditCardFormScreen> createState() => _CreditCardFormScreenState();
}

class _CreditCardFormScreenState extends State<CreditCardFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _limitController = TextEditingController();
  final _closingController = TextEditingController(text: '10');
  final _dueController = TextEditingController(text: '5');
  CardBrand _brand = CardBrand.visa;
  String? _linkedAccountId;
  bool _submitting = false;

  @override
  void dispose() {
    _nameController.dispose();
    _limitController.dispose();
    _closingController.dispose();
    _dueController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _submitting = true);
    try {
      final limit = parseMoneyInput(
        _limitController.text,
        AppConstants.defaultCurrency,
      );
      await context.read<CreditCardsCubit>().createCard(
            name: _nameController.text.trim(),
            brand: _brand,
            creditLimit: limit,
            closingDay: int.parse(_closingController.text),
            dueDay: int.parse(_dueController.text),
            linkedAccountId: _linkedAccountId,
          );
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
      appBar: AppBar(title: const Text('Novo cartão')),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppSpacing.md),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextFormField(
                  controller: _nameController,
                  textCapitalization: TextCapitalization.words,
                  decoration: const InputDecoration(labelText: 'Nome'),
                  validator: (v) => validateRequired(v, 'Nome'),
                ),
                const SizedBox(height: AppSpacing.md),
                DropdownButtonFormField<CardBrand>(
                  initialValue: _brand,
                  decoration: const InputDecoration(labelText: 'Bandeira'),
                  items: CardBrand.values
                      .map(
                        (b) => DropdownMenuItem(value: b, child: Text(b.name)),
                      )
                      .toList(),
                  onChanged: (value) => setState(() => _brand = value!),
                ),
                const SizedBox(height: AppSpacing.md),
                TextFormField(
                  controller: _limitController,
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  decoration: const InputDecoration(
                    labelText: 'Limite',
                    prefixText: 'R\$ ',
                  ),
                  validator: validateAmount,
                ),
                const SizedBox(height: AppSpacing.md),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: _closingController,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          labelText: 'Dia de fechamento',
                        ),
                        validator: (v) => validateRequired(v, 'Fechamento'),
                      ),
                    ),
                    const SizedBox(width: AppSpacing.sm),
                    Expanded(
                      child: TextFormField(
                        controller: _dueController,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          labelText: 'Dia de vencimento',
                        ),
                        validator: (v) => validateRequired(v, 'Vencimento'),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.md),
                _LinkedAccountDropdown(
                  value: _linkedAccountId,
                  onChanged: (value) => setState(() => _linkedAccountId = value),
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
                      : const Text('Cadastrar cartão'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _LinkedAccountDropdown extends StatelessWidget {
  const _LinkedAccountDropdown({required this.value, required this.onChanged});

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
          decoration: const InputDecoration(labelText: 'Conta de pagamento'),
          items: accounts
              .map((a) => DropdownMenuItem(value: a.id, child: Text(a.name)))
              .toList(),
          onChanged: onChanged,
        );
      },
    );
  }
}
