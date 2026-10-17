import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class HiveMethods {
  static Box get _box {
    try {
      final box = Hive.box('app');
      if (!box.isOpen) {
        throw HiveError('Hive box is not open');
      }
      return box;
    } catch (e) {
      rethrow;
    }
  }

  //! Language Methods
  /// Single source of truth for the app language: read at startup
  /// (EasyLocalization.startLocale) and by the API interceptor (Accept-Language).
  /// Change it only through `context.setAppLanguage` so the UI stays in sync.
  static String getLang() {
    return _box.get('lang', defaultValue: 'en');
  }

  static void updateLang(Locale locale) {
    _box.put('lang', locale.languageCode);
  }

  //! Country Methods
  static String? getCountry() {
    return _box.get('country');
  }

  static void updateCountry(String country) {
    _box.put('country', country);
  }

  static void deleteCountry() {
    _box.delete('country');
  }

  //! First Time Methods
  static bool isFirstTime() {
    return _box.get('isFirstTime', defaultValue: true);
  }

  static void updateFirstTime() {
    _box.put('isFirstTime', false);
  }

  //! Auth Entity Methods (User Profile only - tokens stored in SecureStorage)
  static const String _authKey = 'authModel';

  /// Cached auth entity to avoid repeated deserialization

  static Future<void> deleteAuthEntity() async {
    await _box.delete(_authKey);
    await _box.flush();
  }

}
