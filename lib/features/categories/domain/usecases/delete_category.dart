import '../repositories/category_repository.dart';

/// Deletes a custom category.
class DeleteCategory {
  const DeleteCategory(this._repository);

  final CategoryRepository _repository;

  Future<void> call(String id) => _repository.deleteCategory(id);
}
