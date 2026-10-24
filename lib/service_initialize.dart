import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:timeago/timeago.dart' as timeago;

import 'core/app_bloc_observer.dart/app_bloc_observer.dart';
import 'core/auth/auth_session.dart';
import 'core/images/app_images.dart';
import 'core/services/service_locator.dart';

// TODO: enable together with Firebase.initializeApp below. The pragma keeps the
// handler from being tree-shaken in release builds.
// @pragma('vm:entry-point')
// Future<void> onAppBackground(RemoteMessage message) async {}

class ServiceInitialize {
  ServiceInitialize._();
  static Future<void> initialize() async {
    //! Initialize all services here
    WidgetsFlutterBinding.ensureInitialized();
    // Logs every Bloc/Cubit change: debug builds only.
    if (kDebugMode) Bloc.observer = AppBlocObserver();
    await EasyLocalization.ensureInitialized();
    // await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
    await initDependencies();
    await Hive.initFlutter();
    await Hive.openBox('app');
    HydratedBloc.storage = await HydratedStorage.build(
      storageDirectory: kIsWeb
          ? HydratedStorageDirectory.web
          : HydratedStorageDirectory((await getApplicationDocumentsDirectory()).path),
    );

    // Not awaited: the splash screen shows while the session is restored, then
    // the router redirects to login or home.
    unawaited(sl<AuthSession>().restore());

    // FirebaseMessaging.onBackgroundMessage(onAppBackground);
    timeago.setLocaleMessages('en', timeago.EnMessages());
    timeago.setLocaleMessages('en_short', timeago.EnShortMessages());
    timeago.setLocaleMessages('ar', timeago.ArMessages());
    timeago.setLocaleMessages('ar_short', timeago.ArShortMessages());
    LicenseRegistry.addLicense(_fontLicenses);
  }

  static Stream<LicenseEntry> _fontLicenses() async* {
    for (final (family, asset) in [
      ('Manrope', AppImages.assetsFontsManropeOFL),
      ('Gelasio', AppImages.assetsFontsGelasioOFL),
    ]) {
      yield LicenseEntryWithLineBreaks([family], await rootBundle.loadString(asset));
    }
  }
}
