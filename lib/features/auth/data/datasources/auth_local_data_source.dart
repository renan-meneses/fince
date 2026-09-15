import 'dart:convert';

import '../../../../core/constants/storage_keys.dart';
import '../../../../core/storage/secure_storage.dart';
import '../models/auth_tokens_model.dart';
import '../models/user_model.dart';

/// Local (secure) persistence for the auth session.
class AuthLocalDataSource {
  AuthLocalDataSource(this._storage);

  final SecureStorage _storage;

  Future<void> saveTokens(AuthTokensModel tokens) async {
    await _storage.write(StorageKeys.accessToken, tokens.accessToken);
    await _storage.write(StorageKeys.refreshToken, tokens.refreshToken);
  }

  Future<void> saveUser(UserModel user) =>
      _storage.write(StorageKeys.userProfile, jsonEncode(user.toJson()));

  Future<String?> readAccessToken() => _storage.read(StorageKeys.accessToken);

  Future<String?> readRefreshToken() => _storage.read(StorageKeys.refreshToken);

  Future<UserModel?> readUser() async {
    final raw = await _storage.read(StorageKeys.userProfile);
    if (raw == null) return null;
    return UserModel.fromJson(jsonDecode(raw) as Map<String, dynamic>);
  }

  Future<bool> readBiometricEnabled() async =>
      await _storage.read(StorageKeys.biometricEnabled) == 'true';

  Future<void> saveBiometricEnabled(bool enabled) =>
      _storage.write(StorageKeys.biometricEnabled, enabled.toString());

  Future<void> clear() async {
    await _storage.delete(StorageKeys.accessToken);
    await _storage.delete(StorageKeys.refreshToken);
    await _storage.delete(StorageKeys.userProfile);
    await _storage.delete(StorageKeys.userId);
  }
}
