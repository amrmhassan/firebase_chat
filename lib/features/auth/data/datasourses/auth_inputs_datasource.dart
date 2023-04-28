import 'package:flutter/material.dart';

import '../../domain/repositories/login_validation.dart';
import '../repositories/validation_impl.dart';

class AuthInputsDatasource {
  final VoidCallback notifyListeners;
  AuthInputsDatasource(this.notifyListeners);

  final TextEditingController mailController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController passController = TextEditingController();

  String? emailError;
  String? nameError;
  String? passwordError;

  bool _loggedButtonClicked = false;

  void setLoggedButtonClicked(bool b) {
    _loggedButtonClicked = b;
  }

  void validateEntry(Validate validate) {
    if (!_loggedButtonClicked) return;
    String? value;
    if (validate is EmailValidation) {
      value = mailController.text;
    } else if (validate is NameValidation) {
      value = nameController.text;
    } else if (validate is PasswordValidation) {
      value = passController.text;
    }
    if (value == null) return;
    String? error = validate.error(value);
    if (validate is EmailValidation) {
      emailError = error;
    } else if (validate is NameValidation) {
      nameError = error;
    } else if (validate is PasswordValidation) {
      passwordError = error;
    }
    notifyListeners();
  }

  bool get allowLogin {
    return emailError == null && passwordError == null;
  }

  bool get allowSignUp {
    return emailError == null && passwordError == null && nameError == null;
  }
}
