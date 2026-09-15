import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/domain/money.dart';
import '../../../../core/errors/error_messages.dart';
import '../../../../core/theme/design_tokens.dart';
import '../../../../core/widgets/balance_card.dart';
import '../../../../core/widgets/empty_state.dart';
import '../../../../core/widgets/error_view.dart';
import '../../domain/entities/account.dart';
import '../account_type_meta.dart';
import '../cubit/accounts_cubit.dart';
import '../cubit/accounts_state.dart';

class AccountsScreen extends StatelessWidget {
  const AccountsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Contas')),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.push('/accounts/new'),
        child: const Icon(Icons.add_rounded),
      ),
      body: SafeArea(
        child: BlocBuilder<AccountsCubit, AccountsState>(
          builder: (context, state) => switch (state) {
            AccountsLoading() =>
              const Center(child: CircularProgressIndicator()),
            AccountsFailure(:final failure) =>
              ErrorView(message: userMessageFor(failure)),
            AccountsLoaded(:final accounts) => _AccountsBody(accounts: accounts),
          },
        ),
      ),
    );
  }
}

class _AccountsBody extends StatelessWidget {
  const _AccountsBody({required this.accounts});

  final List<Account> accounts;

  @override
  Widget build(BuildContext context) {
    if (accounts.isEmpty) {
      return const EmptyState(
        icon: Icons.account_balance_wallet_rounded,
        title: 'Nenhuma conta ainda',
        message: 'Crie sua primeira conta para começar a registrar finanças.',
      );
    }

    return ListView(
      padding: const EdgeInsets.all(AppSpacing.md),
      children: [
        BalanceCard(label: 'Saldo total', amount: _totalBalance(accounts)),
        const SizedBox(height: AppSpacing.lg),
        if (accounts.length > 1) ...[
          Align(
            alignment: Alignment.centerLeft,
            child: TextButton.icon(
              onPressed: () => context.push('/accounts/transfer'),
              icon: const Icon(Icons.swap_horiz_rounded),
              label: const Text('Transferir entre contas'),
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
        ],
        ...accounts.map(
          (account) => Card(
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor:
                    colorFromHex(account.color).withValues(alpha: 0.15),
                child: Icon(
                  accountIconByName(account.icon),
                  color: colorFromHex(account.color),
                  size: 20,
                ),
              ),
              title: Text(account.name),
              subtitle: Text(accountTypeLabel(account.type)),
              trailing: Text(
                account.currentBalance.format(),
                style: AppTypography.bodyStrong,
              ),
              onTap: () => context.push('/accounts/${account.id}'),
            ),
          ),
        ),
      ],
    );
  }

  Money _totalBalance(List<Account> list) {
    if (list.isEmpty) return Money(0, 'BRL');
    final currency = list.first.currency;
    var total = 0;
    for (final account in list) {
      if (account.currency == currency) {
        total += account.currentBalance.minorUnits;
      }
    }
    return Money(total, currency);
  }
}
