import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hr_erb/core/network/connectivity/connectivity_cubit.dart';
import 'package:flutter_hr_erb/core/network/connectivity/connectivity_wrapper.dart';
import 'package:flutter_hr_erb/core/services/service_locator.dart';
import 'core/routes/app_routers.dart';
import 'core/theme/cubit/theme_cubit.dart';
import 'core/theme/theme_data/theme_data_dark.dart';
import 'core/theme/theme_data/theme_data_light.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:country_picker/country_picker.dart';

class GO extends StatefulWidget {
  const GO({super.key});

  @override
  State<GO> createState() => _GOState();
}

class _GOState extends State<GO> {
  // Built once, not on every rebuild.
  final _lightTheme = getLightTheme();
  final _darkTheme = getDarkTheme();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ThemeCubit>.value(value: sl<ThemeCubit>()),
        BlocProvider<ConnectivityCubit>.value(value: sl<ConnectivityCubit>()),
      ],
      child: BlocBuilder<ThemeCubit, ThemeMode>(
        builder: (context, themeMode) {
          return MaterialApp.router(
            localizationsDelegates: [...context.localizationDelegates, CountryLocalizations.delegate],
            supportedLocales: context.supportedLocales,
            locale: context.locale,
            debugShowCheckedModeBanner: false,
            theme: _lightTheme,
            darkTheme: _darkTheme,
            themeMode: themeMode,
            builder: (context, child) {
              final botToastBuilder = BotToastInit();
              return ConnectivityWrapper(
                child: botToastBuilder(context, child),
              );
            },
            routerConfig: AppRouters.router,
          );
        },
      ),
    );
  }
}
