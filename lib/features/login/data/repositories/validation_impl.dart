import '../../domain/repositories/login_validation.dart';

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
