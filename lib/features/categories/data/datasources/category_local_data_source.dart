import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';

import '../../../../core/storage/app_database.dart';
import '../../domain/entities/category.dart';

/// Drift-backed local storage for categories, including the default seed set.
class CategoryLocalDataSource {
  CategoryLocalDataSource(this._db);

  final AppDatabase _db;

  static const _uuid = Uuid();

  static const List<({String name, CategoryType type, String icon, String color})>
      _defaultSeeds = [
    (name: 'Alimentação', type: CategoryType.expense, icon: 'restaurant', color: '#E64A19'),
    (name: 'Moradia', type: CategoryType.expense, icon: 'home', color: '#0B6E4F'),
    (name: 'Transporte', type: CategoryType.expense, icon: 'directions_bus', color: '#3B82F6'),
    (name: 'Saúde', type: CategoryType.expense, icon: 'favorite', color: '#D64550'),
    (name: 'Educação', type: CategoryType.expense, icon: 'school', color: '#7C3AED'),
    (name: 'Entretenimento', type: CategoryType.expense, icon: 'movie', color: '#0E7490'),
    (name: 'Compras', type: CategoryType.expense, icon: 'shopping_bag', color: '#D64550'),
    (name: 'Assinaturas', type: CategoryType.expense, icon: 'subscriptions', color: '#F2A03D'),
    (name: 'Impostos', type: CategoryType.expense, icon: 'receipt_long', color: '#64748B'),
    (name: 'Salário', type: CategoryType.income, icon: 'work', color: '#1B9E77'),
    (name: 'Freelance', type: CategoryType.income, icon: 'laptop', color: '#0E7490'),
    (name: 'Investimentos', type: CategoryType.income, icon: 'trending_up', color: '#0B6E4F'),
    (name: 'Vendas', type: CategoryType.income, icon: 'sell', color: '#F2A03D'),
    (name: 'Reembolsos', type: CategoryType.income, icon: 'replay', color: '#3B82F6'),
    (name: 'Outros', type: CategoryType.income, icon: 'more_horiz', color: '#64748B'),
  ];

  Stream<List<Category>> watchAll({CategoryType? type}) {
    final query = _db.select(_db.categories)
      ..orderBy([(t) => OrderingTerm.asc(t.name)]);
    if (type != null) {
      query.where((t) => t.type.equals(type.name));
    }
    return query.watch().map((rows) => rows.map(_toEntity).toList());
  }

  Future<Category> insert(Category category) async {
    await _db.into(_db.categories).insert(_toCompanion(category));
    return category;
  }

  Future<void> deleteCustom(String id) async {
    await (_db.delete(_db.categories)
          ..where((t) => t.id.equals(id) & t.isDefault.equals(false)))
        .go();
  }

  /// Seeds the default categories exactly once (idempotent).
  Future<void> seedDefaults() async {
    final existing = await (_db.select(_db.categories)
          ..where((t) => t.isDefault.equals(true)))
        .get();
    if (existing.isNotEmpty) return;

    await _db.batch((batch) {
      for (final seed in _defaultSeeds) {
        batch.insert(
          _db.categories,
          CategoriesCompanion.insert(
            id: _uuid.v4(),
            name: seed.name,
            type: seed.type.name,
            icon: seed.icon,
            color: seed.color,
            isDefault: const Value(true),
          ),
        );
      }
    });
  }

  Category _toEntity(CategoryRow row) => Category(
        id: row.id,
        name: row.name,
        type: CategoryType.values.byName(row.type),
        icon: row.icon,
        color: row.color,
        isDefault: row.isDefault,
        parentId: row.parentId,
      );

  CategoriesCompanion _toCompanion(Category c) => CategoriesCompanion.insert(
        id: c.id,
        name: c.name,
        type: c.type.name,
        icon: c.icon,
        color: c.color,
        isDefault: Value(c.isDefault),
        parentId: Value(c.parentId),
      );
}
