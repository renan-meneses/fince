import 'package:drift/native.dart';
import 'package:fince/core/domain/money.dart';
import 'package:fince/core/storage/app_database.dart';
import 'package:fince/features/accounts/data/datasources/account_local_data_source.dart';
import 'package:fince/features/accounts/data/repositories/account_repository_impl.dart';
import 'package:fince/features/accounts/domain/entities/account.dart';
import 'package:fince/features/categories/data/datasources/category_local_data_source.dart';
import 'package:fince/features/categories/data/repositories/category_repository_impl.dart';
import 'package:fince/features/dashboard/data/repositories/dashboard_repository_impl.dart';
import 'package:fince/features/dashboard/domain/usecases/watch_overview.dart';
import 'package:fince/features/dashboard/presentation/cubit/dashboard_cubit.dart';
import 'package:fince/features/dashboard/presentation/screens/dashboard_screen.dart';
import 'package:fince/features/transactions/data/datasources/transaction_local_data_source.dart';
import 'package:fince/features/transactions/data/repositories/transaction_repository_impl.dart';
import 'package:fince/features/transactions/domain/entities/transaction.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:uuid/uuid.dart';

/// End-to-end (data → domain → presentation) smoke test. Runs on a device or
/// emulator: `flutter test integration_test/app_test.dart -d <device>`.
void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('dashboard renders persisted accounts and transactions',
      (tester) async {
    final db = AppDatabase(NativeDatabase.memory());
    final accounts = AccountLocalDataSource(db);
    final transactions = TransactionLocalDataSource(db);
    final categories = CategoryLocalDataSource(db);

    final accountId = const Uuid().v4();
    await accounts.insert(
      Account(
        id: accountId,
        name: 'Conta Corrente',
        type: AccountType.checking,
        currentBalance: Money(50000, 'BRL'),
        initialBalance: Money(0, 'BRL'),
        currency: 'BRL',
        color: '#0B6E4F',
        icon: 'bank',
        createdAt: DateTime.now().toUtc(),
        isActive: true,
      ),
    );
    await transactions.create(
      Transaction(
        id: const Uuid().v4(),
        description: 'Salário',
        amount: Money(50000, 'BRL'),
        type: TransactionType.income,
        accountId: accountId,
        date: DateTime.now(),
        paymentStatus: PaymentStatus.paid,
        tags: const [],
        createdAt: DateTime.now().toUtc(),
        updatedAt: DateTime.now().toUtc(),
      ),
    );

    final accountRepo = AccountRepositoryImpl(local: accounts);
    final transactionRepo = TransactionRepositoryImpl(local: transactions);
    final categoryRepo = CategoryRepositoryImpl(local: categories);

    final cubit = DashboardCubit(
      watchOverview: WatchOverview(
        DashboardRepositoryImpl(
          accounts: accountRepo,
          transactions: transactionRepo,
          categories: categoryRepo,
        ),
      ),
    );

    await tester.pumpWidget(
      BlocProvider.value(
        value: cubit,
        child: const MaterialApp(home: DashboardScreen()),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Saldo total'), findsOneWidget);
    expect(find.text('Salário'), findsOneWidget);

    await db.close();
  });
}
