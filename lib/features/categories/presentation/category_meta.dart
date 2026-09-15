import 'package:flutter/material.dart';

import '../domain/entities/category.dart';

/// Maps stored icon names to Material icons.
const Map<String, IconData> categoryIconMap = {
  'restaurant': Icons.restaurant_rounded,
  'home': Icons.home_rounded,
  'directions_bus': Icons.directions_bus_rounded,
  'favorite': Icons.favorite_rounded,
  'school': Icons.school_rounded,
  'movie': Icons.movie_rounded,
  'shopping_bag': Icons.shopping_bag_rounded,
  'subscriptions': Icons.subscriptions_rounded,
  'receipt_long': Icons.receipt_long_rounded,
  'work': Icons.work_rounded,
  'laptop': Icons.laptop_rounded,
  'trending_up': Icons.trending_up_rounded,
  'sell': Icons.sell_rounded,
  'replay': Icons.replay_rounded,
  'more_horiz': Icons.more_horiz_rounded,
};

IconData categoryIconByName(String? name) =>
    categoryIconMap[name] ?? Icons.category_rounded;

/// Default icon/color for a newly created custom category.
({String icon, String color}) defaultCategoryMeta(CategoryType type) =>
    type == CategoryType.income
        ? (icon: 'work', color: '#1B9E77')
        : (icon: 'shopping_bag', color: '#D64550');
