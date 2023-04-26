import 'package:firebase_chat/features/login/domain/repositories/login_validation.dart';

class EmailValidation implements Validate {
  @override
  String? error(String email) {
    if (email.isEmpty) {
      return 'Enter email please';
    }
    final RegExp emailRegExp =
        RegExp(r'^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Z|a-z]{2,}$');
    bool valid = emailRegExp.hasMatch(email);
    if (!valid) {
      return 'Not a valid email';
    }
    return null;
  }
}
