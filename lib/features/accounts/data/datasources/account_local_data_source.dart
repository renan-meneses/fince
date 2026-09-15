import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';

import '../../../../core/domain/money.dart';
import '../../../../core/errors/failure.dart';
import '../../../../core/storage/app_database.dart';
import '../../domain/entities/account.dart';

/// Drift-backed local storage for accounts and transfers.
class AccountLocalDataSource {
  AccountLocalDataSource(this._db);

  final AppDatabase _db;

  static const _uuid = Uuid();

  Stream<List<Account>> watchAll() {
    final query = _db.select(_db.accounts)
      ..where((t) => t.isActive.equals(true))
      ..orderBy([(t) => OrderingTerm.asc(t.createdAt)]);
    return query.watch().map((rows) => rows.map(_toEntity).toList());
  }

  Future<List<Account>> getAll() async {
    final rows = await (_db.select(_db.accounts)
          ..where((t) => t.isActive.equals(true)))
        .get();
    return rows.map(_toEntity).toList();
  }

  Future<Account> insert(Account account) async {
    await _db.into(_db.accounts).insert(_toCompanion(account));
    return account;
  }

  Future<Account> update(Account account) async {
    await (_db.update(_db.accounts)..where((t) => t.id.equals(account.id)))
        .write(_toCompanion(account));
    return account;
  }

  Future<void> archive(String id) async {
    await (_db.update(_db.accounts)..where((t) => t.id.equals(id)))
        .write(const AccountsCompanion(isActive: Value(false)));
  }

  /// Atomically debits the source, credits the destination, and records a
  /// transfer transaction — all-or-nothing. Net worth is unchanged.
  Future<void> transfer({
    required String fromId,
    required String toId,
    required Money amount,
    required DateTime date,
    String? description,
  }) async {
    await _db.transaction(() async {
      final source = await (_db.select(_db.accounts)
            ..where((t) => t.id.equals(fromId)))
          .getSingleOrNull();
      final destination = await (_db.select(_db.accounts)
            ..where((t) => t.id.equals(toId)))
          .getSingleOrNull();

      if (source == null || destination == null) {
        throw const DatabaseFailure(message: 'Conta não encontrada.');
      }
      if (source.currency != destination.currency ||
          source.currency != amount.currency) {
        throw const ValidationFailure(
          message: 'Transferências exigem a mesma moeda.',
        );
      }

      final newSourceBalance = source.currentBalanceMinor - amount.minorUnits;
      final newDestinationBalance =
          destination.currentBalanceMinor + amount.minorUnits;

      await (_db.update(_db.accounts)..where((t) => t.id.equals(fromId)))
          .write(AccountsCompanion(currentBalanceMinor: Value(newSourceBalance)));
      await (_db.update(_db.accounts)..where((t) => t.id.equals(toId)))
          .write(
        AccountsCompanion(currentBalanceMinor: Value(newDestinationBalance)),
      );

      final now = DateTime.now().toUtc();
      await _db.into(_db.transactions).insert(
            TransactionsCompanion.insert(
              id: _uuid.v4(),
              description: description ?? 'Transferência',
              amountMinor: amount.minorUnits,
              currency: amount.currency,
              type: 'transfer',
              accountId: fromId,
              transferAccountId: Value(toId),
              date: date,
              createdAt: now,
              updatedAt: now,
            ),
          );
    });
  }

  Account _toEntity(AccountRow row) => Account(
        id: row.id,
        name: row.name,
        type: AccountType.values.byName(row.type),
        currentBalance: Money(row.currentBalanceMinor, row.currency),
        initialBalance: Money(row.initialBalanceMinor, row.currency),
        currency: row.currency,
        institution: row.institution,
        color: row.color,
        icon: row.icon,
        createdAt: row.createdAt,
        isActive: row.isActive,
      );

  AccountsCompanion _toCompanion(Account a) => AccountsCompanion.insert(
        id: a.id,
        name: a.name,
        type: a.type.name,
        currentBalanceMinor: a.currentBalance.minorUnits,
        initialBalanceMinor: a.initialBalance.minorUnits,
        currency: a.currency,
        institution: Value(a.institution),
        color: a.color,
        icon: a.icon,
        createdAt: a.createdAt,
        isActive: Value(a.isActive),
      );
}
