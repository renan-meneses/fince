import 'package:flutter/widgets.dart';

import 'app.dart';
import 'core/config/app_config.dart';
import 'core/di/injection.dart';
import 'core/router/app_router.dart';
import 'features/auth/presentation/cubit/auth_cubit.dart';

/// Demo entrypoint. No login — opens directly on the dashboard with the local
/// database pre-seeded with sample data.
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureDependencies(AppConfig.demo());
  await sl<AuthCubit>().init();
  runApp(FinceApp(router: sl<AppRouter>().router, authCubit: sl<AuthCubit>()));
}
