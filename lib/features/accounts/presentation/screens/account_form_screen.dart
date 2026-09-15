import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/errors/error_messages.dart';
import '../../../../core/errors/failure.dart';
import '../../../../core/theme/design_tokens.dart';
import '../../../../core/utils/formatters.dart';
import '../../../../core/utils/validators.dart';
import '../../domain/entities/account.dart';
import '../account_type_meta.dart';
import '../cubit/accounts_cubit.dart';
import '../cubit/accounts_state.dart';

class AccountFormScreen extends StatefulWidget {
  const AccountFormScreen({super.key, this.accountId});

  final String? accountId;

  bool get isEditing => accountId != null;

  @override
  State<AccountFormScreen> createState() => _AccountFormScreenState();
}

class _AccountFormScreenState extends State<AccountFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _institutionController = TextEditingController();
  final _balanceController = TextEditingController();

  AccountType _type = AccountType.checking;
  Color _color = accountColorOptions.first;
  IconData _icon = accountIconOptions.first;
  bool _submitting = false;

  Account? get _existing {
    final state = context.read<AccountsCubit>().state;
    if (state is AccountsLoaded) {
      for (final account in state.accounts) {
        if (account.id == widget.accountId) return account;
      }
    }
    return null;
  }

  @override
  void initState() {
    super.initState();
    final existing = _existing;
    if (existing != null) {
      _nameController.text = existing.name;
      _institutionController.text = existing.institution ?? '';
      _type = existing.type;
      _color = colorFromHex(existing.color);
      _icon = accountIconByName(existing.icon);
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _institutionController.dispose();
    _balanceController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _submitting = true);
    final cubit = context.read<AccountsCubit>();
    try {
      if (widget.isEditing) {
        final existing = _existing!;
        final updated = Account(
          id: existing.id,
          name: _nameController.text.trim(),
          type: _type,
          currentBalance: existing.currentBalance,
          initialBalance: existing.initialBalance,
          currency: existing.currency,
          institution: _institutionController.text.trim().isEmpty
              ? null
              : _institutionController.text.trim(),
          color: colorToHex(_color),
          icon: accountIconName(_icon),
          createdAt: existing.createdAt,
          isActive: existing.isActive,
        );
        await cubit.updateAccount(updated);
      } else {
        final initialBalance =
            parseMoneyInput(_balanceController.text, AppConstants.defaultCurrency);
        await cubit.createAccount(
          name: _nameController.text.trim(),
          type: _type,
          initialBalance: initialBalance,
          institution: _institutionController.text.trim().isEmpty
              ? null
              : _institutionController.text.trim(),
          color: colorToHex(_color),
          icon: accountIconName(_icon),
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
        title: Text(widget.isEditing ? 'Editar conta' : 'Nova conta'),
      ),
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
                DropdownButtonFormField<AccountType>(
                  initialValue: _type,
                  decoration: const InputDecoration(labelText: 'Tipo'),
                  items: AccountType.values
                      .map(
                        (type) => DropdownMenuItem(
                          value: type,
                          child: Text(accountTypeLabel(type)),
                        ),
                      )
                      .toList(),
                  onChanged: (value) => setState(() => _type = value!),
                ),
                const SizedBox(height: AppSpacing.md),
                TextFormField(
                  controller: _institutionController,
                  decoration: const InputDecoration(
                    labelText: 'Instituição (opcional)',
                  ),
                ),
                if (!widget.isEditing) ...[
                  const SizedBox(height: AppSpacing.md),
                  TextFormField(
                    controller: _balanceController,
                    keyboardType: const TextInputType.numberWithOptions(
                      decimal: true,
                    ),
                    decoration: const InputDecoration(
                      labelText: 'Saldo inicial',
                      prefixText: 'R\$ ',
                    ),
                    validator: validateAmount,
                  ),
                ],
                const SizedBox(height: AppSpacing.lg),
                Text('Cor', style: Theme.of(context).textTheme.labelLarge),
                const SizedBox(height: AppSpacing.xs),
                Wrap(
                  spacing: AppSpacing.sm,
                  children: accountColorOptions.map((color) {
                    final selected = color.toARGB32() == _color.toARGB32();
                    return GestureDetector(
                      onTap: () => setState(() => _color = color),
                      child: Container(
                        width: 36,
                        height: 36,
                        decoration: BoxDecoration(
                          color: color,
                          shape: BoxShape.circle,
                          border: selected
                              ? Border.all(
                                  color: Theme.of(context).colorScheme.onSurface,
                                  width: 2,
                                )
                              : null,
                        ),
                        child: selected
                            ? const Icon(Icons.check, color: Colors.white, size: 18)
                            : null,
                      ),
                    );
                  }).toList(),
                ),
                const SizedBox(height: AppSpacing.lg),
                DropdownButtonFormField<IconData>(
                  initialValue: _icon,
                  decoration: const InputDecoration(labelText: 'Ícone'),
                  items: accountIconOptions
                      .map(
                        (icon) => DropdownMenuItem(
                          value: icon,
                          child: Row(
                            children: [
                              Icon(icon, size: 20),
                              const SizedBox(width: AppSpacing.sm),
                              Text(accountIconName(icon)),
                            ],
                          ),
                        ),
                      )
                      .toList(),
                  onChanged: (value) => setState(() => _icon = value!),
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
                      : Text(widget.isEditing ? 'Salvar' : 'Criar conta'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
