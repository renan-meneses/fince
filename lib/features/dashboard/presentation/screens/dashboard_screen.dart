import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/errors/error_messages.dart';
import '../../../../core/theme/design_tokens.dart';
import '../../../../core/utils/color_utils.dart';
import '../../../../core/utils/date_utils.dart';
import '../../../../core/utils/formatters.dart';
import '../../../../core/widgets/balance_card.dart';
import '../../../../core/widgets/error_view.dart';
import '../../../../core/widgets/financial_summary_card.dart';
import '../../../../core/widgets/section_header.dart';
import '../../../../core/widgets/transaction_tile.dart';
import '../../../transactions/domain/entities/transaction.dart';
import '../../domain/entities/financial_overview.dart';
import '../cubit/dashboard_cubit.dart';
import '../cubit/dashboard_state.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Fince'),
        actions: [
          PopupMenuButton<DashboardPeriod>(
            icon: const Icon(Icons.calendar_month_rounded),
            onSelected: (p) => _onPeriodSelected(context, p),
            itemBuilder: (context) => const [
              PopupMenuItem(
                value: DashboardPeriod.currentMonth,
                child: Text('Mês atual'),
              ),
              PopupMenuItem(
                value: DashboardPeriod.previousMonth,
                child: Text('Mês anterior'),
              ),
              PopupMenuItem(
                value: DashboardPeriod.custom,
                child: Text('Período personalizado…'),
              ),
            ],
          ),
        ],
      ),
      body: SafeArea(
        child: BlocBuilder<DashboardCubit, DashboardState>(
          builder: (context, state) => switch (state) {
            DashboardLoading() =>
              const Center(child: CircularProgressIndicator()),
            DashboardFailure(:final failure) =>
              ErrorView(message: userMessageFor(failure)),
            DashboardLoaded(:final overview) => _DashboardBody(overview: overview),
          },
        ),
      ),
    );
  }

  Future<void> _onPeriodSelected(
    BuildContext context,
    DashboardPeriod period,
  ) async {
    final cubit = context.read<DashboardCubit>();
    final now = DateTime.now();
    switch (period) {
      case DashboardPeriod.currentMonth:
        cubit.setPeriod(now.startOfMonth, now.startOfNextMonth);
      case DashboardPeriod.previousMonth:
        cubit.setPeriod(now.startOfPreviousMonth, now.startOfMonth);
      case DashboardPeriod.custom:
        final range = await showDateRangePicker(
          context: context,
          firstDate: DateTime(2000),
          lastDate: DateTime(2100),
        );
        if (range != null) {
          cubit.setPeriod(
            range.start.startOfDay,
            range.end.startOfDay.add(const Duration(days: 1)),
          );
        }
    }
  }
}

class _DashboardBody extends StatelessWidget {
  const _DashboardBody({required this.overview});

  final FinancialOverview overview;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(AppSpacing.md),
      children: [
        BalanceCard(
          label: 'Saldo total',
          amount: overview.totalBalance,
          trendPercent: overview.variationPercent,
        ),
        const SizedBox(height: AppSpacing.md),
        Row(
          children: [
            Expanded(
              child: FinancialSummaryCard(
                title: 'Receitas',
                value: overview.income,
                icon: Icons.south_west_rounded,
                color: AppColors.income,
              ),
            ),
            const SizedBox(width: AppSpacing.sm),
            Expanded(
              child: FinancialSummaryCard(
                title: 'Despesas',
                value: overview.expenses,
                icon: Icons.north_east_rounded,
                color: AppColors.expense,
              ),
            ),
            const SizedBox(width: AppSpacing.sm),
            Expanded(
              child: FinancialSummaryCard(
                title: 'Resultado',
                value: overview.result,
                icon: overview.result.isNegative
                    ? Icons.trending_down_rounded
                    : Icons.trending_up_rounded,
                color: overview.result.isNegative
                    ? AppColors.expense
                    : AppColors.income,
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.lg),
        const SectionHeader(title: 'Transações recentes'),
        if (overview.recentTransactions.isEmpty)
          const Padding(
            padding: EdgeInsets.symmetric(vertical: AppSpacing.md),
            child: Text('Nenhuma transação no período.'),
          )
        else
          ...overview.recentTransactions.map(
            (t) => TransactionTile(
              title: t.description,
              subtitle: formatDate(t.date),
              amount: t.amount,
              kind: _kindFor(t.type),
              onTap: () => context.push('/transactions/${t.id}'),
            ),
          ),
        const SizedBox(height: AppSpacing.lg),
        const SectionHeader(title: 'Despesas por categoria'),
        if (overview.expensesByCategory.isEmpty)
          const Padding(
            padding: EdgeInsets.symmetric(vertical: AppSpacing.md),
            child: Text('Sem despesas no período.'),
          )
        else
          _CategoryBreakdown(categories: overview.expensesByCategory),
      ],
    );
  }

  TransactionKind _kindFor(TransactionType type) => switch (type) {
        TransactionType.income => TransactionKind.income,
        TransactionType.expense => TransactionKind.expense,
        TransactionType.transfer => TransactionKind.transfer,
      };
}

class _CategoryBreakdown extends StatelessWidget {
  const _CategoryBreakdown({required this.categories});

  final List<CategoryTotal> categories;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 180,
          child: PieChart(
            PieChartData(
              sectionsSpace: 2,
              centerSpaceRadius: 44,
              sections: categories
                  .map(
                    (c) => PieChartSectionData(
                      value: c.total.minorUnits.toDouble(),
                      color: colorFromHex(c.color),
                      radius: 44,
                      showTitle: false,
                    ),
                  )
                  .toList(),
            ),
          ),
        ),
        const SizedBox(height: AppSpacing.md),
        ...categories.map(
          (c) => Padding(
            padding: const EdgeInsets.symmetric(vertical: AppSpacing.xs),
            child: Row(
              children: [
                Container(
                  width: 12,
                  height: 12,
                  decoration: BoxDecoration(
                    color: colorFromHex(c.color),
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: AppSpacing.sm),
                Expanded(child: Text(c.name)),
                Text('${(c.percent * 100).toStringAsFixed(0)}%'),
                const SizedBox(width: AppSpacing.sm),
                Text(
                  c.total.format(),
                  style: AppTypography.bodyStrong,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
