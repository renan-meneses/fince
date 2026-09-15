import 'package:flutter/material.dart';

import '../domain/money.dart';
import '../theme/design_tokens.dart';
import '../utils/formatters.dart';
import 'progress_bar.dart';

/// Goal card showing current/target, progress, and remaining amount.
class GoalProgressCard extends StatelessWidget {
  const GoalProgressCard({
    super.key,
    required this.name,
    required this.current,
    required this.target,
    this.targetDate,
    this.onTap,
  });

  final String name;
  final Money current;
  final Money target;
  final DateTime? targetDate;
  final VoidCallback? onTap;

  double get _progress => target.isZero ? 0 : (current.minorUnits / target.minorUnits);

  Money get _remaining => target - current;

  bool get _achieved => current >= target;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final color = _achieved ? AppColors.income : theme.colorScheme.primary;

    return Card(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppRadius.lg),
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.md),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.flag_rounded, size: 18, color: color),
                  const SizedBox(width: AppSpacing.xs),
                  Expanded(
                    child: Text(
                      name,
                      style: theme.textTheme.titleSmall,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Text(
                    '${(_progress * 100).toStringAsFixed(0)}%',
                    style: AppTypography.bodyStrong.copyWith(color: color),
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.sm),
              ProgressBar(value: _progress, color: color),
              const SizedBox(height: AppSpacing.sm),
              Text(
                '${current.format()} de ${target.format()}',
                style: theme.textTheme.bodyMedium,
              ),
              const SizedBox(height: AppSpacing.xxs),
              Text(
                _achieved
                    ? 'Meta alcançada!'
                    : 'Faltam ${_remaining.format()}'
                        '${targetDate != null ? ' até ${formatDate(targetDate!)}' : ''}',
                style: theme.textTheme.bodySmall,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
