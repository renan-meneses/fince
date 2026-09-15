import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import '../config/app_config.dart';
import '../constants/storage_keys.dart';
import '../network/dio_client.dart';
import '../router/app_router.dart';
import '../storage/secure_storage.dart';

/// Composition root. All concrete implementations are registered here and
/// resolved by the presentation layer through their abstractions.
final GetIt sl = GetIt.instance;

/// Registers application-wide singletons.
///
/// Feature modules register their own bindings via `register<Feature>Module()`
/// functions so tests can substitute fakes at the same seams.
Future<void> configureDependencies(AppConfig config) async {
  sl.registerLazySingleton<AppConfig>(() => config);

  sl.registerLazySingleton<SecureStorage>(SecureStorage.new);

  sl.registerLazySingleton<Dio>(
    () => buildDio(
      config,
      tokenProvider: () =>
          sl<SecureStorage>().read(StorageKeys.accessToken),
    ),
  );

  sl.registerLazySingleton<AppRouter>(AppRouter.new);
}
