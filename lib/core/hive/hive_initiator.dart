import 'package:firebase_chat/features/auth/data/models/user_model.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HiveInitiator {
  Future<void> setup() async {
    await Hive.initFlutter();
    _registerAdapters();
  }

  Future<void> _registerAdapters() async {
    Hive.registerAdapter(UserModelAdapter()); //=>0
  }
}
