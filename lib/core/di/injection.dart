import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import '../../features/auth/data/datasources/auth_local_data_source.dart';
import '../../features/auth/data/datasources/auth_remote_data_source.dart';
import '../../features/auth/data/repositories/auth_repository_impl.dart';
import '../../features/auth/domain/repositories/auth_repository.dart';
import '../../features/auth/domain/usecases/authenticate_with_biometrics.dart';
import '../../features/auth/domain/usecases/forgot_password.dart';
import '../../features/auth/domain/usecases/get_current_user.dart';
import '../../features/auth/domain/usecases/login.dart';
import '../../features/auth/domain/usecases/logout.dart';
import '../../features/auth/domain/usecases/register.dart';
import '../../features/auth/presentation/cubit/auth_cubit.dart';
import '../config/app_config.dart';
import '../constants/storage_keys.dart';
import '../network/dio_client.dart';
import '../router/app_router.dart';
import '../storage/secure_storage.dart';

/// Composition root. All concrete implementations are registered here and
/// resolved by the presentation layer through their abstractions.
final GetIt sl = GetIt.instance;

/// Registers application-wide singletons and feature modules.
Future<void> configureDependencies(AppConfig config) async {
  sl.registerLazySingleton<AppConfig>(() => config);
  sl.registerLazySingleton<SecureStorage>(SecureStorage.new);
  sl.registerLazySingleton<Dio>(
    () => buildDio(
      config,
      tokenProvider: () => sl<SecureStorage>().read(StorageKeys.accessToken),
    ),
  );

  _registerAuthModule();
  sl.registerLazySingleton<AppRouter>(() => AppRouter(sl<AuthCubit>()));
}

void _registerAuthModule() {
  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSource(sl<Dio>()),
  );
  sl.registerLazySingleton<AuthLocalDataSource>(
    () => AuthLocalDataSource(sl<SecureStorage>()),
  );
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(remote: sl(), local: sl()),
  );
  sl.registerLazySingleton<Login>(() => Login(sl()));
  sl.registerLazySingleton<Register>(() => Register(sl()));
  sl.registerLazySingleton<Logout>(() => Logout(sl()));
  sl.registerLazySingleton<ForgotPassword>(() => ForgotPassword(sl()));
  sl.registerLazySingleton<GetCurrentUser>(() => GetCurrentUser(sl()));
  sl.registerLazySingleton<AuthenticateWithBiometrics>(
    () => AuthenticateWithBiometrics(sl()),
  );
  sl.registerLazySingleton<AuthCubit>(
    () => AuthCubit(
      login: sl(),
      register: sl(),
      logout: sl(),
      forgotPassword: sl(),
      getCurrentUser: sl(),
      authenticateWithBiometrics: sl(),
    ),
  );
}
