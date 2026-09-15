/// Application-wide constants.
abstract final class AppConstants {
  static const String appName = 'Fince';

  static const String defaultLocale = 'pt_BR';
  static const String defaultCurrency = 'BRL';

  /// Inactivity window before the session is considered expired.
  static const Duration sessionTimeout = Duration(minutes: 15);

  /// Default page size for paginated local/remote lists.
  static const int defaultPageSize = 50;

  /// Maximum characters for transaction descriptions.
  static const int maxDescriptionLength = 140;
}
