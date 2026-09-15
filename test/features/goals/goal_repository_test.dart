import 'package:drift/native.dart';
import 'package:fince/core/domain/money.dart';
import 'package:fince/core/storage/app_database.dart';
import 'package:fince/features/goals/data/datasources/goal_local_data_source.dart';
import 'package:fince/features/goals/data/repositories/goal_repository_impl.dart';
import 'package:fince/features/goals/domain/usecases/create_goal.dart';
import 'package:fince/features/goals/domain/usecases/deposit_to_goal.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late AppDatabase db;
  late CreateGoal createGoal;
  late DepositToGoal deposit;

  setUp(() {
    db = AppDatabase(NativeDatabase.memory());
    final repository = GoalRepositoryImpl(local: GoalLocalDataSource(db));
    createGoal = CreateGoal(repository);
    deposit = DepositToGoal(repository);
  });

  tearDown(() async {
    await db.close();
  });

  test('deposit advances progress and completes the goal', () async {
    final goal = await createGoal(
      name: 'Fundo de emergência',
      targetAmount: Money(100000, 'BRL'),
    );

    await deposit(id: goal.id, amount: Money(60000, 'BRL'));

    var row = await (db.select(db.financialGoals)
          ..where((g) => g.id.equals(goal.id)))
        .getSingle();
    expect(row.currentAmountMinor, 60000);
    expect(row.status, 'active');

    await deposit(id: goal.id, amount: Money(40000, 'BRL'));

    row = await (db.select(db.financialGoals)
          ..where((g) => g.id.equals(goal.id)))
        .getSingle();
    expect(row.currentAmountMinor, 100000);
    expect(row.status, 'completed');
  });
}
