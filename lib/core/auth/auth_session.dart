import 'package:flutter/foundation.dart';

import '../cache/hive/hive_methods.dart';
import '../cache/secure_storage/secure_storage_service.dart';

enum AuthStatus { unknown, authenticated, unauthenticated }

/// App-wide login state.
///
/// The router listens to it (`refreshListenable`) and redirects on every change,
/// so nothing else should navigate because of auth: call [signIn] after a
/// successful login and [signOut] on logout or 401 — the router does the rest.
class AuthSession extends ValueNotifier<AuthStatus> {
  AuthSession(this._secureStorage) : super(AuthStatus.unknown);

  final SecureStorageService _secureStorage;

  bool get isAuthenticated => value == AuthStatus.authenticated;

  /// Resolves the initial status from the stored token. Called once at startup;
  /// the splash screen is shown while the status is [AuthStatus.unknown].
  Future<void> restore() async {
    final token = await _secureStorage.getAccessToken();
    value = (token == null || token.isEmpty) ? AuthStatus.unauthenticated : AuthStatus.authenticated;
  }

  Future<void> signIn({required String accessToken}) async {
    await _secureStorage.setAccessToken(accessToken);
    value = AuthStatus.authenticated;
  }

  /// Safe to call repeatedly (e.g. several requests failing with 401 at once):
  /// only the first call clears the session and triggers a redirect.
  Future<void> signOut() async {
    if (value == AuthStatus.unauthenticated) return;
    value = AuthStatus.unauthenticated;
    await _secureStorage.deleteAccessToken();
    await HiveMethods.deleteAuthEntity();
  }
}
