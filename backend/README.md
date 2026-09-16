# Fince API (backend)

FastAPI + SQLAlchemy + SQLite backend implementing the contract in
[`../docs/api-contract.md`](../docs/api-contract.md).

## Run

```bash
cd backend
python3 -m venv .venv
source .venv/bin/activate
pip install -r requirements.txt
uvicorn app.main:app --reload --port 8000
```

Interactive docs: <http://127.0.0.1:8000/docs>

## Demo credentials

On first startup the DB is seeded with default categories and a demo user:

- **email:** `demo@fince.app`
- **password:** `demo123`

## Endpoints (prefix `/v1`)

| Area | Endpoints |
| --- | --- |
| Auth | `POST /auth/register`, `POST /auth/login`, `POST /auth/refresh`, `POST /auth/forgot-password`, `POST /auth/reset-password`, `POST /auth/logout`, `GET/PATCH /users/me` |
| Accounts | `GET/POST /accounts`, `GET/PUT/DELETE /accounts/{id}`, `POST /accounts/transfers` |
| Transactions | `GET/POST /transactions`, `GET/PUT/DELETE /transactions/{id}`, `POST /transactions/{id}/duplicate` |
| Categories | `GET/POST /categories`, `PUT/DELETE /categories/{id}` |
| Reports | `GET /reports/monthly`, `GET /reports/cash-flow`, `GET /reports/by-category`, `GET /reports/by-account` |
| Sync | `POST /sync` (idempotent batch replay) |

Conventions: money is integer **minor units** (`{ "amount": 12345, "currency": "BRL" }`),
errors are RFC 9457 Problem Details, lists are cursor-paginated (`items` + `nextCursor`),
and mutations accept an `Idempotency-Key` header (enforced for `POST /sync`).

## Connecting the mobile app

Point the app's `baseUrl` at this server (e.g. `http://10.0.2.2:8000/v1` on the Android
emulator) and use the demo credentials. The app remains offline-first: local writes are
replayed through `POST /sync`.
