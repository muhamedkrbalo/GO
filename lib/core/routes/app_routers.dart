part of 'app_routers_import.dart';

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
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: '/zoom-image',
        name: ZoomImageScreen.routeName,
        builder: (context, state) => ZoomImageScreen(
          args: state.extra as ZoomImageArgs,
        ),
      ),
    ],
  );
}
