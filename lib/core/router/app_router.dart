import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../features/accounts/presentation/cubit/accounts_cubit.dart';
import '../../features/accounts/presentation/screens/account_form_screen.dart';
import '../../features/accounts/presentation/screens/accounts_screen.dart';
import '../../features/accounts/presentation/screens/transfer_screen.dart';
import '../../features/auth/presentation/cubit/auth_cubit.dart';
import '../../features/auth/presentation/screens/forgot_password_screen.dart';
import '../../features/auth/presentation/screens/login_screen.dart';
import '../../features/auth/presentation/screens/register_screen.dart';
import '../../features/categories/presentation/cubit/categories_cubit.dart';
import '../../features/categories/presentation/screens/categories_screen.dart';
import '../../features/transactions/presentation/cubit/transactions_cubit.dart';
import '../../features/transactions/presentation/screens/transaction_form_screen.dart';
import '../../features/transactions/presentation/screens/transactions_screen.dart';

/// Typed application router with auth redirect guards.
class AppRouter {
  AppRouter(
    this._authCubit,
    this._accountsCubit,
    this._categoriesCubit,
    this._transactionsCubit,
  );

  final AuthCubit _authCubit;
  final AccountsCubit _accountsCubit;
  final CategoriesCubit _categoriesCubit;
  final TransactionsCubit _transactionsCubit;

  late final GoRouter router = GoRouter(
    initialLocation: '/',
    refreshListenable: _authCubit.sessionRevision,
    redirect: (context, state) {
      final loggedIn = _authCubit.isAuthenticated;
      final isAuthRoute = state.matchedLocation == '/login' ||
          state.matchedLocation == '/register' ||
          state.matchedLocation == '/forgot-password';

      if (!loggedIn && !isAuthRoute) return '/login';
      if (loggedIn && isAuthRoute) return '/';
      return null;
    },
    routes: [
      GoRoute(
        path: '/login',
        name: 'login',
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: '/register',
        name: 'register',
        builder: (context, state) => const RegisterScreen(),
      ),
      GoRoute(
        path: '/forgot-password',
        name: 'forgotPassword',
        builder: (context, state) => const ForgotPasswordScreen(),
      ),
      GoRoute(
        path: '/',
        name: 'home',
        builder: (context, state) => const _HomePlaceholder(),
      ),
      GoRoute(
        path: '/accounts',
        name: 'accounts',
        builder: (context, state) => BlocProvider.value(
          value: _accountsCubit,
          child: const AccountsScreen(),
        ),
      ),
      GoRoute(
        path: '/accounts/new',
        name: 'newAccount',
        builder: (context, state) => BlocProvider.value(
          value: _accountsCubit,
          child: const AccountFormScreen(),
        ),
      ),
      GoRoute(
        path: '/accounts/transfer',
        name: 'transfer',
        builder: (context, state) => BlocProvider.value(
          value: _accountsCubit,
          child: const TransferScreen(),
        ),
      ),
      GoRoute(
        path: '/accounts/:id',
        name: 'editAccount',
        builder: (context, state) => BlocProvider.value(
          value: _accountsCubit,
          child: AccountFormScreen(accountId: state.pathParameters['id']),
        ),
      ),
      GoRoute(
        path: '/categories',
        name: 'categories',
        builder: (context, state) => BlocProvider.value(
          value: _categoriesCubit,
          child: const CategoriesScreen(),
        ),
      ),
      GoRoute(
        path: '/transactions',
        name: 'transactions',
        builder: (context, state) => BlocProvider.value(
          value: _transactionsCubit,
          child: const TransactionsScreen(),
        ),
      ),
      GoRoute(
        path: '/transactions/new',
        name: 'newTransaction',
        builder: (context, state) => BlocProvider.value(
          value: _transactionsCubit,
          child: const TransactionFormScreen(),
        ),
      ),
      GoRoute(
        path: '/transactions/:id',
        name: 'editTransaction',
        builder: (context, state) => BlocProvider.value(
          value: _transactionsCubit,
          child: TransactionFormScreen(transactionId: state.pathParameters['id']),
        ),
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
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Dashboard em breve'),
            const SizedBox(height: 16),
            FilledButton(
              onPressed: () => context.go('/accounts'),
              child: const Text('Ver contas'),
            ),
          ],
        ),
      ),
    );
  }
}
