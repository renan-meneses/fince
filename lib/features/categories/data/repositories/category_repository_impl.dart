import '../../../../core/errors/exception_to_failure.dart';
import '../../domain/entities/category.dart';
import '../../domain/repositories/category_repository.dart';
import '../datasources/category_local_data_source.dart';

/// Local-first [CategoryRepository].
class CategoryRepositoryImpl implements CategoryRepository {
  CategoryRepositoryImpl({required CategoryLocalDataSource local})
      : _local = local;

  final CategoryLocalDataSource _local;

  @override
  Stream<List<Category>> watchCategories({CategoryType? type}) =>
      _local.watchAll(type: type);

  @override
  Future<Category> createCategory(Category category) async {
    try {
      return await _local.insert(category);
    } catch (e) {
      throw mapExceptionToFailure(e);
    }
  }

  @override
  Future<void> deleteCategory(String id) async {
    try {
      await _local.deleteCustom(id);
    } catch (e) {
      throw mapExceptionToFailure(e);
    }
  }

  @override
  Future<void> seedDefaultCategories() async {
    try {
      await _local.seedDefaults();
    } catch (e) {
      throw mapExceptionToFailure(e);
    }
  }
}
