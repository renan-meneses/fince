import 'package:flutter/material.dart';

/// Centralized design tokens. Screens and widgets must consume these instead
/// of hard-coding colors, spacing, radii, or type sizes.
abstract final class AppColors {
  // Brand
  static const Color primary = Color(0xFF0B6E4F);
  static const Color onPrimary = Colors.white;

  // Semantic — finance
  static const Color income = Color(0xFF1B9E77);
  static const Color expense = Color(0xFFD64550);
  static const Color warning = Color(0xFFF2A03D);
  static const Color info = Color(0xFF3B82F6);

  // Surface
  static const Color surfaceLight = Color(0xFFF7F8FA);
  static const Color surfaceDark = Color(0xFF121417);
}

abstract final class AppSpacing {
  static const double xxs = 4;
  static const double xs = 8;
  static const double sm = 12;
  static const double md = 16;
  static const double lg = 24;
  static const double xl = 32;
  static const double xxl = 48;
}

abstract final class AppRadius {
  static const double sm = 8;
  static const double md = 12;
  static const double lg = 16;
  static const double xl = 24;
  static const double pill = 999;
}

abstract final class AppElevation {
  static const double card = 0;
  static const double raised = 2;
  static const double overlay = 8;
}

abstract final class AppDurations {
  static const Duration fast = Duration(milliseconds: 150);
  static const Duration normal = Duration(milliseconds: 250);
}
