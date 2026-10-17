import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageService {
  SecureStorageService._();

  static final SecureStorageService _instance = SecureStorageService._();
  static SecureStorageService get instance => _instance;

  static const String _accessTokenKey = 'access_token';
  static const String _refreshTokenKey = 'refresh_token';
  static const String _tokenExpiresAtKey = 'token_expires_at';
  static const String _migrationCompletedKey = 'migration_completed';

  final FlutterSecureStorage _storage = const FlutterSecureStorage(
    aOptions: AndroidOptions(
      resetOnError: true,
    ),
    iOptions: IOSOptions(
      accessibility: KeychainAccessibility.first_unlock,
    ),
  );

  Future<String?> getAccessToken() async {
    try {
      return await _storage.read(key: _accessTokenKey);
    } catch (e) {
      debugPrint('SecureStorage: Error reading access token: $e');
      return null;
    }
  }

  Future<void> setAccessToken(String token) async {
    try {
      await _storage.write(key: _accessTokenKey, value: token);
    } catch (e) {
      debugPrint('SecureStorage: Error writing access token: $e');
    }
  }

  Future<void> deleteAccessToken() async {
    try {
      await _storage.delete(key: _accessTokenKey);
    } catch (e) {
      debugPrint('SecureStorage: Error deleting access token: $e');
    }
  }

  Future<String?> getRefreshToken() async {
    try {
      return await _storage.read(key: _refreshTokenKey);
    } catch (e) {
      debugPrint('SecureStorage: Error reading refresh token: $e');
      return null;
    }
  }

  Future<void> setRefreshToken(String token) async {
    try {
      await _storage.write(key: _refreshTokenKey, value: token);
    } catch (e) {
      debugPrint('SecureStorage: Error writing refresh token: $e');
    }
  }

  Future<void> deleteRefreshToken() async {
    try {
      await _storage.delete(key: _refreshTokenKey);
    } catch (e) {
      debugPrint('SecureStorage: Error deleting refresh token: $e');
    }
  }

  Future<String?> getTokenExpiresAt() async {
    try {
      return await _storage.read(key: _tokenExpiresAtKey);
    } catch (e) {
      debugPrint('SecureStorage: Error reading token expiry: $e');
      return null;
    }
  }

  Future<void> setTokenExpiresAt(String expiresAt) async {
    try {
      await _storage.write(key: _tokenExpiresAtKey, value: expiresAt);
    } catch (e) {
      debugPrint('SecureStorage: Error writing token expiry: $e');
    }
  }

  Future<void> deleteTokenExpiresAt() async {
    try {
      await _storage.delete(key: _tokenExpiresAtKey);
    } catch (e) {
      debugPrint('SecureStorage: Error deleting token expiry: $e');
    }
  }

  Future<void> deleteAllTokens() async {
    await Future.wait([
      deleteAccessToken(),
      deleteRefreshToken(),
      deleteTokenExpiresAt(),
    ]);
  }

  Future<bool> isMigrationCompleted() async {
    try {
      final value = await _storage.read(key: _migrationCompletedKey);
      return value == 'true';
    } catch (e) {
      return false;
    }
  }

  Future<void> setMigrationCompleted() async {
    try {
      await _storage.write(key: _migrationCompletedKey, value: 'true');
    } catch (e) {
      debugPrint('SecureStorage: Error setting migration flag: $e');
    }
  }
}
