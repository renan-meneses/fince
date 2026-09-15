import '../repositories/category_repository.dart';

/// Ensures the built-in default categories exist (idempotent).
class SeedDefaultCategories {
  const SeedDefaultCategories(this._repository);

  final CategoryRepository _repository;

  Future<void> call() => _repository.seedDefaultCategories();
}
