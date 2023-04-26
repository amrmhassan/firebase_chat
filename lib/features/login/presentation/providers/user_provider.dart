import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_chat/core/errors/failure.dart';
import 'package:firebase_chat/features/login/data/datasourses/user_mixins.dart';
import 'package:firebase_chat/features/login/data/models/user_model.dart';
import 'package:firebase_chat/features/login/data/repositories/email_validation.dart';
import 'package:firebase_chat/features/login/data/repositories/firebase_login_repo.dart';
import 'package:firebase_chat/features/login/data/repositories/firebase_signup_repo.dart';
import 'package:firebase_chat/features/login/data/repositories/google_sign_repo_impl.dart';
import 'package:firebase_chat/features/login/domain/repositories/login_failures.dart';
import 'package:firebase_chat/features/login/domain/usecases/google_sign_usecase.dart';
import 'package:firebase_chat/features/login/domain/usecases/login_usecase.dart';
import 'package:firebase_chat/features/login/domain/usecases/signup_usecase.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../data/repositories/name_validation.dart';
import '../../data/repositories/password_validation.dart';

class UserProvider extends ChangeNotifier with UserMixin {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();

  bool logging = false;
  UserModel? userModel;

  Future<Either<Failure, UserModel>> login() async {
    _setLoggedButtonClicked(true);
    validateEmail();
    validatePassword();

    if (!_allowLogin) {
      logging = false;
      notifyListeners();
      return left(ValidationFailure());
    }

    String email = emailController.text;
    String password = passwordController.text;

    if (email.isEmpty || password.isEmpty) return Left(EmptyCredFailures());
    logging = true;
    notifyListeners();

    var res = await LoginUseCase(FirebaseLoginRepo(FirebaseAuth.instance))
        .call(email, password);

    logging = false;
    notifyListeners();
    return res;
  }

  Future<Either<Failure, UserModel>> signUp() async {
    _setLoggedButtonClicked(true);
    String email = emailController.text;
    String password = passwordController.text;
    String name = nameController.text;
    validateEmail();
    validatePassword();
    validateName();

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

    var res = await SignupUseCase(FirebaseSignupRepo(FirebaseAuth.instance))
        .call(email, password, name);

    logging = false;
    notifyListeners();
    return res;
  }

  Future<Either<Failure, UserModel>> googleSignIn() async {
    logging = true;
    notifyListeners();

    var res = await GoogleSignUseCase(GoogleSignImpl()).call();

    logging = false;
    notifyListeners();
    return res;
  }

  Future<void> logout() async {
    _setLoggedButtonClicked(false);
    final GoogleSignIn googleSignIn = GoogleSignIn();

    await FirebaseLoginRepo(FirebaseAuth.instance).logout();
    await googleSignIn.signOut();
  }

  //# validation
  String? emailError;
  String? nameError;
  String? passwordError;

  bool _loggedButtonClicked = false;

  void _setLoggedButtonClicked(bool b) {
    _loggedButtonClicked = b;
  }

  void validateEmail() {
    if (!_loggedButtonClicked) return;

    String email = emailController.text;
    emailError = EmailValidation().error(email);
    notifyListeners();
  }

  void validatePassword() {
    if (!_loggedButtonClicked) return;

    String password = passwordController.text;
    passwordError = PasswordValidation().error(password);
    notifyListeners();
  }

  void validateName() {
    if (!_loggedButtonClicked) return;

    String name = nameController.text;
    nameError = NameValidation().error(name);
    notifyListeners();
  }

  bool get _allowLogin {
    return emailError == null && passwordError == null;
  }

  bool get _allowSignUp {
    return emailError == null && passwordError == null && nameError == null;
  }
}
