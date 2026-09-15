# Fince — Personal Finance Manager

A production-ready **Personal Finance Management** mobile application built with **Flutter**.
Fince helps users control income, expenses, accounts, credit cards, budgets, financial goals,
and recurring transactions through a clean, offline-first, fintech-style interface.

> **Status:** ✅ All 18 roadmap tasks implemented — Clean Architecture core, design system,
> auth, Drift database, accounts, categories, transactions, dashboard, credit cards, recurring
> transactions, budgets, goals, reports, insights, offline sync, tests, and documentation.
> See the [roadmap](docs/architecture.md#17-implementation-roadmap) for per-task status.

## Highlights

- **Feature-first Clean Architecture** — strict layering (`domain` / `data` / `presentation`).
- **Offline-first** — Drift (SQLite) is the source of truth; a sync queue replays mutations
  to any remote backend when connectivity returns.
- **Exact money math** — a `Money` value object stores integer minor units (BRL 123.45 → `12345`),
  eliminating floating-point rounding errors.
- **Deterministic financial insights** — rule-based insights behind a repository abstraction that
  is ready for a future AI assistant.
- **Backend-agnostic** — repository interfaces + a documented REST contract (FastAPI / NestJS /
  Spring Boot / .NET can all implement it).
- **Full test pyramid** — unit, BLoC, repository, widget, and integration tests.

## Tech stack

| Concern | Choice |
| --- | --- |
| Framework | Flutter (stable) / Dart |
| State management | BLoC / Cubit (`flutter_bloc`) |
| DI | `get_it` |
| Navigation | `go_router` |
| Networking | `dio` |
| Local persistence | `drift` (SQLite) |
| Secure storage | `flutter_secure_storage` |
| Immutable models/states | `freezed` |
| Serialization | `json_serializable` + `build_runner` |
| Charts | `fl_chart` |
| Formatting | `intl` |
| Push notifications | `firebase_messaging` |
| Crash monitoring | `firebase_crashlytics` |
| Biometrics | `local_auth` |

The full, justified dependency list is in
[`docs/architecture.md`](docs/architecture.md#10-package-manifest).

> **Note on `bloc_test`:** this Flutter SDK pins `test_api 0.7.11`, which forces the `test`
> package to `1.31.0` and `analyzer <13` — incompatible with the current `drift_dev`/`build_runner`
> codegen (which require `analyzer >=13`). Cubits/BLoCs are therefore tested with `flutter_test` +
> `mocktail` directly (functionally equivalent to `blocTest`), and `bloc_test` is intentionally
> omitted. See `pubspec.yaml` for the full dependency set.

## Testing

- **51 tests** across unit (Money, installment split), repository (transfers, transactions,
  credit-card installments, budgets, recurring generation, dashboard, reports, sync idempotency),
  Cubit (auth, transactions), and widget (design system, app shell) layers.
- **Integration test** in `integration_test/app_test.dart` (run on a device/emulator).

```bash
flutter test                 # unit + widget tests
flutter test --coverage      # with coverage report
flutter test integration_test -d <device>   # end-to-end (device required)
```

## Documentation

| Doc | Contents |
| --- | --- |
| [`docs/architecture.md`](docs/architecture.md) | Layering, folder structure, DI, navigation, state, dependencies, roadmap |
| [`docs/domain-model.md`](docs/domain-model.md) | Entities, value objects, money math, transfers, installments, recurrence |
| [`docs/api-contract.md`](docs/api-contract.md) | REST conventions and request/response DTOs |
| [`docs/offline-sync.md`](docs/offline-sync.md) | Sync queue, idempotency, conflict handling |
| [`docs/security.md`](docs/security.md) | Token storage, biometrics, masking, LGPD, logging rules |

## Running the project

```bash
# 1. Install dependencies
flutter pub get

# 2. Generate code (freezed / json_serializable / drift)
dart run build_runner build

# 3. Analyze & test
flutter analyze
flutter test

# 4. Run on a device/emulator
flutter run
```

## Demo mode

Run the app with pre-seeded sample data and a mock login (no backend needed):

```bash
flutter run -t lib/main_demo.dart
```

Log in with **email:** `demo@fince.app` · **password:** `demo123`. The demo database is
seeded with 3 accounts, 15 categories, 13 transactions (income/expenses/transfer), a credit
card with a 6-installment purchase, 3 budgets, 2 goals, and 3 recurring transactions.

Build instructions (Android/iOS) are in
[`docs/architecture.md`](docs/architecture.md#16-testing-strategy).

## License

Proprietary — internal project.
