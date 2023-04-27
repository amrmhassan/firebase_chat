import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_chat/core/errors/failure.dart';
import 'package:firebase_chat/features/login/data/models/user_model.dart';
import 'package:firebase_chat/features/login/data/repositories/firebase_signup_repo.dart';
import 'package:firebase_chat/features/login/data/repositories/signin_impl.dart';
import 'package:firebase_chat/features/login/domain/repositories/login_failures.dart';
import 'package:firebase_chat/features/login/domain/repositories/login_repo.dart';
import 'package:firebase_chat/features/login/domain/repositories/login_validation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../data/datasourses/login_datasource.dart';
import '../../data/repositories/validation_impl.dart';

class UserProvider extends ChangeNotifier {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();

  bool logging = false;
  UserModel? userModel;

  Future<Either<Failure, UserModel>> normalLogin() async {
    _setLoggedButtonClicked(true);
    validateEntry(EmailValidation(), emailController.text);
    validateEntry(PasswordValidation(), passwordController.text);

    if (!_allowLogin) {
      logging = false;
      notifyListeners();
      return left(ValidationFailure());
    }

    String email = emailController.text;
    String password = passwordController.text;

    if (email.isEmpty || password.isEmpty) return Left(EmptyCredFailures());
    return signIn(SignInImpl(EmailLoginDataSource(FirebaseAuth.instance)));
  }

  Future<Either<Failure, UserModel>> signUp() async {
    _setLoggedButtonClicked(true);
    String email = emailController.text;
    String password = passwordController.text;
    String name = nameController.text;
    validateEntry(EmailValidation(), emailController.text);
    validateEntry(PasswordValidation(), passwordController.text);
    validateEntry(NameValidation(), nameController.text);

    if (!_allowSignUp) {
      logging = false;
      notifyListeners();
      return left(ValidationFailure());
    }

    if (email.isEmpty || password.isEmpty || name.isEmpty) {
      return Left(EmptyCredFailures());
    }
    logging = true;
    notifyListeners();

    var res = FirebaseSignupRepo(FirebaseAuth.instance)
        .signUpWithEmailPassword(email, password, name);

    logging = false;
    notifyListeners();
    return res;
  }

  Future<Either<Failure, UserModel>> signIn(LoginRepo repo) async {
    logging = true;
    notifyListeners();

    var res = await repo.login();

    logging = false;
    notifyListeners();
    return res;
  }

  Future<void> logout() async {
    _setLoggedButtonClicked(false);
    final GoogleSignIn googleSignIn = GoogleSignIn();
    await FirebaseAuth.instance.signOut();
    await googleSignIn.signOut();

    // facebook logout
    await FacebookAuth.instance.logOut();
  }

  //# validation
  String? emailError;
  String? nameError;
  String? passwordError;

  bool _loggedButtonClicked = false;

  void _setLoggedButtonClicked(bool b) {
    _loggedButtonClicked = b;
  }

  void validateEntry(Validate validate, String value) {
    if (!_loggedButtonClicked) return;

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

  bool get _allowLogin {
    return emailError == null && passwordError == null;
  }

  bool get _allowSignUp {
    return emailError == null && passwordError == null && nameError == null;
  }
}
