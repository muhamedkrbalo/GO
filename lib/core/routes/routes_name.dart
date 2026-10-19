/// URL paths, used by `GoRoute.path`, redirects and `context.go(...)`.
abstract final class RoutePaths {
  static const String splash = '/';
  static const String onboarding = '/onboarding';
  static const String welcome = '/welcome';
  static const String login = '/login';
  static const String register = '/register';
  static const String verifyAccount = '/verify-account';
  static const String verifyCode = '/verify-code';
  static const String businessRole = '/business-role';
  static const String ownerType = '/owner-type';
  static const String home = '/home';
  static const String zoomImage = '/zoom-image';
}

/// Route names, used by `context.pushNamed(...)`.
abstract final class RouteNames {
  static const String splash = 'splash';
  static const String onboarding = 'onboarding';
  static const String welcome = 'welcome';
  static const String login = 'login';
  static const String register = 'register';
  static const String verifyAccount = 'verifyAccount';
  static const String verifyCode = 'verifyCode';
  static const String businessRole = 'businessRole';
  static const String ownerType = 'ownerType';
  static const String home = 'home';
  static const String zoomImage = 'zoomImage';
}
