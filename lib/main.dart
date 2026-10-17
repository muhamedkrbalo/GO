import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'core/theme/cubit/theme_cubit.dart';
import 'package:easy_localization/easy_localization.dart';
import 'service_intialize.dart';
import 'app.dart';

void main() async {
  await ServiceInitialize.initialize();
  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('ar'), Locale('en')],
      path: 'i18n',
      fallbackLocale: const Locale('ar'),
      startLocale: const Locale('en'),
      saveLocale: true,
      child: BlocProvider(create: (_) => ThemeCubit(), child: const GO()),
    ),
  );
}
