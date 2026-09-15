import 'package:flutter/material.dart';

import '../theme/design_tokens.dart';

/// Visual credit-card renderer (brand, masked number, limit usage).
///
/// This is a pure presentational widget; the feature layer maps its domain
/// `CreditCard` entity onto these props.
class CreditCardWidget extends StatelessWidget {
  const CreditCardWidget({
    super.key,
    required this.name,
    required this.brand,
    this.lastFourDigits,
    this.limitUsage = 0,
    this.availableLabel,
  });

  final String name;
  final String brand;

  /// Last four digits shown in a masked form (`•••• 1234`).
  final String? lastFourDigits;

  /// Fraction of the credit limit currently used (`0..1`).
  final double limitUsage;

  final String? availableLabel;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppRadius.lg),
        gradient: LinearGradient(
          colors: [
            scheme.primary,
            scheme.primary.withValues(alpha: 0.75),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: AppShadows.card,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                brand,
                style: AppTypography.bodyStrong.copyWith(
                  color: scheme.onPrimary,
                  letterSpacing: 1.2,
                ),
              ),
              Icon(Icons.contactless_rounded, color: scheme.onPrimary),
            ],
          ),
          const SizedBox(height: AppSpacing.xl),
          Text(
            lastFourDigits == null ? '•••• •••• •••• ••••' : '•••• •••• •••• $lastFourDigits',
            style: AppTypography.title.copyWith(color: scheme.onPrimary),
          ),
          const SizedBox(height: AppSpacing.md),
          Text(
            name.toUpperCase(),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: AppTypography.caption.copyWith(color: scheme.onPrimary),
          ),
          if (availableLabel != null) ...[
            const SizedBox(height: AppSpacing.md),
            Text(
              availableLabel!,
              style: AppTypography.caption.copyWith(
                color: scheme.onPrimary.withValues(alpha: 0.85),
              ),
            ),
            const SizedBox(height: AppSpacing.xs),
            _LimitIndicator(value: limitUsage, onColor: scheme.onPrimary),
          ],
        ],
      ),
    );
  }
}

class _LimitIndicator extends StatelessWidget {
  const _LimitIndicator({required this.value, required this.onColor});

  final double value;
  final Color onColor;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(AppRadius.pill),
      child: LinearProgressIndicator(
        value: value.clamp(0.0, 1.0),
        minHeight: 6,
        color: onColor,
        backgroundColor: onColor.withValues(alpha: 0.25),
      ),
    );
  }
}
