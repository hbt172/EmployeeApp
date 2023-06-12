import 'package:flutter/material.dart';
import 'package:flutter_assignment/data_set/hive_middleware/database.dart';
import 'app.dart';
final database = HiveDatabase();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await init();
  runApp(const App());
}

init() async {
  await database.start();

}
