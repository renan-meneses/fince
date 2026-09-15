# Domain Model

## 1. Value objects

### `Money`

The foundation of all monetary calculations. **No floating point.**

```dart
@immutable
class Money implements Comparable<Money> {
  final int minorUnits;   // BRL 123.45 -> 12345
  final String currency;  // ISO 4217, e.g. "BRL", "USD"

  Money operator +(Money other);          // throws CurrencyMismatch on differing currency
  Money operator -(Money other);          // throws CurrencyMismatch on differing currency
  bool operator >(Money other);
  bool operator <(Money other);
  bool get isZero;
  bool get isNegative;
  String format([String? locale]);        // intl NumberFormat.currency
  String toJson();                        // "12345:BRL"
  static Money fromJson(String value);
}
```

Rules:

- Internally always **integer minor units**; `BRL 123.45` is `12345` cents.
- **Currency validation** on construction: the code must be a recognized ISO 4217 code; an
  invalid code raises `InvalidCurrency` (mapped to `ValidationFailure`).
- **Arithmetic validates currency equality** and raises `CurrencyMismatch` otherwise — you can
  never silently add BRL to USD.
- **Formatting** is a pure presentation concern using `intl`, but lives on the VO so it is
  consistent everywhere.

### `RecurrenceRule`

```dart
enum RecurrenceFrequency { daily, weekly, monthly, yearly, custom }

class RecurrenceRule {
  final RecurrenceFrequency frequency;
  final int interval;        // custom: every N periods (e.g. every 2 weeks)
  final int? dayOfMonth;     // monthly/yearly anchor
  final Set<int>? daysOfWeek;// weekly anchor
}
```

### Enumerations

`TransactionType { income, expense, transfer }`,
`PaymentStatus { pending, paid, overdue, cancelled }`,
`AccountType { checking, savings, cash, digitalWallet, investment }`,
`CardBrand { visa, mastercard, amex, elo, hipercard, other }`,
`InvoiceStatus { open, closed, paid, overdue }`,
`InstallmentStatus { pending, paid, overdue }`,
`SyncStatus { pending, syncing, synced, failed }`,
`OperationType { create, update, delete }`.

## 2. Entities

All entities are immutable (freezed), use `String` UUID ids, and carry `createdAt`/`updatedAt`
timestamps where relevant.

### `User`
`id`, `email`, `name`, `avatarUrl?`, `locale`, `currency`, `createdAt`, `isActive`.

### `Account`
`id`, `name`, `type: AccountType`, `currentBalance: Money`, `initialBalance: Money`,
`currency`, `institution?`, `color`, `icon`, `createdAt`, `isActive`.
`currentBalance` is a **derived, authoritative** figure maintained by the account balance
service (never recomputed lazily from scratch on every read; instead adjusted atomically on each
transaction write).

### `Transaction`
`id`, `description`, `amount: Money`, `type: TransactionType`, `accountId` (source account),
`transferAccountId?` (destination, transfers only), `categoryId?`, `subcategoryId?`,
`date`, `paymentStatus`, `notes?`, `tags: List<String>`, `attachmentPath?`,
`transferGroupId?`, `recurrenceId?`, `installmentId?`, `createdAt`, `updatedAt`.

### `Category`
`id`, `name`, `type: TransactionType` (income or expense; transfers have no category),
`icon`, `color`, `isDefault`, `parentId?` (enables subcategories).

### `CreditCard`
`id`, `name`, `brand: CardBrand`, `creditLimit: Money`, `availableLimit: Money`,
`closingDay: int`, `dueDay: int`, `linkedAccountId?` (account used to pay the invoice),
`createdAt`, `isActive`.

### `CreditCardInvoice`
`id`, `creditCardId`, `periodStart`, `periodEnd`, `closingDate`, `dueDate`,
`totalAmount: Money`, `paidAmount: Money`, `status: InvoiceStatus`, `paidAt?`.

### `Installment`
`id`, `transactionId` (the original purchase), `creditCardInvoiceId?`, `number: int`,
`totalInstallments: int`, `amount: Money`, `dueDate`, `status: InstallmentStatus`,
`paidAt?`.

### `Budget`
`id`, `categoryId`, `amount: Money`, `month` (year-month), `createdAt`.
`spent` is **derived** by summing categorized expenses in the period; remaining and percentage
are computed, never stored (avoids drift).

### `FinancialGoal`
`id`, `name`, `targetAmount: Money`, `currentAmount: Money`, `targetDate?`,
`description?`, `status { active, completed, archived }`, `createdAt`.
`currentAmount` is updated through explicit `deposit`/`withdraw` operations.

### `RecurringTransaction`
`id`, `template: Transaction` fields (description, amount, type, accountId, categoryId, …),
`rule: RecurrenceRule`, `startDate`, `endDate?`, `lastGeneratedDate?`, `nextDueDate`,
`isActive`.

### `FinancialInsight`
`id`, `type` (e.g. `spending_increase`, `budget_usage`, `subscription_share`, `savings_rate`),
`title`, `message`, `severity { info, warning, critical }`, `payload: Map<String, dynamic>`,
`period`, `createdAt`, `isRead`.

### `SyncOperation`
`id`, `entityId`, `entityType`, `operation: OperationType`, `payload: String` (JSON),
`timestamp`, `status: SyncStatus`, `retryCount`, `lastError?`, `idempotencyKey`.

## 3. Relationships

```
User 1───* Account
User 1───* Category
Account 1───* Transaction (as source)
Account 1───* Transaction (as transfer destination, nullable)
Category 1───* Transaction (optional; transfers/uncategorized excluded)
Category 1───* Category (parent → subcategory)

CreditCard 1───* CreditCardInvoice
CreditCardInvoice 1───* Installment
CreditCard 1───* Installment
Transaction 1───* Installment   (purchase split into N installments)
Account 1───1 CreditCard        (linked payment account, optional)

Category 1───* Budget
RecurringTransaction *───1 Transaction (generated occurrences reference the template)
```

## 4. Transaction ↔ Account relationship

- A `Transaction` always has exactly one **source `accountId`**.
- For `income`, the source account is credited `+amount`.
- For `expense`, the source account is debited `-amount`.
- For `transfer`, the source account is debited and the **`transferAccountId`** is credited;
  `amount` is always a positive magnitude and the sign is implied by `type`.
- **Balance correctness is enforced in the domain use case**, then applied inside a single
  Drift transaction so a partial write can never occur.

## 5. Transfers preserve financial consistency

A transfer moves money between two accounts **without changing net worth**.

- Modeled as **one** `Transaction` of `type: transfer` with both `accountId` and
  `transferAccountId`. It is therefore naturally **excluded** from income/expense reports
  (reports filter `type != transfer`), so a transfer never inflates income or expenses.
- The `TransferBetweenAccounts` use case runs inside one database transaction:
  1. debit source account balance,
  2. credit destination account balance,
  3. insert the transfer transaction,
  4. enqueue one sync operation.
  All four succeed or none do.
- **Net worth invariant** (`sum of all account balances`) is unchanged because the same amount
  is subtracted from one account and added to another.
- **Currency rule (v1):** transfers require matching currencies. Cross-currency transfers are
  out of scope for v1; the schema reserves `exchangeRate?` on the transfer for a future release.

## 6. Credit card installment model

A purchase split into installments produces **one parent transaction** plus **N installment
records**, keeping the ledger and the invoice view consistent.

Example — BRL 1,200 purchase in 6 installments:

1. `CreditCard.availableLimit` decreases by `120000` (BRL 1,200).
2. One parent `Transaction` (type `expense`, amount `120000`, accountId = the card's
   representative account, `installmentId = null`) is created to record the full purchase.
3. Six `Installment` rows are created:

   | number | total | amount | dueDate |
   | --- | --- | --- | --- |
   | 1 | 6 | 20000 (BRL 200) | purchase month + 0 |
   | 2 | 6 | 20000 | +1 month |
   | … | 6 | … | … |
   | 6 | 6 | 20000 | +5 months |

4. Each installment is assigned to the `CreditCardInvoice` whose closing/due window contains its
   `dueDate` (invoices are computed from the card's `closingDay`/`dueDay`).
5. Each installment references the **original purchase (`transactionId`)**, its **`number`**,
   and **`totalInstallments`** — satisfying the traceability requirement.
6. `sum(installments.amount) == purchase.amount` is **validated** in the use case; a mismatch
   aborts the split.

Invoice payment: `PayInvoice` debits the linked payment account, credits
`CreditCard.availableLimit` by the paid amount, and marks the invoice (and its installments)
paid — all in one transaction.

## 7. Recurring transactions

- A `RecurringTransaction` is a template + `RecurrenceRule`.
- `GenerateDueOccurrences` is idempotent and safe to run repeatedly (app start, after sync,
  on a timer). For each active rule it materializes `Transaction` rows from
  `nextDueDate` up to the current date.
- **Duplicate prevention:** a generated transaction stores `recurrenceId` + a stable
  `occurrenceKey` (e.g. `rule.id:2026-09`); the generator skips any `occurrenceKey` that
  already exists, so re-running never double-creates entries.
- After generating, the rule's `lastGeneratedDate`/`nextDueDate` advance; generation and
  enqueuing share a database transaction.

## 8. Budgets

- A `Budget` binds a category to an `amount` for a calendar month.
- `spent` = sum of `expense` transactions in that category (including its subcategories) for the
  month, **including credit-card installments** whose `dueDate` falls in the month.
- Derived metrics: `remaining = amount - spent`, `percentUsed = spent / amount`.
- Thresholds (`70%`, `90%`, `100%`) are surfaced to the UI and to the insights engine as
  warnings.

## 9. Goals

- `progress = currentAmount / targetAmount`, `remaining = targetAmount - currentAmount`.
- Estimated completion is linearized: `remaining / averageMonthlyDeposit` (with an "on track /
  behind" status when a `targetDate` exists).

## 10. Financial calculation rules (normative)

1. **Never** use `double` for money. Always `int` minor units in `Money`.
2. Parsing user input (`"123,45"` / `"123.45"`) normalizes to minor units with explicit
   locale-aware parsing, rejecting more than the currency's decimal places.
3. **Rounding** for installment splits uses **largest-remainder** so the parts sum exactly to the
   total (e.g. `1200/7` → six parts of `171` and one of `174`, never a floating-point drift).
4. Currency-mismatched arithmetic throws `CurrencyMismatch` (a `ValidationFailure`).
5. All balance/ledger mutations run in a single DB transaction; there is no partial state.
6. Time is compared by date granularity (days/months) via `DateTime` normalized to UTC at
   midnight for date-only fields; recurring math uses calendar arithmetic, not fixed 30-day spans.
