import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/errors/error_messages.dart';
import '../../../../core/theme/design_tokens.dart';
import '../../../../core/utils/color_utils.dart';
import '../../../../core/widgets/error_view.dart';
import '../../../../core/widgets/financial_summary_card.dart';
import '../../../../core/widgets/section_header.dart';
import '../../domain/entities/report_entities.dart';
import '../cubit/reports_cubit.dart';
import '../cubit/reports_state.dart';

class ReportsScreen extends StatelessWidget {
  const ReportsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Relatórios')),
      body: SafeArea(
        child: BlocBuilder<ReportsCubit, ReportsState>(
          builder: (context, state) => switch (state) {
            ReportsLoading() =>
              const Center(child: CircularProgressIndicator()),
            ReportsFailure(:final failure) =>
              ErrorView(message: userMessageFor(failure)),
            ReportsLoaded(:final data) => _ReportsBody(data: data),
          },
        ),
      ),
    );
  }
}

class _ReportsBody extends StatelessWidget {
  const _ReportsBody({required this.data});

  final ReportsData data;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(AppSpacing.md),
      children: [
        Row(
          children: [
            Expanded(
              child: FinancialSummaryCard(
                title: 'Receitas',
                value: data.summary.income,
                icon: Icons.south_west_rounded,
                color: AppColors.income,
              ),
            ),
            const SizedBox(width: AppSpacing.sm),
            Expanded(
              child: FinancialSummaryCard(
                title: 'Despesas',
                value: data.summary.expenses,
                icon: Icons.north_east_rounded,
                color: AppColors.expense,
              ),
            ),
            const SizedBox(width: AppSpacing.sm),
            Expanded(
              child: FinancialSummaryCard(
                title: 'Resultado',
                value: data.summary.result,
                icon: data.summary.result.isNegative
                    ? Icons.trending_down_rounded
                    : Icons.trending_up_rounded,
                color: data.summary.result.isNegative
                    ? AppColors.expense
                    : AppColors.income,
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.lg),
        const SectionHeader(title: 'Fluxo de caixa (6 meses)'),
        const SizedBox(height: AppSpacing.sm),
        _CashFlowChart(points: data.cashFlow),
        const SizedBox(height: AppSpacing.lg),
        const SectionHeader(title: 'Despesas por categoria'),
        if (data.byCategory.isEmpty)
          const Text('Sem despesas no período.')
        else
          _CategoryReport(categories: data.byCategory),
        const SizedBox(height: AppSpacing.lg),
        const SectionHeader(title: 'Despesas por conta'),
        if (data.byAccount.isEmpty)
          const Text('Sem despesas no período.')
        else
          ...data.byAccount.map(
            (a) => ListTile(
              contentPadding: EdgeInsets.zero,
              title: Text(a.name),
              trailing: Text(a.total.format()),
            ),
          ),
      ],
    );
  }
}

class _CashFlowChart extends StatelessWidget {
  const _CashFlowChart({required this.points});

  final List<CashFlowPoint> points;

  @override
  Widget build(BuildContext context) {
    if (points.isEmpty) return const SizedBox.shrink();
    return SizedBox(
      height: 180,
      child: BarChart(
        BarChartData(
          barGroups: [
            for (var i = 0; i < points.length; i++)
              BarChartGroupData(
                x: i,
                barRods: [
                  BarChartRodData(
                    toY: points[i].income.minorUnits.toDouble(),
                    color: AppColors.income,
                    width: 7,
                    borderRadius: BorderRadius.circular(2),
                  ),
                  BarChartRodData(
                    toY: points[i].expenses.minorUnits.toDouble(),
                    color: AppColors.expense,
                    width: 7,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ],
              ),
          ],
          titlesData: FlTitlesData(
            leftTitles: const AxisTitles(),
            rightTitles: const AxisTitles(),
            topTitles: const AxisTitles(),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (value, meta) {
                  final index = value.toInt();
                  if (index < 0 || index >= points.length) {
                    return const SizedBox.shrink();
                  }
                  return Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: Text(
                      _monthLabel(points[index].period),
                      style: const TextStyle(fontSize: 10),
                    ),
                  );
                },
              ),
            ),
          ),
          gridData: const FlGridData(show: false),
          borderData: FlBorderData(show: false),
        ),
      ),
    );
  }

  String _monthLabel(String period) {
    final parts = period.split('-');
    if (parts.length != 2) return period;
    const months = [
      'Jan', 'Fev', 'Mar', 'Abr', 'Mai', 'Jun',
      'Jul', 'Ago', 'Set', 'Out', 'Nov', 'Dez',
    ];
    final m = int.tryParse(parts[1]) ?? 1;
    return months[m - 1];
  }
}

class _CategoryReport extends StatelessWidget {
  const _CategoryReport({required this.categories});

  final List<CategoryReport> categories;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 160,
          child: PieChart(
            PieChartData(
              sectionsSpace: 2,
              centerSpaceRadius: 40,
              sections: categories
                  .map(
                    (c) => PieChartSectionData(
                      value: c.total.minorUnits.toDouble(),
                      color: colorFromHex(c.color),
                      radius: 40,
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
                Text(c.total.format()),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
