import 'package:firebase_chat/features/login/domain/repositories/login_validation.dart';

class PasswordValidation implements Validate {
  @override
  String? error(String password) {
    if (password.length < 8) {
      return 'Must be at least 8 characters';
    } else if (!password.contains(RegExp(r'[a-zA-Z]'))) {
      return 'Must contain letters';
    } else if (!password.contains(RegExp(r'[0-9]'))) {
      return 'Must contain numbers';
    } else {
      return null;
    }
  }
}
