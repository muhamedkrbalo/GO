import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../cache/hive/hive_methods.dart';
import '../cache/secure_storage/secure_storage_service.dart';
import '../routes/app_routers_import.dart';
import '../utils/common_methods.dart';
import '../utils/navigator_methods.dart';
import 'status_code.dart';
import '../routes/routes_name.dart';
// import 'token_refresh_service.dart';

class AppInterceptors extends Interceptor {
  final Dio _dio;
  // final TokenRefreshService _tokenRefreshService;
  final SecureStorageService _secureStorage;
  final Future<bool> Function() _hasConnection;

  AppInterceptors(
    this._dio, {
    // TokenRefreshService? tokenRefreshService,
    SecureStorageService? secureStorage,
    Future<bool> Function()? hasConnection,
  })  
  : 
  //_tokenRefreshService = tokenRefreshService ?? TokenRefreshService.instance,
        _secureStorage = secureStorage ?? SecureStorageService.instance,
        _hasConnection = hasConnection ?? CommonMethods.hasConnection;

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    debugPrint('REQUEST[${options.method}] => PATH: ${options.path}');

    options.headers['Content-Type'] = 'application/json';
    options.headers['Accept'] = 'application/json';
    options.headers['Accept-Language'] = HiveMethods.getLang();

    if (!await _hasConnection()) {
      return handler.reject(
        DioException(
          requestOptions: options,
          error: 'No Internet Connection',
          type: DioExceptionType.connectionError,
        ),
      );
    }

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
          await _handleAuthFailure();
      // if (_isRefreshRequest(err.requestOptions)) {
      //   debugPrint('Refresh token request failed, logging out...');
      //   await _handleAuthFailure();
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

  Future<void> _handleAuthFailure() async {
    await _secureStorage.deleteAllTokens();
    await HiveMethods.deleteAuthEntity();

    final context = AppRouters.navigatorKey.currentContext;
    if (context != null) {
      NavigatorMethods.pushNamedAndRemoveUntil(
        context,
        RoutesName.splashScreen,
      );
    }
  }
}
