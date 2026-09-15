import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/errors/error_messages.dart';
import '../../../../core/theme/design_tokens.dart';
import '../../../../core/widgets/empty_state.dart';
import '../../../../core/widgets/error_view.dart';
import '../../domain/entities/financial_insight.dart';
import '../cubit/insights_cubit.dart';
import '../cubit/insights_state.dart';

class InsightsScreen extends StatelessWidget {
  const InsightsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Insights')),
      body: SafeArea(
        child: BlocBuilder<InsightsCubit, InsightsState>(
          builder: (context, state) => switch (state) {
            InsightsLoading() =>
              const Center(child: CircularProgressIndicator()),
            InsightsFailure(:final failure) =>
              ErrorView(message: userMessageFor(failure)),
            InsightsLoaded(:final insights) => _InsightList(insights: insights),
          },
        ),
      ),
    );
  }
}

class _InsightList extends StatelessWidget {
  const _InsightList({required this.insights});

  final List<FinancialInsight> insights;

  @override
  Widget build(BuildContext context) {
    if (insights.isEmpty) {
      return const EmptyState(
        icon: Icons.lightbulb_rounded,
        title: 'Nenhum insight',
        message: 'Nada de relevante para destacar neste mês.',
      );
    }

    return ListView(
      padding: const EdgeInsets.all(AppSpacing.md),
      children: [
        for (final insight in insights) ...[
          _InsightCard(insight: insight),
          const SizedBox(height: AppSpacing.sm),
        ],
      ],
    );
  }
}

class _InsightCard extends StatelessWidget {
  const _InsightCard({required this.insight});

  final FinancialInsight insight;

  @override
  Widget build(BuildContext context) {
    final (color, icon) = switch (insight.severity) {
      InsightSeverity.info => (AppColors.info, Icons.info_rounded),
      InsightSeverity.warning => (AppColors.warning, Icons.warning_rounded),
      InsightSeverity.critical => (AppColors.expense, Icons.error_rounded),
    };

    return Card(
      child: ListTile(
        leading: Icon(icon, color: color),
        title: Text(insight.title),
        subtitle: Text(insight.message),
      ),
    );
  }
}
