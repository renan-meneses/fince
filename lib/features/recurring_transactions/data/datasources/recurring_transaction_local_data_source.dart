import 'dart:convert';

import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';

import '../../../../core/domain/money.dart';
import '../../../../core/storage/app_database.dart';
import '../../../transactions/data/datasources/transaction_local_data_source.dart';
import '../../../transactions/domain/entities/transaction.dart';
import '../../domain/entities/recurring_transaction.dart';

/// Drift-backed storage for recurring transactions.
class RecurringTransactionLocalDataSource {
  RecurringTransactionLocalDataSource(this._db, this._transactionSource);

  final AppDatabase _db;
  final TransactionLocalDataSource _transactionSource;

  static const _uuid = Uuid();

  Stream<List<RecurringTransaction>> watchAll() {
    final query = _db.select(_db.recurringTransactions)
      ..orderBy([(t) => OrderingTerm.asc(t.nextDueDate)]);
    return query.watch().map((rows) => rows.map(_toEntity).toList());
  }

  Future<RecurringTransaction> insert(RecurringTransaction recurring) async {
    await _db.into(_db.recurringTransactions).insert(_toCompanion(recurring));
    return recurring;
  }

  Future<RecurringTransaction> update(RecurringTransaction recurring) async {
    await (_db.update(_db.recurringTransactions)
          ..where((t) => t.id.equals(recurring.id)))
        .write(_toCompanion(recurring));
    return recurring;
  }

  Future<void> delete(String id) async {
    await (_db.delete(_db.recurringTransactions)
          ..where((t) => t.id.equals(id)))
        .go();
  }

  /// Generates due occurrences up to [now]. Idempotent: occurrences are
  /// keyed by (recurrenceId, date), so re-running never duplicates.
  Future<int> generateDueOccurrences(DateTime now) async {
    final rules = await (_db.select(_db.recurringTransactions)
          ..where(
            (t) =>
                t.isActive.equals(true) &
                t.nextDueDate.isSmallerOrEqualValue(now),
          ))
        .get();

    var generated = 0;
    for (final rule in rules) {
      var due = rule.nextDueDate;
      while (!due.isAfter(now) &&
          (rule.endDate == null || !due.isAfter(rule.endDate!))) {
        final alreadyExists = await _hasOccurrence(rule.id, due);
        if (!alreadyExists) {
          await _transactionSource.create(
            Transaction(
              id: _uuid.v4(),
              description: rule.description,
              amount: Money(rule.amountMinor, rule.currency),
              type: TransactionType.values.byName(rule.type),
              accountId: rule.accountId,
              categoryId: rule.categoryId,
              date: due,
              paymentStatus: PaymentStatus.paid,
              recurrenceId: rule.id,
              tags: const [],
              createdAt: now,
              updatedAt: now,
            ),
          );
          generated++;
        }
        due = _advance(rule, due);
      }

      await (_db.update(_db.recurringTransactions)
            ..where((t) => t.id.equals(rule.id)))
          .write(
        RecurringTransactionsCompanion(
          nextDueDate: Value(due),
          lastGeneratedDate: Value(now),
        ),
      );
    }

    return generated;
  }

  Future<bool> _hasOccurrence(String recurrenceId, DateTime date) async {
    final row = await (_db.select(_db.transactions)
          ..where((t) =>
              t.recurrenceId.equals(recurrenceId) & t.date.equals(date)))
        .getSingleOrNull();
    return row != null;
  }

  DateTime _advance(RecurringTransactionRow rule, DateTime due) {
    final frequency = RecurrenceFrequency.values.byName(rule.frequency);
    final interval = rule.interval;
    switch (frequency) {
      case RecurrenceFrequency.daily:
        return due.add(Duration(days: interval));
      case RecurrenceFrequency.weekly:
        return due.add(Duration(days: 7 * interval));
      case RecurrenceFrequency.monthly:
        return DateTime(
          due.year,
          due.month + interval,
          rule.dayOfMonth ?? due.day,
        );
      case RecurrenceFrequency.yearly:
        return DateTime(
          due.year + interval,
          due.month,
          rule.dayOfMonth ?? due.day,
        );
      case RecurrenceFrequency.custom:
        return due.add(Duration(days: interval));
    }
  }

  RecurringTransaction _toEntity(RecurringTransactionRow row) =>
      RecurringTransaction(
        id: row.id,
        description: row.description,
        amount: Money(row.amountMinor, row.currency),
        type: TransactionType.values.byName(row.type),
        accountId: row.accountId,
        categoryId: row.categoryId,
        rule: RecurrenceRule(
          frequency: RecurrenceFrequency.values.byName(row.frequency),
          interval: row.interval,
          dayOfMonth: row.dayOfMonth,
          daysOfWeek: (jsonDecode(row.daysOfWeek ?? '[]') as List<dynamic>)
              .cast<int>(),
        ),
        startDate: row.startDate,
        endDate: row.endDate,
        lastGeneratedDate: row.lastGeneratedDate,
        nextDueDate: row.nextDueDate,
        isActive: row.isActive,
      );

  RecurringTransactionsCompanion _toCompanion(RecurringTransaction r) =>
      RecurringTransactionsCompanion.insert(
        id: r.id,
        description: r.description,
        amountMinor: r.amount.minorUnits,
        currency: r.amount.currency,
        type: r.type.name,
        accountId: r.accountId,
        categoryId: Value(r.categoryId),
        frequency: r.rule.frequency.name,
        interval: Value(r.rule.interval),
        dayOfMonth: Value(r.rule.dayOfMonth),
        daysOfWeek: Value(jsonEncode(r.rule.daysOfWeek)),
        startDate: r.startDate,
        endDate: Value(r.endDate),
        lastGeneratedDate: Value(r.lastGeneratedDate),
        nextDueDate: r.nextDueDate,
        isActive: Value(r.isActive),
      );
}
