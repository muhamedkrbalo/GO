import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../features/auth/presentation/view/screen/login_screen.dart';
import '../../features/home/presentation/view/screen/home_screen.dart';
import '../../features/splash/presentation/controller/splash_cubit.dart';
import '../../features/splash/presentation/view/screen/splash_screen.dart';
import '../auth/auth_session.dart';
import '../custom_widgets/zoom_image/zoom_image_screen.dart';
import '../services/service_locator.dart';
import 'routes_name.dart';

class AppRouters {
  /// Owned by the router. Don't use `navigatorKey.currentContext` in helpers:
  /// pass a [BuildContext] (see `context_ui_extension.dart`) instead.
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  static final AuthSession _authSession = sl<AuthSession>();

  static final GoRouter router = GoRouter(
    navigatorKey: navigatorKey,
    initialLocation: RoutePaths.splash,
    observers: [BotToastNavigatorObserver()],
    // Re-runs [_authRedirect] whenever the auth status changes (login, logout, 401).
    refreshListenable: _authSession,
    redirect: _authRedirect,
    routes: [
      GoRoute(
        path: RoutePaths.splash,
        name: RouteNames.splash,
        builder: (context, state) => BlocProvider(
          create: (_) => sl<SplashCubit>(),
          child: const SplashScreen(),
        ),
      ),
      GoRoute(
        path: RoutePaths.login,
        name: RouteNames.login,
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: RoutePaths.home,
        name: RouteNames.home,
        builder: (context, state) => const HomeScreen(),
      ),
      GoRoute(
        path: RoutePaths.zoomImage,
        name: RouteNames.zoomImage,
        // `extra` is null on deep links, web refresh and state restoration.
        redirect: (context, state) =>
            state.extra is ZoomImageArgs ? null : RoutePaths.home,
        builder: (context, state) => ZoomImageScreen(
          args: state.extra as ZoomImageArgs,
        ),
      ),
    ],
  );

  /// Login gating, in one place:
  /// - unknown (restoring session) → splash
  /// - signed out → login
  /// - signed in → anywhere except splash/login (those go to home)
  static String? _authRedirect(BuildContext context, GoRouterState state) {
    final location = state.matchedLocation;
    switch (_authSession.value) {
      case AuthStatus.unknown:
        return location == RoutePaths.splash ? null : RoutePaths.splash;
      case AuthStatus.unauthenticated:
        return location == RoutePaths.login ? null : RoutePaths.login;
      case AuthStatus.authenticated:
        return location == RoutePaths.splash || location == RoutePaths.login
            ? RoutePaths.home
            : null;
    }
  }
}
