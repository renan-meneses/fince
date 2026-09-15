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

/// Type scale. Colors are intentionally omitted so styles inherit from the
/// active theme; only size/weight/height are fixed.
abstract final class AppTypography {
  static const TextStyle displayLarge =
      TextStyle(fontSize: 40, fontWeight: FontWeight.w700, height: 1.1);
  static const TextStyle headline =
      TextStyle(fontSize: 24, fontWeight: FontWeight.w700, height: 1.2);
  static const TextStyle title =
      TextStyle(fontSize: 18, fontWeight: FontWeight.w600, height: 1.3);
  static const TextStyle body =
      TextStyle(fontSize: 15, fontWeight: FontWeight.w400, height: 1.4);
  static const TextStyle bodyStrong =
      TextStyle(fontSize: 15, fontWeight: FontWeight.w600, height: 1.4);
  static const TextStyle label =
      TextStyle(fontSize: 13, fontWeight: FontWeight.w500, height: 1.3);
  static const TextStyle caption =
      TextStyle(fontSize: 12, fontWeight: FontWeight.w400, height: 1.3);
}

abstract final class AppShadows {
  static final List<BoxShadow> card = [
    BoxShadow(
      color: Colors.black.withValues(alpha: 0.05),
      blurRadius: 16,
      offset: const Offset(0, 4),
    ),
  ];

  static final List<BoxShadow> overlay = [
    BoxShadow(
      color: Colors.black.withValues(alpha: 0.14),
      blurRadius: 28,
      offset: const Offset(0, 10),
    ),
  ];
}

/// Icon tokens so a brand/icon swap is a single change, not a screen-by-screen
/// hunt.
abstract final class AppIcons {
  static const IconData income = Icons.south_west_rounded;
  static const IconData expense = Icons.north_east_rounded;
  static const IconData transfer = Icons.swap_horiz_rounded;
  static const IconData account = Icons.account_balance_wallet_rounded;
  static const IconData creditCard = Icons.credit_card_rounded;
  static const IconData budget = Icons.pie_chart_rounded;
  static const IconData goal = Icons.flag_rounded;
  static const IconData report = Icons.bar_chart_rounded;
  static const IconData insight = Icons.lightbulb_rounded;
  static const IconData recurring = Icons.repeat_rounded;
  static const IconData settings = Icons.settings_rounded;
}
