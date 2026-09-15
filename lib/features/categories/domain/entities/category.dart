import 'package:freezed_annotation/freezed_annotation.dart';

part 'category.freezed.dart';

/// Category kind.
enum CategoryType { income, expense }

/// A transaction category (with optional parent for subcategories).
@freezed
abstract class Category with _$Category {
  const factory Category({
    required String id,
    required String name,
    required CategoryType type,
    required String icon,
    required String color,
    required bool isDefault,
    String? parentId,
  }) = _Category;
}
