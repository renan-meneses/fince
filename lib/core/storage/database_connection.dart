import 'dart:io';

import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

import 'app_database.dart';

/// Opens the on-device SQLite database in a background isolate.
///
/// Tests should instead construct [AppDatabase] with `NativeDatabase.memory()`.
Future<AppDatabase> openAppDatabase() async {
  final dir = await getApplicationDocumentsDirectory();
  final file = File(p.join(dir.path, 'fince.db'));
  return AppDatabase(NativeDatabase.createInBackground(file));
}
