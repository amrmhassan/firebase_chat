import 'package:hive_flutter/hive_flutter.dart';

class HiveBox {
  static Future<Box> customBox(String name) async {
    return Hive.openBox(name);
  }

  static Future<Box> get currentUser =>
      Hive.openBox(_HiveBoxesNames.currentUser);
}

class _HiveBoxesNames {
  static const String currentUser = 'currentUser';
}
