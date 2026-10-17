/// HTTP client used by repositories.
///
/// Every method returns the decoded JSON object. A response that is not a JSON
/// object throws a [FormatException], which `handleDioRequest` turns into a
/// [Failure] — so malformed responses are handled in one place.
abstract class ApiConsumer {
  Future<Map<String, dynamic>> get(String path, {Map<String, dynamic>? queryParameters});
  Future<Map<String, dynamic>> post(
    String path, {
    Map<String, dynamic>? body,
    Map<String, dynamic>? queryParameters,
    bool? isFormData,
  });
  Future<Map<String, dynamic>> put(
    String path, {
    Map<String, dynamic>? body,
    Map<String, dynamic>? queryParameters,
    bool? isFormData,
  });
  Future<Map<String, dynamic>> patch(
    String path, {
    Map<String, dynamic>? body,
    Map<String, dynamic>? queryParameters,
  });
  Future<Map<String, dynamic>> delete(
    String path, {
    Map<String, dynamic>? body,
    Map<String, dynamic>? queryParameters,
    bool? isFormData,
  });
}
