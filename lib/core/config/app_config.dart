/// App-wide configuration. Plain constants: works with a normal `flutter run`,
/// no flavors or `--dart-define` needed. Move to flavors later if you need
/// separate dev/prod builds.
abstract final class AppConfig {
  // TODO: set the API base URL, ending with '/' (e.g. 'https://api.example.com/api/').
  static const String baseUrl = '';

  static const Duration connectTimeout = Duration(seconds: 30);
  static const Duration sendTimeout = Duration(seconds: 30);
  static const Duration receiveTimeout = Duration(seconds: 30);
}
