import 'package:drift/drift.dart';

import '../../../../core/domain/money.dart';
import '../../../../core/errors/failure.dart';
import '../../../../core/storage/app_database.dart';
import '../../domain/entities/financial_goal.dart';

/// Drift-backed local storage for financial goals.
class GoalLocalDataSource {
  GoalLocalDataSource(this._db);

  final AppDatabase _db;

  Stream<List<FinancialGoal>> watchAll() {
    final query = _db.select(_db.financialGoals)
      ..orderBy([(t) => OrderingTerm.asc(t.createdAt)]);
    return query.watch().map((rows) => rows.map(_toEntity).toList());
  }

  Future<FinancialGoal> insert(FinancialGoal goal) async {
    await _db.into(_db.financialGoals).insert(_toCompanion(goal));
    return goal;
  }

  Future<FinancialGoal> update(FinancialGoal goal) async {
    await (_db.update(_db.financialGoals)..where((t) => t.id.equals(goal.id)))
        .write(_toCompanion(goal));
    return goal;
  }

  Future<void> delete(String id) async {
    await (_db.delete(_db.financialGoals)..where((t) => t.id.equals(id))).go();
  }

  Future<FinancialGoal> deposit({required String id, required Money amount}) async {
    final row = await (_db.select(_db.financialGoals)
          ..where((t) => t.id.equals(id)))
        .getSingleOrNull();
    if (row == null) {
      throw const DatabaseFailure(message: 'Meta não encontrada.');
    }
    if (row.currency != amount.currency) {
      throw const ValidationFailure(message: 'Moeda incompatível.');
    }
    final newCurrent = row.currentAmountMinor + amount.minorUnits;
    final completed = newCurrent >= row.targetAmountMinor;
    await (_db.update(_db.financialGoals)..where((t) => t.id.equals(id))).write(
      FinancialGoalsCompanion(
        currentAmountMinor: Value(newCurrent),
        status: Value(completed ? 'completed' : 'active'),
      ),
    );
    final updated = await (_db.select(_db.financialGoals)
          ..where((t) => t.id.equals(id)))
        .getSingle();
    return _toEntity(updated);
  }

  FinancialGoal _toEntity(FinancialGoalRow row) => FinancialGoal(
        id: row.id,
        name: row.name,
        targetAmount: Money(row.targetAmountMinor, row.currency),
        currentAmount: Money(row.currentAmountMinor, row.currency),
        currency: row.currency,
        targetDate: row.targetDate,
        description: row.description,
        status: GoalStatus.values.byName(row.status),
        createdAt: row.createdAt,
      );

  FinancialGoalsCompanion _toCompanion(FinancialGoal g) =>
      FinancialGoalsCompanion.insert(
        id: g.id,
        name: g.name,
        targetAmountMinor: g.targetAmount.minorUnits,
        currentAmountMinor: g.currentAmount.minorUnits,
        currency: g.currency,
        targetDate: Value(g.targetDate),
        description: Value(g.description),
        status: Value(g.status.name),
        createdAt: g.createdAt,
      );
}
