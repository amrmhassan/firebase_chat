import 'package:hive_flutter/hive_flutter.dart';

class HiveBox {
  static Future<Box> customBox(String name) async {
    return Hive.openBox(name);
  }

  static Future<Box> get allowedDevices =>
      Hive.openBox(_HiveBoxesNames.downloadTasks);
}

class _HiveBoxesNames {
  static const String downloadTasks = 'downloadTasksBoxName';
}
