import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../features/auth/presentation/view/screen/login_screen.dart';
import '../../features/home/presentation/view/screen/home_screen.dart';
import '../../features/onboarding/presentation/controller/onboarding_cubit.dart';
import '../../features/onboarding/presentation/view/screen/onboarding_screen.dart';
import '../../features/onboarding/presentation/view/screen/welcome_screen.dart';
import '../../features/splash/presentation/controller/splash_cubit.dart';
import '../../features/splash/presentation/view/screen/splash_screen.dart';
import '../auth/auth_session.dart';
import '../cache/hive/hive_methods.dart';
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
    refreshListenable: _authSession,
    redirect: _authRedirect,
    routes: [
      GoRoute(
        path: RoutePaths.splash,
        name: RouteNames.splash,
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: RoutePaths.onboarding,
        name: RouteNames.onboarding,
        builder: (context, state) => BlocProvider(
          create: (_) => sl<OnboardingCubit>(),
          child: const OnboardingScreen(),
        ),
      ),
      GoRoute(
        path: RoutePaths.welcome,
        name: RouteNames.welcome,
        builder: (context, state) => const WelcomeScreen(),
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

  /// Screens a signed-out user may stay on.
  static const _signedOutPaths = {
    RoutePaths.onboarding,
    RoutePaths.welcome,
    RoutePaths.login,
  };

  /// Login gating, in one place:
  /// - unknown (restoring session) → splash
  /// - signed out → onboarding (first launch) or welcome; may also open login
  /// - signed in → anywhere except splash and the signed-out screens (those go to home)
  static String? _authRedirect(BuildContext context, GoRouterState state) {
    final location = state.matchedLocation;
    switch (_authSession.value) {
      case AuthStatus.unknown:
        return location == RoutePaths.splash ? null : RoutePaths.splash;
      case AuthStatus.unauthenticated:
        if (_signedOutPaths.contains(location)) return null;
        return HiveMethods.isFirstTime() ? RoutePaths.onboarding : RoutePaths.welcome;
      case AuthStatus.authenticated:
        return location == RoutePaths.splash || _signedOutPaths.contains(location)
            ? RoutePaths.home
            : null;
    }
  }
}
