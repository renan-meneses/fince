import 'package:drift/drift.dart';

part 'app_database.g.dart';

/// Monetary amounts are stored as integer minor units (see `Money`); `currency`
/// is the ISO 4217 code. All primary keys are client-generated UUID strings.

class Accounts extends Table {
  TextColumn get id => text()();
  TextColumn get name => text()();
  TextColumn get type => text()();
  IntColumn get currentBalanceMinor => integer()();
  IntColumn get initialBalanceMinor => integer()();
  TextColumn get currency => text()();
  TextColumn get institution => text().nullable()();
  TextColumn get color => text()();
  TextColumn get icon => text()();
  DateTimeColumn get createdAt => dateTime()();
  BoolColumn get isActive => boolean().withDefault(const Constant(true))();

  @override
  Set<Column> get primaryKey => {id};
}

class Categories extends Table {
  TextColumn get id => text()();
  TextColumn get name => text()();
  TextColumn get type => text()(); // income | expense
  TextColumn get icon => text()();
  TextColumn get color => text()();
  BoolColumn get isDefault => boolean().withDefault(const Constant(false))();
  TextColumn get parentId => text().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

@TableIndex(name: 'idx_transactions_account_date', columns: {#accountId, #date})
@TableIndex(name: 'idx_transactions_category_date', columns: {#categoryId, #date})
class Transactions extends Table {
  TextColumn get id => text()();
  TextColumn get description => text()();
  IntColumn get amountMinor => integer()();
  TextColumn get currency => text()();
  TextColumn get type => text()(); // income | expense | transfer
  TextColumn get accountId => text()();
  TextColumn get transferAccountId => text().nullable()();
  TextColumn get categoryId => text().nullable()();
  TextColumn get subcategoryId => text().nullable()();
  DateTimeColumn get date => dateTime()();
  TextColumn get paymentStatus => text().withDefault(const Constant('paid'))();
  TextColumn get notes => text().nullable()();
  TextColumn get tags => text().withDefault(const Constant('[]'))();
  TextColumn get attachmentPath => text().nullable()();
  TextColumn get transferGroupId => text().nullable()();
  TextColumn get recurrenceId => text().nullable()();
  TextColumn get installmentId => text().nullable()();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}

class CreditCards extends Table {
  TextColumn get id => text()();
  TextColumn get name => text()();
  TextColumn get brand => text()();
  IntColumn get creditLimitMinor => integer()();
  IntColumn get availableLimitMinor => integer()();
  TextColumn get currency => text()();
  IntColumn get closingDay => integer()();
  IntColumn get dueDay => integer()();
  TextColumn get linkedAccountId => text().nullable()();
  DateTimeColumn get createdAt => dateTime()();
  BoolColumn get isActive => boolean().withDefault(const Constant(true))();

  @override
  Set<Column> get primaryKey => {id};
}

@TableIndex(name: 'idx_invoices_card', columns: {#creditCardId})
class CreditCardInvoices extends Table {
  TextColumn get id => text()();
  TextColumn get creditCardId => text()();
  DateTimeColumn get periodStart => dateTime()();
  DateTimeColumn get periodEnd => dateTime()();
  DateTimeColumn get closingDate => dateTime()();
  DateTimeColumn get dueDate => dateTime()();
  IntColumn get totalAmountMinor => integer()();
  IntColumn get paidAmountMinor => integer().withDefault(const Constant(0))();
  TextColumn get currency => text()();
  TextColumn get status => text().withDefault(const Constant('open'))();
  DateTimeColumn get paidAt => dateTime().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

@TableIndex(name: 'idx_installments_invoice', columns: {#creditCardInvoiceId})
@TableIndex(name: 'idx_installments_transaction', columns: {#transactionId})
class Installments extends Table {
  TextColumn get id => text()();
  TextColumn get transactionId => text()();
  TextColumn get creditCardInvoiceId => text().nullable()();
  IntColumn get number => integer()();
  IntColumn get totalInstallments => integer()();
  IntColumn get amountMinor => integer()();
  TextColumn get currency => text()();
  DateTimeColumn get dueDate => dateTime()();
  TextColumn get status => text().withDefault(const Constant('pending'))();
  DateTimeColumn get paidAt => dateTime().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

@TableIndex(name: 'idx_budgets_month', columns: {#month})
class Budgets extends Table {
  TextColumn get id => text()();
  TextColumn get categoryId => text()();
  IntColumn get amountMinor => integer()();
  TextColumn get currency => text()();
  TextColumn get month => text()(); // 'yyyy-MM'
  DateTimeColumn get createdAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}

class FinancialGoals extends Table {
  TextColumn get id => text()();
  TextColumn get name => text()();
  IntColumn get targetAmountMinor => integer()();
  IntColumn get currentAmountMinor => integer()();
  TextColumn get currency => text()();
  DateTimeColumn get targetDate => dateTime().nullable()();
  TextColumn get description => text().nullable()();
  TextColumn get status => text().withDefault(const Constant('active'))();
  DateTimeColumn get createdAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}

class RecurringTransactions extends Table {
  TextColumn get id => text()();
  TextColumn get description => text()();
  IntColumn get amountMinor => integer()();
  TextColumn get currency => text()();
  TextColumn get type => text()();
  TextColumn get accountId => text()();
  TextColumn get categoryId => text().nullable()();
  TextColumn get frequency => text()(); // daily | weekly | monthly | yearly | custom
  IntColumn get interval => integer().withDefault(const Constant(1))();
  IntColumn get dayOfMonth => integer().nullable()();
  TextColumn get daysOfWeek => text().nullable()(); // JSON list of ints
  DateTimeColumn get startDate => dateTime()();
  DateTimeColumn get endDate => dateTime().nullable()();
  DateTimeColumn get lastGeneratedDate => dateTime().nullable()();
  DateTimeColumn get nextDueDate => dateTime()();
  BoolColumn get isActive => boolean().withDefault(const Constant(true))();

  @override
  Set<Column> get primaryKey => {id};
}

class FinancialInsights extends Table {
  TextColumn get id => text()();
  TextColumn get type => text()();
  TextColumn get title => text()();
  TextColumn get message => text()();
  TextColumn get severity => text()();
  TextColumn get payload => text().withDefault(const Constant('{}'))();
  TextColumn get period => text()();
  DateTimeColumn get createdAt => dateTime()();
  BoolColumn get isRead => boolean().withDefault(const Constant(false))();

  @override
  Set<Column> get primaryKey => {id};
}

@TableIndex(name: 'idx_sync_status', columns: {#status})
class SyncOperations extends Table {
  TextColumn get id => text()();
  TextColumn get entityId => text()();
  TextColumn get entityType => text()();
  TextColumn get operation => text()(); // create | update | delete
  TextColumn get payload => text()();
  DateTimeColumn get timestamp => dateTime()();
  TextColumn get status => text().withDefault(const Constant('pending'))();
  IntColumn get retryCount => integer().withDefault(const Constant(0))();
  TextColumn get lastError => text().nullable()();
  TextColumn get idempotencyKey => text()();

  @override
  Set<Column> get primaryKey => {id};
}

@DriftDatabase(
  tables: [
    Accounts,
    Categories,
    Transactions,
    CreditCards,
    CreditCardInvoices,
    Installments,
    Budgets,
    FinancialGoals,
    RecurringTransactions,
    FinancialInsights,
    SyncOperations,
  ],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase(super.executor);

  @override
  int get schemaVersion => 1;
}
