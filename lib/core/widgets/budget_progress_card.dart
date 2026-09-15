import 'package:flutter/material.dart';

import '../domain/money.dart';
import '../theme/design_tokens.dart';
import 'progress_bar.dart';

/// Budget card showing spent/limit, remaining, and threshold warnings at
/// 70% / 90% / 100% consumption.
class BudgetProgressCard extends StatelessWidget {
  const BudgetProgressCard({
    super.key,
    required this.name,
    required this.spent,
    required this.limit,
  });

  final String name;
  final Money spent;
  final Money limit;

  double get _percent => limit.isZero ? 0 : (spent.minorUnits / limit.minorUnits);

  Money get _remaining => limit - spent;

  bool get _isOver => _percent >= 1;

  Color _statusColor() {
    if (_percent >= 1) return AppColors.expense;
    if (_percent >= 0.9) return AppColors.expense;
    if (_percent >= 0.7) return AppColors.warning;
    return AppColors.income;
  }

  String _statusLabel() {
    if (_isOver) return 'Estourou o orçamento';
    if (_percent >= 0.9) return 'Quase no limite';
    if (_percent >= 0.7) return 'Atenção';
    return 'Dentro do orçamento';
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final color = _statusColor();
    final remainingLabel = _isOver
        ? 'Excedido em ${(-_remaining).format()}'
        : 'Restam ${_remaining.format()}';

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    name,
                    style: theme.textTheme.titleSmall,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Text(
                  '${(_percent * 100).toStringAsFixed(0)}%',
                  style: AppTypography.bodyStrong.copyWith(color: color),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.xs),
            ProgressBar(value: _percent, color: color),
            const SizedBox(height: AppSpacing.sm),
            Text(
              '${spent.format()} de ${limit.format()}',
              style: theme.textTheme.bodyMedium,
            ),
            const SizedBox(height: AppSpacing.xxs),
            Row(
              children: [
                Text(
                  _statusLabel(),
                  style: theme.textTheme.bodySmall?.copyWith(color: color),
                ),
                const Spacer(),
                Text(remainingLabel, style: theme.textTheme.bodySmall),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
