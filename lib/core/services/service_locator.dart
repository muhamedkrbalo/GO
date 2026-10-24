import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

import '../../features/auth/presentation/controller/business_role_cubit.dart';
import '../../features/auth/presentation/controller/register_cubit.dart';
import '../../features/auth/presentation/controller/verify_account_cubit.dart';
import '../../features/auth/presentation/controller/verify_code_cubit.dart';
import '../../features/onboarding/presentation/controller/onboarding_cubit.dart';
import '../../features/owner_registration/data/model/owner_unit.dart';
import '../../features/owner_registration/data/model/sample_units.dart';
import '../../features/owner_registration/presentation/controller/individual_info_cubit.dart';
import '../../features/owner_registration/presentation/controller/owner_address_cubit.dart';
import '../../features/owner_registration/presentation/controller/owner_documents_cubit.dart';
import '../../features/owner_registration/presentation/controller/owner_type_cubit.dart';
import '../../features/owner_registration/presentation/controller/ownership_details_cubit.dart';
import '../../features/owner_registration/presentation/controller/unit_selection_cubit.dart';
import '../../features/splash/data/repository/splash_repository.dart';
import '../../features/splash/presentation/controller/splash_cubit.dart';
import '../auth/auth_session.dart';
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
  _initOnboarding();
  _initAuth();
  _initOwnerRegistration();
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

  // Auth
  sl.registerLazySingleton<AuthSession>(() => AuthSession(sl()));

  // Network
  sl.registerLazySingleton<Dio>(Dio.new);
  sl.registerLazySingleton<AppInterceptors>(
    () => AppInterceptors(secureStorage: sl(), authSession: sl()),
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

void _initOnboarding() {
  sl.registerFactory<OnboardingCubit>(OnboardingCubit.new);
}

void _initAuth() {
  sl.registerFactory<RegisterCubit>(RegisterCubit.new);
  sl.registerFactory<VerifyAccountCubit>(VerifyAccountCubit.new);
  sl.registerFactory<VerifyCodeCubit>(VerifyCodeCubit.new);
  sl.registerFactory<BusinessRoleCubit>(BusinessRoleCubit.new);
}

void _initOwnerRegistration() {
  sl.registerFactory<OwnerTypeCubit>(OwnerTypeCubit.new);
  sl.registerFactory<IndividualInfoCubit>(IndividualInfoCubit.new);
  sl.registerFactory<OwnerAddressCubit>(OwnerAddressCubit.new);
  sl.registerFactory<UnitSelectionCubit>(() => UnitSelectionCubit(sampleUnits));
  sl.registerFactoryParam<OwnershipDetailsCubit, List<OwnerUnit>, void>(
    (units, _) => OwnershipDetailsCubit(units),
  );
  sl.registerFactoryParam<OwnerDocumentsCubit, List<OwnerUnit>, void>(
    (units, _) => OwnerDocumentsCubit(units),
  );
}
