import 'package:flutter/widgets.dart';

import 'app.dart';
import 'core/config/app_config.dart';
import 'core/di/injection.dart';
import 'core/router/app_router.dart';
import 'features/auth/presentation/cubit/auth_cubit.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // TODO(observability): initialize Firebase (Crashlytics/Messaging) here,
  // guarded by config, once platform config files are present.
  await configureDependencies(AppConfig.development());

  // Restore any persisted session before the first frame so the router can
  // apply the correct initial redirect.
  await sl<AuthCubit>().init();

  runApp(FinceApp(router: sl<AppRouter>().router, authCubit: sl<AuthCubit>()));
}
