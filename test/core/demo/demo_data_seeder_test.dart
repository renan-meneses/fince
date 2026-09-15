import 'package:drift/native.dart';
import 'package:fince/core/demo/demo_data_seeder.dart';
import 'package:fince/core/storage/app_database.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('seeds a complete, idempotent demo dataset', () async {
    final db = AppDatabase(NativeDatabase.memory());

    await DemoDataSeeder().seed(db);
    await DemoDataSeeder().seed(db); // idempotent: no duplicates

    expect(await db.select(db.accounts).get(), hasLength(3));
    expect(await db.select(db.categories).get(), hasLength(15));
    expect(await db.select(db.transactions).get(), hasLength(13));
    expect(await db.select(db.creditCards).get(), hasLength(1));
    expect(await db.select(db.installments).get(), hasLength(6));
    expect(await db.select(db.budgets).get(), hasLength(3));
    expect(await db.select(db.financialGoals).get(), hasLength(2));
    expect(await db.select(db.recurringTransactions).get(), hasLength(3));

    await db.close();
  });
}
