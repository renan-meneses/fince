# Architecture

## 1. Overview & goals

Fince is built with **feature-first Clean Architecture** so that:

- **Business rules never live in widgets.** Use cases and entities are pure Dart with zero Flutter
  or framework dependencies.
- **The UI is a thin, reactive projection** of domain state driven by Cubits/BLoCs.
- **The app is backend-agnostic.** Domain defines repository interfaces; infrastructure adapters
  (Drift local source, Dio remote source) are swappable. The same app can target FastAPI, NestJS,
  Spring Boot, or .NET by implementing one contract.
- **The app is offline-first.** The local database is the single source of truth at runtime;
  the remote API is reached through a synchronization queue.

### Dependency rule

```
presentation  →  domain  ←  data
   (Cubit)      (use case)   (repository impl)
```

Arrows point *inward*. `domain` imports nothing from `data` or `presentation`. `data` implements
`domain` contracts. `presentation` depends only on `domain` abstractions (and, via DI, on `data`
implementations resolved at composition root time).

```
┌─────────────────────────────────────────────────────────────┐
│ presentation                                                 │
│   screens / widgets / cubits / blocs                        │
│                                                             │
│   depends on: domain (entities, use cases, repository ports)│
└──────────────▲──────────────────────────────▲───────────────┘
               │                              │
        ┌──────┴───────┐              ┌───────┴──────┐
        │    domain     │              │   DI (get_it)│ composition root
        │ entities, VOs │              │ routes (go_  │ wires concrete data
        │ use cases,    │              │  router)     │ impls to ports
        │ repo ports    │              └───────▲──────┘
        └──────▲───────┘                      │
               │                     ┌────────┴─────────┐
        ┌──────┴──────────────────┐  │ core (config,    │
        │          data           │  │ network, storage,│
        │ models (DTO), mappers,  │  │ theme, utils)    │
        │ local source (Drift),   │  └──────────────────┘
        │ remote source (Dio)     │
        └─────────────────────────┘
```

## 2. Feature-first structure

Each feature owns its `data` / `domain` / `presentation` slices. Features are independent modules
that communicate only through their `domain` layer (a feature may depend on another feature's
domain, never its widgets or data sources).

```
lib/
├── main.dart                       # bootstrap: DI, router, Firebase, runApp
├── app.dart                        # MaterialApp.router + theme wiring
│
├── core/
│   ├── config/
│   │   ├── app_config.dart         # base URL, env flags, build mode
│   │   └── app_environment.dart    # dev / staging / prod
│   ├── constants/
│   │   ├── app_constants.dart
│   │   └── storage_keys.dart
│   ├── errors/
│   │   ├── failure.dart            # sealed failure hierarchy
│   │   ├── exception_to_failure.dart
│   │   └── error_messages.dart     # user-facing messages
│   ├── network/
│   │   ├── dio_client.dart
│   │   ├── interceptors/auth_interceptor.dart
│   │   ├── interceptors/logging_interceptor.dart
│   │   ├── interceptors/connectivity_interceptor.dart
│   │   ├── api_client.dart         # typed Dio wrappers
│   │   └── network_info.dart
│   ├── storage/
│   │   ├── app_database.dart       # Drift database
│   │   ├── database_connection.dart
│   │   └── secure_storage.dart     # flutter_secure_storage wrapper
│   ├── theme/
│   │   ├── app_theme.dart
│   │   ├── design_tokens.dart      # colors, spacing, radius, typography
│   │   ├── dark_theme.dart
│   │   └── light_theme.dart
│   ├── utils/
│   │   ├── debouncer.dart
│   │   ├── date_utils.dart
│   │   ├── formatters.dart
│   │   └── validators.dart
│   └── widgets/
│       ├── balance_card.dart
│       ├── transaction_tile.dart
│       ├── category_progress.dart
│       ├── budget_progress_card.dart
│       ├── financial_summary_card.dart
│       ├── goal_progress_card.dart
│       ├── credit_card_widget.dart
│       ├── empty_state.dart
│       ├── error_view.dart
│       └── app_scaffold.dart
│
└── features/
    ├── auth/
    │   ├── data/
    │   │   ├── models/             # UserModel, AuthTokensModel (json/freezed)
    │   │   ├── datasources/auth_local_data_source.dart
    │   │   ├── datasources/auth_remote_data_source.dart
    │   │   └── repositories/auth_repository_impl.dart
    │   ├── domain/
    │   │   ├── entities/user.dart
    │   │   ├── entities/auth_tokens.dart
    │   │   ├── repositories/auth_repository.dart
    │   │   └── usecases/           # login, register, forgot_password, logout,
    │   │       ...                 #   biometric_login, get_profile, watch_session
    │   └── presentation/
    │       ├── cubit/auth_cubit.dart
    │       ├── cubit/auth_state.dart
    │       ├── screens/login_screen.dart
    │       ├── screens/register_screen.dart
    │       ├── screens/forgot_password_screen.dart
    │       └── widgets/
    │
    ├── dashboard/
    │   ├── data/                   # aggregate queries over other features' local sources
    │   ├── domain/
    │   │   ├── entities/financial_overview.dart
    │   │   ├── repositories/dashboard_repository.dart
    │   │   └── usecases/get_overview.dart
    │   └── presentation/
    │       ├── cubit/dashboard_cubit.dart
    │       ├── screens/dashboard_screen.dart
    │       └── widgets/            # income_vs_expense_chart, category_breakdown, ...
    │
    ├── accounts/
    │   ├── data/
    │   │   ├── models/account_model.dart
    │   │   ├── datasources/account_local_data_source.dart   # Drift DAO
    │   │   ├── datasources/account_remote_data_source.dart  # Dio
    │   │   └── repositories/account_repository_impl.dart
    │   ├── domain/
    │   │   ├── entities/account.dart
    │   │   ├── repositories/account_repository.dart
    │   │   └── usecases/           # get_accounts, watch_accounts, create, update,
    │   │       ...                 #   archive, transfer_between_accounts
    │   └── presentation/
    │       ├── cubit/              # accounts_cubit, account_form_cubit
    │       ├── screens/accounts_screen.dart
    │       ├── screens/account_form_screen.dart
    │       ├── screens/transfer_screen.dart
    │       └── widgets/account_tile.dart
    │
    ├── transactions/
    │   ├── data/
    │   ├── domain/
    │   │   ├── entities/transaction.dart
    │   │   ├── repositories/transaction_repository.dart
    │   │   └── usecases/           # get, watch, search, filter, create, update,
    │   │       ...                 #   delete, duplicate
    │   └── presentation/
    │       ├── cubit/              # transaction_list_cubit, transaction_form_cubit
    │       ├── screens/transactions_screen.dart
    │       ├── screens/transaction_form_screen.dart
    │       └── widgets/            # filters_sheet, transaction_tile (theme-bound)
    │
    ├── categories/
    │   ├── data/
    │   ├── domain/
    │   │   ├── entities/category.dart
    │   │   ├── repositories/category_repository.dart
    │   │   └── usecases/           # get_categories, create, update, delete, seed_defaults
    │   └── presentation/
    │       ├── cubit/categories_cubit.dart
    │       ├── screens/categories_screen.dart
    │       └── widgets/category_picker.dart
    │
    ├── credit_cards/
    │   ├── data/
    │   ├── domain/
    │   │   ├── entities/credit_card.dart
    │   │   ├── entities/credit_card_invoice.dart
    │   │   ├── entities/installment.dart
    │   │   ├── repositories/credit_card_repository.dart
    │   │   └── usecases/           # get_cards, create_card, register_purchase,
    │   │       ...                 #   split_into_installments, pay_invoice, get_invoices
    │   └── presentation/
    │       ├── cubit/
    │       ├── screens/credit_cards_screen.dart
    │       ├── screens/credit_card_detail_screen.dart
    │       ├── screens/invoice_screen.dart
    │       └── widgets/credit_card_widget.dart
    │
    ├── budgets/
    │   ├── data/
    │   ├── domain/
    │   │   ├── entities/budget.dart
    │   │   ├── repositories/budget_repository.dart
    │   │   └── usecases/           # get_monthly_budgets, create, update, delete,
    │   │       ...                 #   get_budget_performance
    │   └── presentation/
    │       ├── cubit/budgets_cubit.dart
    │       ├── screens/budgets_screen.dart
    │       └── widgets/budget_progress_card.dart
    │
    ├── goals/
    │   ├── data/
    │   ├── domain/
    │   │   ├── entities/financial_goal.dart
    │   │   ├── repositories/goal_repository.dart
    │   │   └── usecases/           # get_goals, create, update, delete, deposit
    │   └── presentation/
    │       ├── cubit/goals_cubit.dart
    │       ├── screens/goals_screen.dart
    │       └── widgets/goal_progress_card.dart
    │
    ├── reports/
    │   ├── data/
    │   ├── domain/
    │   │   ├── entities/           # monthly_report, cash_flow_point, category_breakdown, ...
    │   │   ├── repositories/report_repository.dart
    │   │   └── usecases/           # get_income_vs_expense, get_cash_flow, ...
    │   └── presentation/
    │       ├── cubit/reports_cubit.dart
    │       ├── screens/reports_screen.dart
    │       └── widgets/            # bar_chart, line_chart, donut_chart wrappers
    │
    ├── insights/
    │   ├── data/
    │   │   ├── datasources/insight_rules.dart           # deterministic rule engine
    │   │   └── repositories/insight_repository_impl.dart
    │   ├── domain/
    │   │   ├── entities/financial_insight.dart
    │   │   ├── repositories/financial_assistant_repository.dart  # future AI port
    │   │   └── usecases/generate_insights.dart
    │   └── presentation/
    │       ├── cubit/insights_cubit.dart
    │       ├── screens/insights_screen.dart
    │       └── widgets/insight_card.dart
    │
    ├── recurring_transactions/
    │   ├── data/
    │   ├── domain/
    │   │   ├── entities/recurring_transaction.dart
    │   │   ├── entities/recurrence_rule.dart
    │   │   ├── repositories/recurring_transaction_repository.dart
    │   │   └── usecases/           # create, update, delete, generate_due_occurrences
    │   └── presentation/
    │       ├── cubit/recurring_cubit.dart
    │       ├── screens/recurring_screen.dart
    │       └── widgets/
    │
    └── settings/
        ├── data/
        ├── domain/
        │   ├── entities/app_settings.dart
        │   └── repositories/settings_repository.dart
        └── presentation/
            ├── cubit/settings_cubit.dart
            ├── screens/settings_screen.dart
            ├── screens/profile_screen.dart
            └── screens/security_screen.dart
```

## 3. Domain layer (contracts)

Every feature's `domain/` contains:

- **entities/** — plain immutable Dart classes (via `freezed` for `copyWith`/equality).
- **repositories/** — abstract interfaces (ports) declaring the operations the app needs.
- **usecases/** — one class per user intent, orchestrating entities + repository ports and
  returning `Either<Failure, T>`-style results (see §9).

Example port:

```dart
abstract interface class TransactionRepository {
  Stream<List<Transaction>> watchAll(TransactionFilter filter);
  Future<List<Transaction>> getAll(TransactionFilter filter, {int limit, int offset});
  Future<Transaction> create(CreateTransactionParams params);
  Future<Transaction> update(Transaction t);
  Future<void> delete(String id);
  Future<Transaction> duplicate(String id);
}
```

Use cases are framework-free and unit-testable with fakes; repositories are mocked with
`mocktail` in BLoC tests.

## 4. Dependency injection (`get_it`)

`get_it` is the composition root. Registration is split per layer so tests can register fakes:

- `core/di/injection.dart` — registers singletons (database, dio, secure storage, router).
- each feature registers its own bindings (`registerAuthModule()`, `registerAccountsModule()`, …).

```dart
// illustrative
sl.registerLazySingleton<AppDatabase>(() => AppDatabase(sl()));
sl.registerLazySingleton<Dio>(() => buildDio(sl()));
sl.registerLazySingleton<TransactionRepository>(
  () => TransactionRepositoryImpl(sl(), sl(), sl()),
);
```

The UI never constructs dependencies by hand — it resolves Cubits through factories registered
in `get_it`, keeping widgets free of wiring logic.

## 5. Navigation (`go_router`)

- Typed, declarative routes with **redirect logic** for auth (unauthenticated → `/login`).
- Route guards check session state from `AuthCubit` (via a `refreshListenable`).
- Named routes mirror features: `/login`, `/dashboard`, `/accounts`, `/accounts/:id`,
  `/transactions/new`, `/credit-cards/:id/invoices/:invoiceId`, etc.

## 6. State management (Cubit/BLoC)

- **Cubits** for straightforward, single-responsibility screens (forms, lists).
- **BLoCs** where events stream in (search-as-you-type, sync engine, auth session).
- Immutable states via `freezed` (sealed unions for loading / data / error).
- **Offline-first hydration:** lists and dashboard derive from **Drift reactive streams**
  (`watch*` queries), so the UI updates automatically on local mutations and requires no manual
  re-fetch. Remote data is pulled through the sync pipeline, not directly into Cubits.
- `bloc_concurrency` prevents overlapping searches/syncs (e.g. `restartable` for search).

## 7. Data layer

Each repository implementation composes **two data sources**:

1. **Local (Drift)** — always-on source of truth, reactive.
2. **Remote (Dio)** — reached via the sync queue for writes and lazily for reads when online.

A repository:

- reads from local first (fast, offline);
- enqueues mutations for remote sync (never blocks the UI on network);
- maps Drift rows / JSON DTOs → domain entities through **mappers**.

## 8. Local persistence (Drift)

Drift is chosen over Isar because financial data is **relational**: accounts ↔ transactions,
credit cards ↔ invoices ↔ installments, budgets ↔ categories, plus a sync-queue table with
foreign keys and ad-hoc reporting aggregations (SUM/GROUP BY over time ranges). Drift provides:

- typed SQL with compile-time-checked queries,
- schema migrations,
- index declarations (see §15),
- transactions/atomic multi-table writes (required for transfers and installment splits),
- reactive `watch` streams that power offline-first UI.

All monetary columns are `INTEGER` (minor units). All primary keys are `TEXT` UUIDs.

## 9. Error handling

`core/errors/failure.dart` defines a sealed hierarchy:

```
Failure
 ├─ NetworkFailure
 ├─ AuthenticationFailure
 ├─ ValidationFailure
 ├─ DatabaseFailure
 └─ UnknownFailure
```

- Infrastructure exceptions (`DioException`, `SqliteException`, `FormatException`) are mapped
  to domain failures in `core/errors/exception_to_failure.dart`.
- Cubits expose a sealed state (`failure: ValidationFailure(...)`), and `core/widgets/error_view.dart`
  renders a localized, user-friendly message from `core/errors/error_messages.dart`.

## 10. Package manifest

| Package | Why it is required |
| --- | --- |
| `flutter_bloc`, `bloc`, `bloc_concurrency` | Deterministic, testable state management (Cubit/BLoC); event transformation for debounced search. |
| `get_it` | Lightweight service locator for the composition root; no codegen. |
| `go_router` | Official declarative router with auth redirect guards and typed routes. |
| `dio` | Interceptors (auth, logging, connectivity), cancellation, timeouts — required for a clean API layer. |
| `drift`, `drift_flutter`, `sqlite3_flutter_libs`, `path_provider`, `path` | SQLite persistence with typed queries, migrations, and atomic transactions. |
| `flutter_secure_storage` | Hardware-backed storage for tokens/biometric secrets (never plain `shared_preferences`). |
| `freezed`, `freezed_annotation` | Immutable entities/states with `copyWith`/equality; sealed unions for states. |
| `json_serializable`, `json_annotation` | JSON (de)serialization for DTOs and remote payloads. |
| `build_runner` (dev) | Codegen for freezed / json_serializable / drift. |
| `uuid` | Client-generated UUID primary keys (idempotent sync, no incremental local IDs). |
| `fl_chart` | Bar/line/donut charts for dashboard and reports. |
| `intl`, `flutter_localizations` | Currency/date/number formatting and localization. |
| `local_auth` | Biometric login (fingerprint/face). |
| `connectivity_plus` | Drives the sync queue drain on connectivity change. |
| `firebase_core`, `firebase_crashlytics`, `firebase_messaging` | Crash monitoring and push notifications. |
| `flutter_test` (dev) | Unit/widget tests. |
| `bloc_test` (dev) | Cubit/BLoC tests. |
| `mocktail` (dev) | Mocking repository ports and data sources. |
| `integration_test` (SDK, dev) | On-device end-to-end tests. |

Deliberately **excluded**: state-management alternatives, a second DI framework, a decimal
package (integer minor units suffice), an HTTP client wrapper on top of Dio, and charting beyond
`fl_chart` — each would be an unnecessary dependency.

## 11. Design system

Centralized in `core/theme/design_tokens.dart`:

- **Typography** — text scale (display/large/title/body/caption) mapped from a single
  `TextTheme` per theme.
- **Spacing** — a fixed 4-px grid (`Spacing.xs..xxl`).
- **Border radius** — `Radius.sm/md/lg/xl`.
- **Shadows** — elevation presets for cards/sheets.
- **Icons** — Material icons referenced through a token map (so a brand/icon swap is one change).
- **Color tokens** — semantic tokens (`surface`, `onSurface`, `primary`, `success`, `danger`,
  `warning`, `info`) resolved by `LightTheme`/`DarkTheme`.

Screens never hard-code colors, paddings, or font sizes; they consume tokens and the reusable
widgets in `core/widgets`.

## 12. Observability

- `firebase_crashlytics` records fatal/non-fatal app errors and is fed by an
  `AppErrorHandler` in `FlutterError.onError` + `PlatformDispatcher.onError`.
- A `RemoteLog` port (optional) forwards structured, redacted logs; default is a no-op.
- **Redaction rule:** passwords, tokens, full account numbers, and financial totals are never
  sent to any monitoring service (see `docs/security.md`).

## 13. Performance strategy

- **Reactive queries** — lists are Drift `watch` streams; no rebuild storms from manual refresh.
- **Pagination** — transaction list uses keyset (cursor) pagination.
- **Indexes** — on `transactions(account_id, date)`, `transactions(category_id, date)`,
  `installments(invoice_id)`, `sync_operations(status)`.
- **Debounced search** — `Debouncer` + `bloc_concurrency.restartable`.
- **Chart rendering** — pre-aggregated query results (not per-row parsing) feed `fl_chart`;
  charts are wrapped in `RepaintBoundary` and only rebuild when data identity changes.

## 14. Testing strategy

| Layer | Tool | Focus |
| --- | --- | --- |
| Unit | `flutter_test` | `Money` arithmetic, recurrence math, installment splitting, insight rules, mappers. |
| Repository | `mocktail` + in-memory Drift | local data source behavior, atomic transfer writes, sync enqueue. |
| BLoC | `bloc_test` + `mocktail` | state transitions for create/update/filter flows. |
| Widget | `flutter_test` | `BalanceCard`, `TransactionTile`, `BudgetProgressCard`, form validation. |
| Integration | `integration_test` | end-to-end create account → transaction → dashboard reflects it. |

Priority coverage: transaction creation, transfers, credit-card installments, budgets,
recurring generation, and financial calculations (see `docs/domain-model.md`).

## 15. Build & run

```bash
flutter pub get
dart run build_runner build --delete-conflicting-outputs   # after schema/model changes
flutter analyze
flutter test
flutter run
```

Android: `flutter build appbundle` / `flutter build apk`. iOS: `flutter build ipa` (requires
macOS/Xcode signing).

## 16. Implementation roadmap

Work proceeds in the order of section 27 of the specification. Each task is independently
testable and lands as its own commit.

| # | Task | Commit scope | Verification |
| --- | --- | --- | --- |
| 1 | Project setup | `feat: initialize flutter project architecture` | `flutter analyze` + `flutter test` green on skeleton. |
| 2 | Architecture & deps | `feat: wire clean architecture core and dependencies` | DI resolves; router builds; sample cubit test. |
| 3 | Design system | `feat: add application design system` | Theme golden/widget tests. |
| 4 | Authentication | `feat: implement authentication` | Auth cubit + repository tests (JWT/OAuth2/Firebase ports). |
| 5 | Local database | `feat: add drift database schema` | Drift migration + DAO tests. |
| 6 | Accounts | `feat: implement account management` | Account CRUD + transfer tests. |
| 7 | Categories | `feat: implement categories with defaults` | Seed + CRUD tests. |
| 8 | Transactions | `feat: implement transaction management` | Create/filter/duplicate tests. |
| 9 | Dashboard | `feat: add financial dashboard` | Overview calculation tests. |
| 10 | Credit cards | `feat: add credit card installment support` | Installment split tests. |
| 11 | Recurring transactions | `feat: implement recurring transactions` | Generation + dedup tests. |
| 12 | Budgets | `feat: implement budget tracking` | Budget performance tests. |
| 13 | Financial goals | `feat: implement financial goals` | Goal progress/deposit tests. |
| 14 | Reports | `feat: implement financial reports` | Aggregation + chart data tests. |
| 15 | Insights | `feat: implement financial insights` | Rule engine tests. |
| 16 | Offline sync | `feat: implement offline sync queue` | Idempotency + retry tests. |
| 17 | Tests | `test: add integration and coverage tests` | `flutter test --coverage`. |
| 18 | Documentation | `docs: document application architecture` | Docs reviewed against code. |
