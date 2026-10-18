import 'package:flutter/foundation.dart';

import '../cache/hive/hive_methods.dart';
import '../cache/secure_storage/secure_storage_service.dart';

enum AuthStatus { unknown, authenticated, unauthenticated }


class AuthSession extends ValueNotifier<AuthStatus> {
  AuthSession(this._secureStorage) : super(AuthStatus.unknown);

  final SecureStorageService _secureStorage;

  bool get isAuthenticated => value == AuthStatus.authenticated;

  Future<void> restore({
    Duration minSplashDuration = const Duration(seconds: 3),
  }) async {
    final (token, _) = await (
      _secureStorage.getAccessToken(),
      Future<void>.delayed(minSplashDuration),
    ).wait;
    value = (token == null || token.isEmpty) ? AuthStatus.unauthenticated : AuthStatus.authenticated;
  }

  Future<void> signIn({required String accessToken}) async {
    await _secureStorage.setAccessToken(accessToken);
    value = AuthStatus.authenticated;
  }


  Future<void> signOut() async {
    if (value == AuthStatus.unauthenticated) return;
    value = AuthStatus.unauthenticated;
    await _secureStorage.deleteAccessToken();
    await HiveMethods.deleteAuthEntity();
  }
}
