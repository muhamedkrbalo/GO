import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../auth/auth_session.dart';
import '../cache/hive/hive_methods.dart';
import '../cache/secure_storage/secure_storage_service.dart';
import 'status_code.dart';

class AppInterceptors extends Interceptor {
  final SecureStorageService _secureStorage;
  final AuthSession _authSession;

  AppInterceptors({
    required SecureStorageService secureStorage,
    required AuthSession authSession,
  })  : _secureStorage = secureStorage,
        _authSession = authSession;

  // No pre-flight internet check here: Dio already fails with
  // DioExceptionType.connectionError, which handleDioRequest maps to NetworkFailure.
  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    debugPrint('REQUEST[${options.method}] => PATH: ${options.path}');

    options.headers['Accept-Language'] = HiveMethods.getLang();

    final token = await _secureStorage.getAccessToken();
    if (token != null && token.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $token';
    }

    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    debugPrint(
      'RESPONSE[${response.statusCode}] => PATH: ${response.requestOptions.path}',
    );
    super.onResponse(response, handler);
  }

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    debugPrint(
      'ERROR[${err.response?.statusCode}] => PATH: ${err.requestOptions.path}',
    );

    if (err.response?.statusCode == StatusCode.unauthorized) {
      // Only clear the session; the router's redirect sends the user to login.
      await _authSession.signOut();
    }

    super.onError(err, handler);
  }
}
