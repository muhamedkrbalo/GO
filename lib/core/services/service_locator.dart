part of 'service_locator.imports.dart';

final sl = GetIt.instance;

/// Tears down all long-lived resource holders in dependency order.
/// Call this at logout before deleting tokens.
void disposeAllServices() {

  // ignore: unawaited_futures
  sl<ConnectivityCubit>().close();
}

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
