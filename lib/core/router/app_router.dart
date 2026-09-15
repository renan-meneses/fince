import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// Typed application router.
///
/// Route names mirror the feature map. Auth redirect guards will be attached
/// once the auth module exists (task 4).
class AppRouter {
  AppRouter();

  late final GoRouter router = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        name: 'home',
        builder: (context, state) => const _HomePlaceholder(),
      ),
    ],
  );
}

/// Temporary bootstrap screen, replaced by the real dashboard in task 9.
class _HomePlaceholder extends StatelessWidget {
  const _HomePlaceholder();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Fince')),
      body: const Center(child: Text('Dashboard em breve')),
    );
  }
}
