# API Contract

The mobile app never talks to a specific backend. This document is the **stable contract** that
any backend (FastAPI, NestJS, Spring Boot, .NET) may implement.

## 1. Conventions

| Aspect | Convention |
| --- | --- |
| Base URL | configured per environment; always HTTPS in staging/prod |
| Content type | `application/json` |
| Versioning | URL prefix `/v1` |
| Auth | `Authorization: Bearer <accessToken>` (JWT). Refresh via `POST /v1/auth/refresh`. |
| Idempotency | mutating requests carry `Idempotency-Key: <uuid>`. Replayed requests with the same key return the original result instead of duplicating. |
| Pagination | cursor-based: `?limit=50&cursor=<opaque>` → `{ "items": [], "nextCursor": "..." \| null }`. |
| Errors | RFC 9457 Problem Details (below). |
| Money | `{ "amount": 12345, "currency": "BRL" }` — `amount` is **integer minor units**. |
| Timestamps | ISO 8601 UTC, e.g. `2026-09-15T12:00:00Z`. |
| IDs | string UUIDs, client-generated for offline-first entities. |

### Error shape (RFC 9457)

```json
{
  "type": "https://api.fince.app/errors/validation",
  "title": "Validation failed",
  "status": 422,
  "detail": "amount must be greater than zero",
  "instance": "/v1/transactions",
  "errors": { "amount": ["must be greater than zero"] }
}
```

Status codes distinguish: `400` malformed input, `401` unauthenticated, `403` forbidden,
`404` not found, `409` conflict (e.g. duplicate idempotency), `422` validation, `500` server
error.

## 2. Authentication

### `POST /v1/auth/register`
Request:
```json
{ "email": "user@example.com", "password": "s3cret!", "name": "Ada" }
```
Response `201`:
```json
{ "user": { "id": "uuid", "email": "user@example.com", "name": "Ada", "currency": "BRL" },
  "tokens": { "accessToken": "jwt", "refreshToken": "jwt", "expiresIn": 900 } }
```

### `POST /v1/auth/login`
Request: `{ "email": "...", "password": "..." }` → Response `200` (same shape as register).

### `POST /v1/auth/refresh`
Request: `{ "refreshToken": "jwt" }` → Response `200` (new token pair).

### `POST /v1/auth/forgot-password`
Request: `{ "email": "..." }` → `202` (always, to avoid account enumeration).

### `POST /v1/auth/reset-password`
Request: `{ "token": "...", "newPassword": "..." }` → `204`.

### `POST /v1/auth/logout`
`204`; server revokes the refresh token.

### `GET /v1/users/me` / `PATCH /v1/users/me`
Returns / updates the profile. `PATCH` body: `{ "name"?, "currency"?, "locale"? }`.

> **Future authn:** the `AuthRepository` port abstracts these endpoints so a backend can swap
> password auth for OAuth2 (`POST /v1/auth/oauth/{provider}`) or Firebase Auth (verified ID
> token) without touching the app.

## 3. Accounts

### `GET /v1/accounts`
Response `200`:
```json
{ "items": [
    { "id": "uuid", "name": "Checking", "type": "checking",
      "currentBalance": { "amount": 500000, "currency": "BRL" },
      "initialBalance": { "amount": 0, "currency": "BRL" },
      "currency": "BRL", "institution": "Bank X", "color": "#1B5E20",
      "icon": "account_balance", "createdAt": "2026-09-01T00:00:00Z", "isActive": true }
  ], "nextCursor": null }
```

### `POST /v1/accounts`
Request: `{ "name", "type", "initialBalance", "currency", "institution"?, "color"?, "icon"? }`
→ `201` (created account). `Idempotency-Key` required.

### `GET /v1/accounts/{id}` / `PUT /v1/accounts/{id}` / `DELETE /v1/accounts/{id}`
`PUT` full replace; `DELETE` soft-deletes (sets `isActive=false`).

### `POST /v1/accounts/transfers`
Request:
```json
{ "fromAccountId": "uuid", "toAccountId": "uuid",
  "amount": { "amount": 20000, "currency": "BRL" },
  "date": "2026-09-15T00:00:00Z", "description": "Transfer", "notes": "" }
```
Response `201`: the transfer `Transaction` (type `transfer`). Server must debit/credit atomically
and preserve the net-worth invariant.

## 4. Transactions

### `GET /v1/transactions`
Query params: `accountId`, `categoryId`, `type` (`income|expense|transfer`),
`from`/`to` (dates), `minAmount`/`maxAmount`, `status`, `q` (description search),
`sort` (`date:asc|date:desc|amount:asc|amount:desc`), `limit`, `cursor`.

Response `200`:
```json
{ "items": [
    { "id": "uuid", "description": "Groceries", "amount": { "amount": 12045, "currency": "BRL" },
      "type": "expense", "accountId": "uuid", "transferAccountId": null,
      "categoryId": "uuid", "subcategoryId": null, "date": "2026-09-14T00:00:00Z",
      "paymentStatus": "paid", "notes": null, "tags": ["food"],
      "recurrenceId": null, "installmentId": null,
      "createdAt": "2026-09-14T10:00:00Z", "updatedAt": "2026-09-14T10:00:00Z" }
  ], "nextCursor": "..." }
```

### `POST /v1/transactions`
Request mirrors the transaction DTO (minus `id`, `createdAt`, `updatedAt`). `201`.

### `GET /v1/transactions/{id}` / `PUT /v1/transactions/{id}` / `DELETE /v1/transactions/{id}`
`PUT` full replace (use `PATCH` in a later contract rev for partial edits).

### `POST /v1/transactions/{id}/duplicate`
`201` — returns a copy with a new id, cleared timestamps, and `paymentStatus=pending`.

## 5. Categories

- `GET /v1/categories` → `{ "items": [ { "id", "name", "type": "expense|income", "icon", "color", "isDefault", "parentId" } ], ... }`
- `POST /v1/categories`, `PUT /v1/categories/{id}`, `DELETE /v1/categories/{id}`
  (default categories are not deletable; custom ones are).

## 6. Credit cards

### `GET /v1/credit-cards` / `POST /v1/credit-cards`
Card DTO: `{ "id", "name", "brand", "creditLimit": Money, "availableLimit": Money,
"closingDay", "dueDay", "linkedAccountId", "isActive" }`.

### `POST /v1/credit-cards/{id}/purchases`
Request:
```json
{ "description": "Phone", "amount": { "amount": 120000, "currency": "BRL" },
  "installments": 6, "categoryId": "uuid", "date": "2026-09-10T00:00:00Z" }
```
Response `201`: `{ "transaction": {...}, "installments": [ { "id", "transactionId", "number", "totalInstallments", "amount": Money, "dueDate", "status" } ] }`.
Server creates the parent transaction + N installments atomically and validates
`sum(installments) == purchase amount`.

### `GET /v1/credit-cards/{id}/invoices`
Response `200`: `{ "items": [ { "id", "creditCardId", "periodStart", "periodEnd", "closingDate", "dueDate", "totalAmount": Money, "paidAmount": Money, "status" } ], ... }`.

### `POST /v1/credit-cards/{id}/invoices/{invoiceId}/pay`
Request: `{ "accountId": "uuid" }` → `200` (invoice marked paid, card limit released).

## 7. Budgets

- `GET /v1/budgets?month=2026-09` → `{ "items": [ { "id", "categoryId", "amount": Money, "month": "2026-09", "spent": Money, "remaining": Money, "percentUsed": 0.87 } ], ... }`
  (`spent`/`remaining`/`percentUsed` computed server-side).
- `POST /v1/budgets`, `PUT /v1/budgets/{id}`, `DELETE /v1/budgets/{id}`.

## 8. Goals

- `GET /v1/goals` → `{ "items": [ { "id", "name", "targetAmount": Money, "currentAmount": Money, "targetDate": "...", "description": "...", "status": "active", "progress": 0.42 } ], ... }`
- `POST /v1/goals`, `PUT /v1/goals/{id}`, `DELETE /v1/goals/{id}`,
  `POST /v1/goals/{id}/deposit` (`{ "amount": Money }`).

## 9. Recurring transactions

- `GET /v1/recurring-transactions` → template DTO + `rule: { "frequency", "interval", "dayOfMonth", "daysOfWeek" }`, `startDate`, `endDate`, `nextDueDate`.
- `POST /v1/recurring-transactions`, `PUT /v1/recurring-transactions/{id}`,
  `DELETE /v1/recurring-transactions/{id}`.

## 10. Reports

- `GET /v1/reports/monthly?month=2026-09` → income, expenses, result, variation vs previous month.
- `GET /v1/reports/cash-flow?from=&to=` → `[ { "period": "2026-09", "income": Money, "expense": Money } ]`.
- `GET /v1/reports/by-category?from=&to=` → `[ { "categoryId", "name", "total": Money, "percent": 0.18 } ]`.
- `GET /v1/reports/by-account?from=&to=` → `[ { "accountId", "name", "total": Money } ]`.
- `GET /v1/reports/net-worth?from=&to=` → `[ { "date": "...", "total": Money } ]`.
- `GET /v1/reports/budget-performance?month=2026-09` → budget list with `percentUsed`.

## 11. Insights

`GET /v1/insights?period=2026-09` → `{ "items": [ { "id", "type", "title", "message", "severity", "period" } ] }`.
(v1 insights are computed client-side by the deterministic rule engine; this endpoint exists so
a server-side/AI implementation can later replace the client rules without UI changes.)

## 12. Synchronization

### `POST /v1/sync`
Batch replay of queued operations (one request can carry many ops; each is idempotent via its
`Idempotency-Key`).

Request:
```json
{ "operations": [
    { "idempotencyKey": "uuid", "entityType": "transaction", "operation": "create",
      "entityId": "uuid", "payload": { "...": "entity DTO" }, "timestamp": "2026-09-15T12:00:00Z" }
  ] }
```
Response `200`:
```json
{ "results": [
    { "idempotencyKey": "uuid", "status": "synced", "entityId": "uuid" },
    { "idempotencyKey": "uuid", "status": "failed", "reason": "validation", "message": "..." }
  ] }
```

The local-first write path (create/update/delete against the local DB + enqueue) means the app
works offline and the backend reconciles on replay. Full semantics are in
[`offline-sync.md`](offline-sync.md).
