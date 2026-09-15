import '../entities/financial_overview.dart';
import '../repositories/dashboard_repository.dart';

/// Observes the financial overview for a period.
class WatchOverview {
  const WatchOverview(this._repository);

  final DashboardRepository _repository;

  Stream<FinancialOverview> call({required DateTime start, required DateTime end}) =>
      _repository.watchOverview(start: start, end: end);
}
