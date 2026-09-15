import '../entities/financial_overview.dart';

/// Dashboard contract (domain port). Aggregates cross-feature data.
abstract interface class DashboardRepository {
  Stream<FinancialOverview> watchOverview({
    required DateTime start,
    required DateTime end,
  });
}
