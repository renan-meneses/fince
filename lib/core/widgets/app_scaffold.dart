import 'package:flutter/material.dart';

import '../theme/design_tokens.dart';

/// Standard themed [Scaffold] wrapper so screens share consistent padding,
/// app bar behavior, and floating action button styling.
class AppScaffold extends StatelessWidget {
  const AppScaffold({
    super.key,
    this.title,
    required this.body,
    this.actions,
    this.floatingActionButton,
    this.bottomNavigationBar,
  });

  final String? title;
  final Widget body;
  final List<Widget>? actions;
  final Widget? floatingActionButton;
  final Widget? bottomNavigationBar;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: title == null && (actions == null || actions!.isEmpty)
          ? null
          : AppBar(title: title == null ? null : Text(title!), actions: actions),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
          child: body,
        ),
      ),
      floatingActionButton: floatingActionButton,
      bottomNavigationBar: bottomNavigationBar,
    );
  }
}
