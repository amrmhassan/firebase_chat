import 'package:firebase_chat/features/login/domain/repositories/login_validation.dart';

class NameValidation implements Validate {
  @override
  String? error(String name) {
    if (name.isEmpty) {
      return 'Enter your name';
    }
    if (name.length < 3) {
      return 'name is too short';
    }
    return null;
  }
}
