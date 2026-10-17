import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_hr_erb/core/auth/auth_session.dart';
import 'package:flutter_hr_erb/core/cache/secure_storage/secure_storage_service.dart';
import 'package:flutter_hr_erb/core/routes/app_routers.dart';
import 'package:flutter_hr_erb/core/services/service_locator.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';

class _FakeSecureStorage extends SecureStorageService {
  String? token;
  int deleteCalls = 0;

  @override
  Future<String?> getAccessToken() async => token;

  @override
  Future<void> setAccessToken(String token) async => this.token = token;

  @override
  Future<void> deleteAccessToken() async {
    deleteCalls++;
    token = null;
  }
}

void main() {
  late Directory hiveDir;
  late _FakeSecureStorage storage;
  late AuthSession session;

  setUpAll(() async {
    hiveDir = await Directory.systemTemp.createTemp('hive_test');
    Hive.init(hiveDir.path);
    await Hive.openBox('app');

    storage = _FakeSecureStorage();
    session = AuthSession(storage);
    sl.registerSingleton<AuthSession>(session);
  });

  tearDownAll(() async {
    await Hive.close();
    await hiveDir.delete(recursive: true);
  });

  group('AuthSession', () {
    test('restore without a token → unauthenticated', () async {
      storage.token = null;
      await session.restore();
      expect(session.value, AuthStatus.unauthenticated);
    });

    test('signIn → authenticated', () async {
      await session.signIn(accessToken: 'token');
      expect(session.value, AuthStatus.authenticated);
      expect(storage.token, 'token');
    });

    test('concurrent signOut (several 401s) clears the session once', () async {
      storage.deleteCalls = 0;
      await session.signIn(accessToken: 'token');

      await Future.wait([session.signOut(), session.signOut(), session.signOut()]);

      expect(session.value, AuthStatus.unauthenticated);
      expect(storage.deleteCalls, 1);
    });
  });

  testWidgets('router redirects on auth status changes', (tester) async {
    session.value = AuthStatus.unknown;
    await tester.pumpWidget(MaterialApp.router(routerConfig: AppRouters.router));
    await tester.pumpAndSettle();
    expect(find.text('Splash Screen'), findsOneWidget);

    session.value = AuthStatus.unauthenticated;
    await tester.pumpAndSettle();
    expect(find.text('Login Screen'), findsOneWidget);

    session.value = AuthStatus.authenticated;
    await tester.pumpAndSettle();
    expect(find.text('Home Screen'), findsOneWidget);

    // e.g. a 401 from the interceptor
    session.value = AuthStatus.unauthenticated;
    await tester.pumpAndSettle();
    expect(find.text('Login Screen'), findsOneWidget);
  });
}
