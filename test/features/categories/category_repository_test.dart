import 'package:drift/native.dart';
import 'package:fince/core/storage/app_database.dart';
import 'package:fince/features/categories/data/datasources/category_local_data_source.dart';
import 'package:fince/features/categories/data/repositories/category_repository_impl.dart';
import 'package:fince/features/categories/domain/entities/category.dart';
import 'package:fince/features/categories/domain/usecases/create_category.dart';
import 'package:fince/features/categories/domain/usecases/delete_category.dart';
import 'package:fince/features/categories/domain/usecases/seed_default_categories.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late AppDatabase db;
  late SeedDefaultCategories seed;
  late CreateCategory createCategory;
  late DeleteCategory deleteCategory;

  setUp(() {
    db = AppDatabase(NativeDatabase.memory());
    final local = CategoryLocalDataSource(db);
    final repository = CategoryRepositoryImpl(local: local);
    seed = SeedDefaultCategories(repository);
    createCategory = CreateCategory(repository);
    deleteCategory = DeleteCategory(repository);
  });

  tearDown(() async {
    await db.close();
  });

  test('seeds default categories exactly once (idempotent)', () async {
    await seed();
    await seed();

    final rows = await db.select(db.categories).get();
    expect(rows, hasLength(15));
    expect(rows.where((r) => r.isDefault), hasLength(15));
  });

  test('creates and deletes a custom category', () async {
    final created = await createCategory(
      name: 'Mercado',
      type: CategoryType.expense,
      icon: 'shopping_bag',
      color: '#D64550',
    );

    expect(created.isDefault, isFalse);

    await deleteCategory(created.id);

    final rows = await db.select(db.categories).get();
    expect(rows.where((r) => r.id == created.id), isEmpty);
  });

  test('delete never removes default categories', () async {
    await seed();

    final defaults = await db.select(db.categories).get();
    final defaultId = defaults.first.id;

    await deleteCategory(defaultId);

    final after = await db.select(db.categories).get();
    expect(after.any((r) => r.id == defaultId), isTrue);
  });
}
