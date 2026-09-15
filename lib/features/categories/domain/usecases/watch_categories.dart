import '../entities/category.dart';
import '../repositories/category_repository.dart';

/// Observes categories, optionally filtered by type.
class WatchCategories {
  const WatchCategories(this._repository);

  final CategoryRepository _repository;

  Stream<List<Category>> call({CategoryType? type}) =>
      _repository.watchCategories(type: type);
}
