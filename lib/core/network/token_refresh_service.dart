// import 'dart:async';

// import 'package:dio/dio.dart';
// import 'package:flutter/foundation.dart';
// import 'package:get_it/get_it.dart';

// import '../cache/hive/hive_methods.dart';
// import '../cache/secure_storage/secure_storage_service.dart';
// import '../routes/app_routers.dart';
// import '../routes/routes_name.dart';
// import '../utils/navigator_methods.dart';
// import 'end_points.dart';

// class TokenRefreshService {
//   TokenRefreshService._();

//   static TokenRefreshService? _instance;
//   static TokenRefreshService get instance => _instance ??= TokenRefreshService._();

//   final SecureStorageService _secureStorage = SecureStorageService.instance;

//   Completer<bool>? _refreshCompleter;
//   Dio? _refreshDio;

//   int _refreshAttempts = 0;
//   static const int _maxRefreshAttempts = 3;

//   Dio get _dio {
//     _refreshDio ??= Dio(
//       BaseOptions(
//         baseUrl: GetIt.instance<AppConfig>().apiBaseUrl,
//         connectTimeout: const Duration(seconds: 30),
//         receiveTimeout: const Duration(seconds: 30),
//       ),
//     );
//     return _refreshDio!;
//   }

//   bool get isRefreshing => _refreshCompleter != null && !_refreshCompleter!.isCompleted;

//   Future<bool> isTokenExpired() async {
//     final expiresAt = await _secureStorage.getTokenExpiresAt();
//     if (expiresAt == null) return false;

//     try {
//       final expiryDate = DateTime.parse(expiresAt);
//       return DateTime.now().isAfter(expiryDate);
//     } catch (e) {
//       debugPrint('Error parsing token expiry date: $e');
//       return false;
//     }
//   }

//   Future<bool> isTokenExpiringSoon({int bufferSeconds = 60}) async {
//     final expiresAt = await _secureStorage.getTokenExpiresAt();
//     if (expiresAt == null) return false;

//     try {
//       final expiryDate = DateTime.parse(expiresAt);
//       final bufferTime = DateTime.now().add(Duration(seconds: bufferSeconds));
//       return bufferTime.isAfter(expiryDate);
//     } catch (e) {
//       debugPrint('Error parsing token expiry date: $e');
//       return false;
//     }
//   }

//   Future<bool> refreshToken() async {
//     if (isRefreshing) {
//       debugPrint('Token refresh already in progress, waiting...');
//       return _refreshCompleter!.future;
//     }

//     final refreshToken = await _secureStorage.getRefreshToken();
//     if (refreshToken == null) {
//       debugPrint('No refresh token available');
//       await _handleRefreshFailure();
//       return false;
//     }

//     _refreshCompleter = Completer<bool>();
//     _refreshAttempts++;
//     debugPrint('Token refresh attempt $_refreshAttempts of $_maxRefreshAttempts');

//     try {
//       debugPrint('Starting token refresh...');

//       final response = await _dio.post(
//         EndPoints.refreshToken,
//         options: Options(
//           headers: {
//             'Content-Type': 'application/json',
//             'Accept': 'application/json',
//             'Accept-Language': HiveMethods.getLang(),
//             'Authorization': refreshToken,
//           },
//         ),
//       );

//       if (response.statusCode == 200 && response.data != null) {
//         final data = response.data['data'];
//         if (data != null && data['tokens'] != null) {
//           final tokens = data['tokens'];
//           final newAccessToken = tokens['access_token'] as String?;
//           final newRefreshToken = tokens['refresh_token'] as String?;
//           final newExpiresAt = tokens['expires_at'] as String?;

//           if (newAccessToken != null) {
//             await _secureStorage.setAccessToken(newAccessToken);
//             debugPrint('Access token updated successfully');
//           }

//           if (newRefreshToken != null) {
//             await _secureStorage.setRefreshToken(newRefreshToken);
//             debugPrint('Refresh token updated successfully');
//           }

//           if (newExpiresAt != null) {
//             await _secureStorage.setTokenExpiresAt(newExpiresAt);
//             debugPrint('Token expiry updated successfully');
//           }

//           _refreshAttempts = 0;
//           _refreshCompleter!.complete(true);
//           debugPrint('Token refresh completed successfully');
//           return true;
//         }
//       }

//       debugPrint('Token refresh failed: Invalid response');
//       _refreshCompleter!.complete(false);
//       if (_refreshAttempts >= _maxRefreshAttempts) await _handleRefreshFailure();
//       return false;
//     } on DioException catch (e) {
//       debugPrint('Token refresh failed with DioException: ${e.message}');
//       debugPrint('Status code: ${e.response?.statusCode}');

//       _refreshCompleter!.complete(false);
//       if (_refreshAttempts >= _maxRefreshAttempts) await _handleRefreshFailure();
//       return false;
//     } catch (e) {
//       debugPrint('Token refresh failed with error: $e');
//       _refreshCompleter!.complete(false);
//       if (_refreshAttempts >= _maxRefreshAttempts) await _handleRefreshFailure();
//       return false;
//     } finally {
//       _refreshCompleter = null;
//     }
//   }

//   Future<void> _handleRefreshFailure() async {
//     debugPrint('Handling refresh failure - logging out user');
//     await _secureStorage.deleteAllTokens();
//     await HiveMethods.deleteAuthEntity();

//     final context = AppRouters.navigatorKey.currentContext;
//     if (context != null) {
//       NavigatorMethods.pushNamedAndRemoveUntil(
//         context,
//         RoutesName.loginScreen,
//       );
//     }
//   }

//   void reset() {
//     _refreshAttempts = 0;
//     _refreshCompleter = null;
//   }
// }
