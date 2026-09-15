import 'package:flutter/material.dart';

import '../domain/money.dart';
import '../theme/design_tokens.dart';
import 'progress_bar.dart';

/// Category spending row: icon, name, amount, and progress toward a total.
class CategoryProgress extends StatelessWidget {
  const CategoryProgress({
    super.key,
    required this.name,
    required this.value,
    required this.total,
    required this.icon,
    required this.color,
  });

  final String name;
  final Money value;
  final Money total;
  final IconData icon;
  final Color color;

  double get _progress =>
      total.isZero ? 0 : (value.minorUnits / total.minorUnits);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      children: [
        Row(
          children: [
            CircleAvatar(
              radius: 16,
              backgroundColor: color.withValues(alpha: 0.14),
              child: Icon(icon, size: 16, color: color),
            ),
            const SizedBox(width: AppSpacing.sm),
            Expanded(
              child: Text(
                name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: theme.textTheme.bodyMedium,
              ),
            ),
            Text(
              value.format(),
              style: theme.textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.xs),
        ProgressBar(value: _progress, color: color),
      ],
    );
  }
}
