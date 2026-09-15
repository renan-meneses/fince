import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/errors/error_messages.dart';
import '../../../../core/theme/design_tokens.dart';
import '../../../../core/widgets/credit_card_widget.dart';
import '../../../../core/widgets/empty_state.dart';
import '../../../../core/widgets/error_view.dart';
import '../../domain/entities/credit_card.dart';
import '../cubit/credit_cards_cubit.dart';
import '../cubit/credit_cards_state.dart';

class CreditCardsScreen extends StatelessWidget {
  const CreditCardsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Cartões de crédito')),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.push('/credit-cards/new'),
        child: const Icon(Icons.add_rounded),
      ),
      body: SafeArea(
        child: BlocBuilder<CreditCardsCubit, CreditCardsState>(
          builder: (context, state) => switch (state) {
            CreditCardsLoading() =>
              const Center(child: CircularProgressIndicator()),
            CreditCardsFailure(:final failure) =>
              ErrorView(message: userMessageFor(failure)),
            CreditCardsLoaded(:final cards) => _CardsList(cards: cards),
          },
        ),
      ),
    );
  }
}

class _CardsList extends StatelessWidget {
  const _CardsList({required this.cards});

  final List<CreditCard> cards;

  @override
  Widget build(BuildContext context) {
    if (cards.isEmpty) {
      return const EmptyState(
        icon: Icons.credit_card_rounded,
        title: 'Nenhum cartão',
        message: 'Cadastre um cartão de crédito para registrar compras.',
      );
    }

    return ListView(
      padding: const EdgeInsets.all(AppSpacing.md),
      children: [
        for (final card in cards) ...[
          CreditCardWidget(
            name: card.name,
            brand: _brandLabel(card.brand),
            limitUsage: card.creditLimit.isZero
                ? 0
                : 1 - (card.availableLimit.minorUnits / card.creditLimit.minorUnits),
            availableLabel: 'Disponível: ${card.availableLimit.format()}',
          ),
          const SizedBox(height: AppSpacing.xs),
          Align(
            alignment: Alignment.centerRight,
            child: TextButton.icon(
              onPressed: () => context.push('/credit-cards/${card.id}/purchase'),
              icon: const Icon(Icons.add_shopping_cart_rounded),
              label: const Text('Nova compra'),
            ),
          ),
          const SizedBox(height: AppSpacing.md),
        ],
      ],
    );
  }

  String _brandLabel(CardBrand brand) => switch (brand) {
        CardBrand.visa => 'Visa',
        CardBrand.mastercard => 'Mastercard',
        CardBrand.amex => 'Amex',
        CardBrand.elo => 'Elo',
        CardBrand.hipercard => 'Hipercard',
        CardBrand.other => 'Cartão',
      };
}
