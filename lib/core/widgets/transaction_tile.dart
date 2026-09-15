import 'package:flutter/material.dart';

import '../domain/money.dart';
import '../theme/design_tokens.dart';

/// Presentation-level kind, mapped from the domain `TransactionType` at the
/// feature boundary. Keeps this widget free of domain entities.
enum TransactionKind { income, expense, transfer }

/// A single transaction row: icon, description, and a signed amount.
class TransactionTile extends StatelessWidget {
  const TransactionTile({
    super.key,
    required this.title,
    required this.subtitle,
    required this.amount,
    this.kind = TransactionKind.expense,
    this.icon,
    this.iconColor,
    this.onTap,
  });

  final String title;
  final String subtitle;

  /// Always a positive magnitude; the sign is implied by [kind].
  final Money amount;
  final TransactionKind kind;
  final IconData? icon;
  final Color? iconColor;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final resolvedColor = iconColor ?? _colorFor(kind, scheme);
    final resolvedIcon = icon ?? _iconFor(kind);

    return ListTile(
      onTap: onTap,
      contentPadding: EdgeInsets.zero,
      leading: CircleAvatar(
        backgroundColor: resolvedColor.withValues(alpha: 0.14),
        child: Icon(resolvedIcon, color: resolvedColor, size: 20),
      ),
      title: Text(
        title,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: Theme.of(context).textTheme.bodyLarge,
      ),
      subtitle: Text(
        subtitle,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: Theme.of(context).textTheme.bodySmall,
      ),
      trailing: Text(
        _signedLabel(amount),
        style: AppTypography.bodyStrong.copyWith(color: resolvedColor),
      ),
    );
  }

  Color _colorFor(TransactionKind kind, ColorScheme scheme) => switch (kind) {
        TransactionKind.income => AppColors.income,
        TransactionKind.expense => AppColors.expense,
        TransactionKind.transfer => scheme.onSurfaceVariant,
      };

  IconData _iconFor(TransactionKind kind) => switch (kind) {
        TransactionKind.income => AppIcons.income,
        TransactionKind.expense => AppIcons.expense,
        TransactionKind.transfer => AppIcons.transfer,
      };

  String _signedLabel(Money value) => switch (kind) {
        TransactionKind.income => '+${value.format()}',
        TransactionKind.expense => '-${value.format()}',
        TransactionKind.transfer => value.format(),
      };
}
