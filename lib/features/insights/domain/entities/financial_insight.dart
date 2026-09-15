import 'package:freezed_annotation/freezed_annotation.dart';

part 'financial_insight.freezed.dart';

/// Insight severity.
enum InsightSeverity { info, warning, critical }

/// A generated financial insight.
@freezed
abstract class FinancialInsight with _$FinancialInsight {
  const factory FinancialInsight({
    required String id,
    required String type,
    required String title,
    required String message,
    required InsightSeverity severity,
    required String period,
    required DateTime createdAt,
    required bool isRead,
  }) = _FinancialInsight;
}
