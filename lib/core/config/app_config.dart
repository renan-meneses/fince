import 'app_environment.dart';

/// Immutable runtime configuration resolved once at startup.
///
/// Secrets are never hard-coded here; sensitive values come from the platform
/// (e.g. secure storage, native config) or build-time injection.
class AppConfig {
  const AppConfig({
    required this.environment,
    required this.baseUrl,
    this.enableCrashlytics = false,
    this.enablePushNotifications = false,
    this.demoMode = false,
  });

  final AppEnvironment environment;

  /// HTTPS-only API root (see `docs/security.md`).
  final String baseUrl;

  final bool enableCrashlytics;
  final bool enablePushNotifications;

  /// Seeds the local DB with sample data on startup (demo/demo mode).
  final bool demoMode;

  bool get isProduction => environment == AppEnvironment.production;
  bool get isDevelopment => environment == AppEnvironment.development;

  factory AppConfig.demo() => const AppConfig(
        environment: AppEnvironment.development,
        baseUrl: 'https://demo-api.fince.app/v1',
        demoMode: true,
      );

  factory AppConfig.development() => const AppConfig(
        environment: AppEnvironment.development,
        baseUrl: 'https://dev-api.fince.app/v1',
      );

  factory AppConfig.staging() => const AppConfig(
        environment: AppEnvironment.staging,
        baseUrl: 'https://staging-api.fince.app/v1',
        enableCrashlytics: true,
      );

  factory AppConfig.production() => const AppConfig(
        environment: AppEnvironment.production,
        baseUrl: 'https://api.fince.app/v1',
        enableCrashlytics: true,
        enablePushNotifications: true,
      );
}
