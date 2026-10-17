/// URL paths, used by `GoRoute.path`, redirects and `context.go(...)`.
abstract final class RoutePaths {
  static const String splash = '/';
  static const String login = '/login';
  static const String home = '/home';
  static const String zoomImage = '/zoom-image';
}

/// Route names, used by `context.pushNamed(...)` / `NavigatorMethods`.
abstract final class RouteNames {
  static const String splash = 'splash';
  static const String login = 'login';
  static const String home = 'home';
  static const String zoomImage = 'zoomImage';
}
