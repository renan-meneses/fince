import 'package:uuid/uuid.dart';

import '../entities/category.dart';
import '../repositories/category_repository.dart';

/// Creates a custom category with a client-generated UUID.
class CreateCategory {
  const CreateCategory(this._repository, {Uuid uuid = const Uuid()})
      : _uuid = uuid;

  final CategoryRepository _repository;
  final Uuid _uuid;

  Future<Category> call({
    required String name,
    required CategoryType type,
    required String icon,
    required String color,
  }) {
    return _repository.createCategory(
      Category(
        id: _uuid.v4(),
        name: name,
        type: type,
        icon: icon,
        color: color,
        isDefault: false,
      ),
    );
  }
}
