part of 'service_locator.imports.dart';

final sl = GetIt.instance;

/// Tears down user-scoped resources in dependency order.
/// Call this at logout before deleting tokens.
///
/// Do not close app-lifetime singletons here (e.g. [ConnectivityCubit]):
/// GetIt would keep returning the closed instance and its next emit throws.
/// For user-scoped singletons use `sl.resetLazySingleton<T>()` so a fresh
/// instance is created on next access.
void disposeAllServices() {}

Future<void> initDependencies() async {
 

  //Core

  sl.registerLazySingleton<ConnectionChecker>(() => ConnectionCheckerImpl(sl()));

  // Connectivity Cubit - Singleton for global internet monitoring
  sl.registerLazySingleton<ConnectivityCubit>(() => ConnectivityCubit(internetConnection: sl()));

  sl.registerLazySingleton<SecureStorageService>(() => SecureStorageService.instance);
  sl.registerLazySingleton<AppInterceptors>(() => AppInterceptors(sl<Dio>()));
  //Core
  sl.registerLazySingleton<InternetConnection>(() => InternetConnection());
  sl.registerLazySingleton<Connectivity>(() => Connectivity());
  sl.registerLazySingleton<Dio>(() => Dio());
  sl.registerLazySingleton<ApiConsumer>(() => DioConsumer(client: sl()));

}
