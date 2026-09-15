import 'package:flutter/widgets.dart';

import 'app.dart';
import 'core/config/app_config.dart';
import 'core/di/injection.dart';
import 'core/router/app_router.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // TODO(observability): initialize Firebase (Crashlytics/Messaging) here,
  // guarded by config, once platform config files are present.
  await configureDependencies(AppConfig.development());

  runApp(FinceApp(router: sl<AppRouter>().router));
}
