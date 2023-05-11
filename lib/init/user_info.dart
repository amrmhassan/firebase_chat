import 'package:firebase_chat/core/hive/hive_helper.dart';
import 'package:firebase_chat/features/auth/data/models/user_model.dart';
import 'package:firebase_chat/init/runtime_variables.dart';

UserModel? _currentUser;

class CUserInfo {
  static Future<void> initUser() async {
    try {
      var box = await HiveBox.currentUser;
      if (box.values.isEmpty) return;
      var data = box.values.first as UserModel;
      _currentUser = data;
    } catch (e) {
      logger.e(e);
    }
  }

  static Future<void> saveCurrentUserInfo(UserModel userModel) async {
    var box = await HiveBox.currentUser;
    await box.put(userModel.uid, userModel);
  }

  static Future<void> deleteCurrentUserInfo() async {
    var box = await HiveBox.currentUser;
    await box.clear();
  }

  static UserModel? get currentUser => _currentUser;
}
