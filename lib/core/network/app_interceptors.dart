import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../auth/auth_session.dart';
import '../cache/hive/hive_methods.dart';
import '../cache/secure_storage/secure_storage_service.dart';
import 'status_code.dart';
// import 'token_refresh_service.dart';

class AppInterceptors extends Interceptor {
  final Dio _dio;
  // final TokenRefreshService _tokenRefreshService;
  final SecureStorageService _secureStorage;
  final AuthSession _authSession;

  AppInterceptors(
    this._dio, {
    // TokenRefreshService? tokenRefreshService,
    required SecureStorageService secureStorage,
    required AuthSession authSession,
  })
  :
  //_tokenRefreshService = tokenRefreshService ?? TokenRefreshService.instance,
        _secureStorage = secureStorage,
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

    //final token = await _secureStorage.getAccessToken();
    // if (token != null) {
    //   if (await _tokenRefreshService.isTokenExpiringSoon()) {
    //     debugPrint('Token expiring soon, attempting proactive refresh...');
    //     final refreshed = await _tokenRefreshService.refreshToken();
    //     if (refreshed) {
    //       final newToken = await _secureStorage.getAccessToken();
    //       options.headers['Authorization'] = newToken;
    //     } else {
    //       options.headers['Authorization'] = token;
    //     }
    //   } else {
    //     options.headers['Authorization'] = token;
    //   }
    // }

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
      // if (_isRefreshRequest(err.requestOptions)) {
      //   debugPrint('Refresh token request failed, logging out...');
      //   await _authSession.signOut();
      //   return handler.reject(err);
      // }

      debugPrint('Received 401, attempting token refresh...');
      // final refreshed = await _tokenRefreshService.refreshToken();

      // if (refreshed) {
      //   debugPrint('Token refreshed, retrying original request...');
      //   try {
      //     final retryResponse = await _retryRequest(err.requestOptions);
      //     return handler.resolve(retryResponse);
      //   } catch (retryError) {
      //     debugPrint('Retry failed: $retryError');
      //     if (retryError is DioException) {
      //       return handler.reject(retryError);
      //     }
      //     return handler.reject(err);
      //   }
      // } else {
      //   debugPrint('Token refresh failed, user logged out');
      //   return handler.reject(err);
      // }
    }

    super.onError(err, handler);
  }

  // bool _isRefreshRequest(RequestOptions options) {
  //   return options.path.contains('auth/refresh');
  // }

  Future<Response<dynamic>> _retryRequest(RequestOptions requestOptions) async {
    final newToken = await _secureStorage.getAccessToken();

    return _dio.request(
      requestOptions.path,
      data: requestOptions.data,
      queryParameters: requestOptions.queryParameters,
      options: Options(
        method: requestOptions.method,
        headers: {
          ...requestOptions.headers,
          'Authorization': newToken,
        },
      ),
    );
  }
}
