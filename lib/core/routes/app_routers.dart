import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../features/splash/presentation/controller/splash_cubit.dart';
import '../../features/splash/presentation/view/screen/splash_screen.dart';
import '../custom_widgets/zoom_image/zoom_image_screen.dart';
import '../services/service_locator.dart';
import 'routes_name.dart';

class AppRouters {
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  static final GoRouter router = GoRouter(
    navigatorKey: navigatorKey,
    initialLocation: RoutesName.splashScreen,
    observers: [BotToastNavigatorObserver()],
    routes: [
      GoRoute(
        path: RoutesName.splashScreen,
        name: RoutesName.splashScreen,
        builder: (context, state) => BlocProvider(
          create: (_) => sl<SplashCubit>(),
          child: const SplashScreen(),
        ),
      ),
      GoRoute(
        path: '/zoom-image',
        name: ZoomImageScreen.routeName,
        // `extra` is null on deep links, web refresh and state restoration.
        redirect: (context, state) =>
            state.extra is ZoomImageArgs ? null : RoutesName.splashScreen,
        builder: (context, state) => ZoomImageScreen(
          args: state.extra as ZoomImageArgs,
        ),
      ),
    ],
  );
}
