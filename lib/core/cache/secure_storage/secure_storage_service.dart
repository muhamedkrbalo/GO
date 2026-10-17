import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// Stores auth tokens. Get it from the service locator (`sl<SecureStorageService>()`).
class SecureStorageService {
  SecureStorageService({FlutterSecureStorage? storage}) : _storage = storage ?? _defaultStorage;

  static const String _accessTokenKey = 'access_token';
  static const String _refreshTokenKey = 'refresh_token';
  static const String _tokenExpiresAtKey = 'token_expires_at';

  static const FlutterSecureStorage _defaultStorage = FlutterSecureStorage(
    aOptions: AndroidOptions(
      resetOnError: true,
    ),
    iOptions: IOSOptions(
      accessibility: KeychainAccessibility.first_unlock,
    ),
  );

  final FlutterSecureStorage _storage;

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
}
