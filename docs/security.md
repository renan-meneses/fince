# Security

## 1. Token storage

- Access + refresh tokens are stored only in **`flutter_secure_storage`** (Keychain on iOS,
  EncryptedSharedPreferences/Keystore on Android) — never in plain `shared_preferences`, files,
  logs, or Drift.
- A single `SecureStorage` wrapper (`core/storage/secure_storage.dart`) is the only code path
  that reads/writes secrets.

## 2. Passwords

- Passwords are used transiently for login/register and are **never persisted**.
- They are never logged, never placed in analytics, never sent to monitoring.

## 3. Transport

- `DioClient` is configured **HTTPS-only**; non-HTTPS hosts are rejected in staging/prod builds.
- Certificate pinning is a configured (optional) hardening step per environment.

## 4. Session lifecycle

- Short-lived access tokens + refresh token rotation.
- An `AuthInterceptor` attaches the token and, on `401`, attempts a single refresh; a second
  failure forces logout.
- **Automatic session expiration:** an inactivity timer (configurable, default 15 min) locks the
  app and requires re-auth or biometric unlock.

## 5. Biometrics

- `local_auth` gates unlock; the biometric check never replaces the server session — it only
  unlocks a locally-stored (Keystore/Keychain-backed) session secret.
- Biometric availability is probed before enabling the toggle in settings.

## 6. Sensitive information masking

- Credit card numbers (when shown) are masked (`•••• •••• •••• 1234`).
- Balances can be globally hidden with a "privacy mode" toggle; tapping reveals.
- Account numbers/limits are truncated in lists and only fully shown behind explicit reveal.

## 7. Logging redaction

A redaction filter runs before any log/analytics/crash event leaves the device. It strips:

- passwords,
- authentication tokens,
- full account numbers / card PANs,
- complete financial account info and balance totals (only category/type/status metadata is
  allowed),
- PII such as full name, email domain beyond a masked form, and document numbers.

`FlutterError`/`PlatformDispatcher` handlers route through the same redactor before Crashlytics.

## 8. LGPD (Brazilian data protection) readiness

- **Data minimization:** only fields required by the domain are collected.
- **Purpose:** personal data is used solely to provide the financial-management service.
- **User rights hooks:** the settings module exposes export-my-data and delete-my-account entry
  points backed by repository ports, so LGPD subject requests map to backend endpoints.
- **Consent:** biometric/notification opt-ins are explicit and revocable.
- **Storage location & deletion:** data lives locally (Drift) and on the backend; the delete
  flow purges local data and requests server erasure.
- **No cross-service tracking** of financial data.

## 9. Monitoring privacy

- Crashlytics/remote logs receive **redacted, non-sensitive** events only.
- Financial totals, tokens, and PII are blocked by the redactor (§7) before any monitoring
  service is called.
