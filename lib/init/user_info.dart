import 'dart:async';

import 'package:firebase_chat/core/hive/hive_helper.dart';
import 'package:firebase_chat/features/auth/data/models/user_model.dart';
import 'package:firebase_chat/init/runtime_variables.dart';

UserModel? _currentUser;
CUserInfo _cUserInfo = CUserInfo();

class CUserInfo {
  static CUserInfo get instance => _cUserInfo;
  final StreamController<UserModel?> _userChangesController =
      StreamController<UserModel?>();

  Stream<UserModel?> get userChanges => _userChangesController.stream;

  Future<void> initUser() async {
    try {
      var box = await HiveBox.currentUser;
      if (box.values.isEmpty) {
        _userChangesController.sink.add(null);
        return;
      }
      var data = box.values.first as UserModel;
      _currentUser = data;
      _userChangesController.sink.add(data);
    } catch (e) {
      logger.e(e);
    }
  }

  Future<void> saveCurrentUserInfo(UserModel userModel) async {
    var box = await HiveBox.currentUser;
    await box.put(userModel.uid, userModel);
    _userChangesController.sink.add(userModel);
  }

  Future<void> deleteCurrentUserInfo() async {
    var box = await HiveBox.currentUser;
    await box.clear();
    _currentUser = null;
    _userChangesController.sink.add(null);
  }

  UserModel? get currentUser => _currentUser;
}
