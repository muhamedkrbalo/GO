import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

import '../../features/splash/data/repository/splash_repository.dart';
import '../../features/splash/presentation/controller/splash_cubit.dart';
import '../cache/secure_storage/secure_storage_service.dart';
import '../network/api_consumer.dart';
import '../network/app_interceptors.dart';
import '../network/connection_checker.dart';
import '../network/connectivity/connectivity_cubit.dart';
import '../network/dio_consumer.dart';
import '../theme/cubit/theme_cubit.dart';

final sl = GetIt.instance;

/// Registration rules:
/// - App-wide services and app-lifetime Cubits → `registerLazySingleton`.
/// - Feature Cubits → `registerFactory` (a fresh instance per screen).
/// - Dependencies are passed through constructors, never pulled with `sl` inside a class.
Future<void> initDependencies() async {
  _initCore();
  _initSplash();
}

/// Tears down user-scoped resources in dependency order.
/// Call this at logout before deleting tokens.
///
/// Do not close app-lifetime singletons here (e.g. [ConnectivityCubit]):
/// GetIt would keep returning the closed instance and its next emit throws.
/// For user-scoped singletons use `sl.resetLazySingleton<T>()` so a fresh
/// instance is created on next access.
void disposeAllServices() {}

void _initCore() {
  // Storage
  sl.registerLazySingleton<SecureStorageService>(SecureStorageService.new);

  // Network
  sl.registerLazySingleton<Dio>(Dio.new);
  sl.registerLazySingleton<AppInterceptors>(
    () => AppInterceptors(sl<Dio>(), secureStorage: sl()),
  );
  sl.registerLazySingleton<ApiConsumer>(
    () => DioConsumer(client: sl(), interceptors: sl()),
  );

  // Connectivity
  sl.registerLazySingleton<InternetConnection>(InternetConnection.new);
  sl.registerLazySingleton<ConnectionChecker>(() => ConnectionCheckerImpl(sl()));

  // App-lifetime Cubits
  sl.registerLazySingleton<ConnectivityCubit>(() => ConnectivityCubit(internetConnection: sl()));
  sl.registerLazySingleton<ThemeCubit>(ThemeCubit.new);
}

void _initSplash() {
  sl.registerLazySingleton<SplashRepository>(() => SplashRepositoryImpl(sl()));
  sl.registerFactory<SplashCubit>(() => SplashCubit(sl()));
}
