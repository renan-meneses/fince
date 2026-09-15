/// Keys for sensitive values stored in secure storage.
///
/// These are namespaced so that future values never collide.
abstract final class StorageKeys {
  static const String accessToken = 'auth.access_token';
  static const String refreshToken = 'auth.refresh_token';
  static const String biometricEnabled = 'security.biometric_enabled';
  static const String userId = 'auth.user_id';
}
