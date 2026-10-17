import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'app.dart';
import 'core/cache/hive/hive_methods.dart';
import 'service_intialize.dart';

void main() async {
  await ServiceInitialize.initialize();
  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('ar'), Locale('en')],
      path: 'i18n',
      fallbackLocale: const Locale('ar'),
      // Hive is the single source of truth for the language (see HiveMethods.getLang).
      startLocale: Locale(HiveMethods.getLang()),
      saveLocale: false,
      child: const GO(),
    ),
  );
}
