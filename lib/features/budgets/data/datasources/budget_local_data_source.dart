import 'package:drift/drift.dart';

import '../../../../core/domain/money.dart';
import '../../../../core/storage/app_database.dart';
import '../../domain/entities/budget.dart';

/// Drift-backed local storage for budgets.
class BudgetLocalDataSource {
  BudgetLocalDataSource(this._db);

  final AppDatabase _db;

  Stream<List<Budget>> watchAll(String month) {
    final query = _db.select(_db.budgets)
      ..where((t) => t.month.equals(month))
      ..orderBy([(t) => OrderingTerm.asc(t.createdAt)]);
    return query.watch().map((rows) => rows.map(_toEntity).toList());
  }

  Future<Budget> insert(Budget budget) async {
    await _db.into(_db.budgets).insert(_toCompanion(budget));
    return budget;
  }

  Future<Budget> update(Budget budget) async {
    await (_db.update(_db.budgets)..where((t) => t.id.equals(budget.id)))
        .write(_toCompanion(budget));
    return budget;
  }

  Future<void> delete(String id) async {
    await (_db.delete(_db.budgets)..where((t) => t.id.equals(id))).go();
  }

  Budget _toEntity(BudgetRow row) => Budget(
        id: row.id,
        categoryId: row.categoryId,
        amount: Money(row.amountMinor, row.currency),
        currency: row.currency,
        month: row.month,
        createdAt: row.createdAt,
      );

  BudgetsCompanion _toCompanion(Budget b) => BudgetsCompanion.insert(
        id: b.id,
        categoryId: b.categoryId,
        amountMinor: b.amount.minorUnits,
        currency: b.currency,
        month: b.month,
        createdAt: b.createdAt,
      );
}
