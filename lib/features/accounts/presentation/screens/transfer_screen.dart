import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/errors/error_messages.dart';
import '../../../../core/errors/failure.dart';
import '../../../../core/theme/design_tokens.dart';
import '../../../../core/utils/formatters.dart';
import '../../../../core/utils/validators.dart';
import '../cubit/accounts_cubit.dart';
import '../cubit/accounts_state.dart';

class TransferScreen extends StatefulWidget {
  const TransferScreen({super.key});

  @override
  State<TransferScreen> createState() => _TransferScreenState();
}

class _TransferScreenState extends State<TransferScreen> {
  final _formKey = GlobalKey<FormState>();
  final _amountController = TextEditingController();
  String? _fromId;
  String? _toId;
  bool _submitting = false;

  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    if (_fromId == null || _toId == null) return;
    setState(() => _submitting = true);
    final cubit = context.read<AccountsCubit>();
    try {
      final amount = parseMoneyInput(
        _amountController.text,
        AppConstants.defaultCurrency,
      );
      await cubit.transfer(
        fromAccountId: _fromId!,
        toAccountId: _toId!,
        amount: amount,
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
      appBar: AppBar(title: const Text('Transferir')),
      body: SafeArea(
        child: BlocBuilder<AccountsCubit, AccountsState>(
          builder: (context, state) {
            if (state is! AccountsLoaded) {
              return const Center(child: CircularProgressIndicator());
            }
            final accounts = state.accounts;
            return SingleChildScrollView(
              padding: const EdgeInsets.all(AppSpacing.md),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    DropdownButtonFormField<String>(
                      initialValue: _fromId,
                      decoration: const InputDecoration(labelText: 'De'),
                      items: accounts
                          .map(
                            (a) => DropdownMenuItem(
                              value: a.id,
                              child: Text(a.name),
                            ),
                          )
                          .toList(),
                      onChanged: (value) => setState(() => _fromId = value),
                      validator: (v) => validateRequired(v, 'Conta de origem'),
                    ),
                    const SizedBox(height: AppSpacing.md),
                    DropdownButtonFormField<String>(
                      initialValue: _toId,
                      decoration: const InputDecoration(labelText: 'Para'),
                      items: accounts
                          .where((a) => a.id != _fromId)
                          .map(
                            (a) => DropdownMenuItem(
                              value: a.id,
                              child: Text(a.name),
                            ),
                          )
                          .toList(),
                      onChanged: (value) => setState(() => _toId = value),
                      validator: (v) => validateRequired(v, 'Conta de destino'),
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
                    const SizedBox(height: AppSpacing.xl),
                    FilledButton(
                      onPressed: _submitting ? null : _submit,
                      child: _submitting
                          ? const SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(strokeWidth: 2),
                            )
                          : const Text('Transferir'),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
