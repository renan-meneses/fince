import '../entities/category.dart';

/// Category contract (domain port).
abstract interface class CategoryRepository {
  Stream<List<Category>> watchCategories({CategoryType? type});

  Future<Category> createCategory(Category category);

  /// Deletes a custom category. Default categories cannot be deleted.
  Future<void> deleteCategory(String id);

  /// Idempotently seeds the built-in default categories.
  Future<void> seedDefaultCategories();
}
