import 'package:flutter/material.dart';

import '../domain/money.dart';
import '../theme/design_tokens.dart';

/// Prominent balance display used on the dashboard and account screens.
class BalanceCard extends StatelessWidget {
  const BalanceCard({
    super.key,
    required this.label,
    required this.amount,
    this.trendPercent,
    this.onTap,
  });

  final String label;
  final Money amount;

  /// Percentage variation vs the previous period (e.g. `0.14` = +14%).
  final double? trendPercent;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Material(
      color: scheme.primary,
      borderRadius: BorderRadius.circular(AppRadius.lg),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppRadius.lg),
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  color: scheme.onPrimary.withValues(alpha: 0.85),
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: AppSpacing.xs),
              Text(
                amount.format(),
                style: AppTypography.headline.copyWith(
                  color: scheme.onPrimary,
                ),
              ),
              if (trendPercent != null) ...[
                const SizedBox(height: AppSpacing.sm),
                _TrendChip(percent: trendPercent!, onColor: scheme.onPrimary),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class _TrendChip extends StatelessWidget {
  const _TrendChip({required this.percent, required this.onColor});

  final double percent;
  final Color onColor;

  @override
  Widget build(BuildContext context) {
    final isUp = percent >= 0;
    final sign = isUp ? '+' : '';
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.sm,
        vertical: AppSpacing.xxs,
      ),
      decoration: BoxDecoration(
        color: onColor.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(AppRadius.pill),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            isUp ? Icons.arrow_upward_rounded : Icons.arrow_downward_rounded,
            size: 14,
            color: onColor,
          ),
          Text(
            '$sign${(percent * 100).toStringAsFixed(1)}%',
            style: TextStyle(
              color: onColor,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
