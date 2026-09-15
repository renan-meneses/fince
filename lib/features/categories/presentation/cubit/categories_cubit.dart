import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/errors/failure.dart';
import '../../domain/entities/category.dart';
import '../../domain/usecases/create_category.dart';
import '../../domain/usecases/delete_category.dart';
import '../../domain/usecases/seed_default_categories.dart';
import '../../domain/usecases/watch_categories.dart';
import 'categories_state.dart';

/// Exposes the reactive category list and ensures defaults are seeded.
class CategoriesCubit extends Cubit<CategoriesState> {
  CategoriesCubit({
    required WatchCategories watchCategories,
    required CreateCategory createCategory,
    required DeleteCategory deleteCategory,
    required SeedDefaultCategories seedDefaultCategories,
  })  : _createCategory = createCategory,
        _deleteCategory = deleteCategory,
        _seedDefaultCategories = seedDefaultCategories,
        super(const CategoriesState.loading()) {
    unawaited(_seedDefaultCategories());
    _subscription = watchCategories().listen(_onData, onError: _onError);
  }

  final CreateCategory _createCategory;
  final DeleteCategory _deleteCategory;
  final SeedDefaultCategories _seedDefaultCategories;

  late final StreamSubscription<List<Category>> _subscription;

  void _onData(List<Category> categories) {
    if (!isClosed) emit(CategoriesState.loaded(categories));
  }

  void _onError(Object error) {
    if (!isClosed) {
      emit(CategoriesState.failure(
        error is Failure ? error : UnknownFailure(message: error.toString()),
      ));
    }
  }

  Future<void> createCategory({
    required String name,
    required CategoryType type,
    required String icon,
    required String color,
  }) =>
      _createCategory(name: name, type: type, icon: icon, color: color);

  Future<void> deleteCategory(String id) => _deleteCategory(id);

  @override
  Future<void> close() {
    _subscription.cancel();
    return super.close();
  }
}
