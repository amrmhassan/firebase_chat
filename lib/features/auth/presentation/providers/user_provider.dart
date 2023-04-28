import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_chat/core/errors/failure.dart';
import 'package:firebase_chat/core/hive/hive_helper.dart';
import 'package:firebase_chat/features/auth/data/models/user_model.dart';
import 'package:firebase_chat/features/auth/data/repositories/signin_impl.dart';
import 'package:firebase_chat/features/auth/data/repositories/signup_impl.dart';
import 'package:firebase_chat/features/auth/domain/repositories/login_failures.dart';
import 'package:firebase_chat/features/auth/data/piping/auth_piping.dart';
import 'package:firebase_chat/features/auth/domain/repositories/login_validation.dart';
import 'package:firebase_chat/init/runtime_variables.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../data/datasourses/remote_datasource.dart';
import '../../data/repositories/validation_impl.dart';

enum AuthType {
  facebook,
  google,
  signup,
  emailLogin,
}

class UserProvider extends ChangeNotifier {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();

  bool loggingIn = false;
  UserModel? userModel;

  // i should have a function here that accepts an Auth  class
  // auth(AuthProvider) this auth provider might be loginRepo class or signUpRepo class
  // and this function will just return either a failure or a userModel
  // this is just to unify data sources and apply the pipelines concept

  // the repos available now are LoginRepo, SignUpRepo or NormalLoginImpl
  Future<Either<Failure, UserModel>> auth(AuthType authType) async {
    _setLoggedButtonClicked(true);
    loggingIn = true;
    notifyListeners();

    // this repo must be at first because it's already a kind of LoginRepo
    late Either<Failure, UserModel> res;
    if (authType == AuthType.emailLogin) {
      res = await _normalLogin();
    } else if (authType == AuthType.facebook) {
      res = await _signIn(SignInImpl(FacebookLoginDataSource()));
    } else if (authType == AuthType.google) {
      res = await _signIn(SignInImpl(GoogleLoginDataSource()));
    } else if (authType == AuthType.signup) {
      res = await _signUp();
      // the remaining one is the normal login repo
    } else {
      res = Left(NoAuthMethodProvidedFailure());
    }

    loggingIn = false;
    notifyListeners();

    var data = res.fold((l) => l, (r) => r);
    if (data is UserModel) {
      userModel = data;
      notifyListeners();
      await _saveCurrentUserInfo(userModel!);
    }

    return res;
  }

  //# user auth related methods
  Future<Either<Failure, UserModel>> _normalLogin() async {
    _setLoggedButtonClicked(true);
    validateEntry(EmailValidation(), emailController.text);
    validateEntry(PasswordValidation(), passwordController.text);

    if (!_allowLogin) {
      loggingIn = false;
      notifyListeners();
      return left(ValidationFailure());
    }

    String email = emailController.text;
    String password = passwordController.text;

    if (email.isEmpty || password.isEmpty) return Left(EmptyCredFailures());
    return _signIn(
      SignInImpl(
        EmailLoginDataSource(
          FirebaseAuth.instance,
          email,
          password,
        ),
      ),
    );
  }

  Future<Either<Failure, UserModel>> _signUp() async {
    String email = emailController.text;
    String password = passwordController.text;
    String name = nameController.text;
    validateEntry(EmailValidation(), emailController.text);
    validateEntry(PasswordValidation(), passwordController.text);
    validateEntry(NameValidation(), nameController.text);

    if (!_allowSignUp) {
      loggingIn = false;
      notifyListeners();
      return Left(ValidationFailure());
    }

    if (email.isEmpty || password.isEmpty || name.isEmpty) {
      loggingIn = false;
      notifyListeners();
      return Left(EmptyCredFailures());
    }

    // var res = await FirebaseSignupRepo(FirebaseAuth.instance)
    //     .signUpWithEmailPassword(email, password, name);
    var res = await SignUpImpl(EmailSignupDataSource(
      email: email,
      name: name,
      pass: password,
      firebaseAuth: FirebaseAuth.instance,
    )).auth();

    return res;
  }

  Future<Either<Failure, UserModel>> _signIn(AuthPiping repo) async {
    var res = await repo.auth();

    return res;
  }

  Future<void> logout() async {
    _setLoggedButtonClicked(false);
    final GoogleSignIn googleSignIn = GoogleSignIn();
    await FirebaseAuth.instance.signOut();
    await googleSignIn.signOut();

    // facebook logout
    await FacebookAuth.instance.logOut();

    // delete saved user data
    await _deleteCurrentUserInfo();
  }

  //# saved user info related methods
  Future<void> _saveCurrentUserInfo(UserModel userModel) async {
    var box = await HiveBox.currentUser;
    await box.put(userModel.uid, userModel);
  }

  Future<void> _deleteCurrentUserInfo() async {
    var box = await HiveBox.currentUser;
    await box.clear();
  }

  Future<void> loadCurrentUserInfo() async {
    try {
      var box = await HiveBox.currentUser;
      var data = box.values.first as UserModel;
      userModel = data;
      notifyListeners();
    } catch (e) {
      logger.e(e);
    }
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
