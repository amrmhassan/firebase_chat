import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_chat/core/errors/failure.dart';
import 'package:firebase_chat/features/auth/data/datasourses/auth_inputs_datasource.dart';
import 'package:firebase_chat/features/auth/data/models/user_model.dart';
import 'package:firebase_chat/features/auth/data/repositories/signin_impl.dart';
import 'package:firebase_chat/features/auth/data/repositories/signup_impl.dart';
import 'package:firebase_chat/features/auth/data/repositories/user_mixin.dart';
import 'package:firebase_chat/features/auth/domain/repositories/login_failures.dart';
import 'package:firebase_chat/features/auth/data/piping/auth_piping.dart';
import 'package:firebase_chat/init/user_info.dart';
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

class UserProvider extends ChangeNotifier with UserMixin {
  late AuthInputsDatasource authInputsDS;
  UserProvider() {
    authInputsDS = AuthInputsDatasource(notifyListeners);
  }

  bool loggingIn = false;

  // i should have a function here that accepts an Auth  class
  // auth(AuthProvider) this auth provider might be loginRepo class or signUpRepo class
  // and this function will just return either a failure or a userModel
  // this is just to unify data sources and apply the pipelines concept

  // the repos available now are LoginRepo, SignUpRepo or NormalLoginImpl
  Future<Either<Failure, UserModel>> auth(AuthType authType) async {
    authInputsDS.setLoggedButtonClicked(true);
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
      notifyListeners();
      await saveUserToDb(data);
      await CUserInfo.saveCurrentUserInfo(data);
    }

    return res;
  }

  //# user auth related methods
  Future<Either<Failure, UserModel>> _normalLogin() async {
    authInputsDS.setLoggedButtonClicked(true);
    authInputsDS.validateEntry(EmailValidation());
    authInputsDS.validateEntry(PasswordValidation());

    if (!authInputsDS.allowLogin) {
      loggingIn = false;
      notifyListeners();
      return left(ValidationFailure());
    }

    String email = authInputsDS.mailController.text;
    String password = authInputsDS.passController.text;

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
    String email = authInputsDS.mailController.text;
    String password = authInputsDS.passController.text;
    String name = authInputsDS.nameController.text;
    authInputsDS.validateEntry(EmailValidation());
    authInputsDS.validateEntry(PasswordValidation());
    authInputsDS.validateEntry(NameValidation());

    if (!authInputsDS.allowSignUp) {
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
    authInputsDS.setLoggedButtonClicked(false);
    final GoogleSignIn googleSignIn = GoogleSignIn();
    await FirebaseAuth.instance.signOut();
    await googleSignIn.signOut();

    // facebook logout
    await FacebookAuth.instance.logOut();

    // delete saved user data
    // await _deleteCurrentUserInfo();
    await CUserInfo.deleteCurrentUserInfo();
  }

  //# saved user info related methods
  // Future<void> _saveCurrentUserInfo(UserModel userModel) async {
  //   var box = await HiveBox.currentUser;
  //   await box.put(userModel.uid, userModel);
  // }

  // Future<void> _deleteCurrentUserInfo() async {
  //   var box = await HiveBox.currentUser;
  //   await box.clear();
  // }

  // Future<void> loadCurrentUserInfo() async {
  //   try {
  //     var box = await HiveBox.currentUser;
  //     if (box.values.isEmpty) return;
  //     var data = box.values.first as UserModel;
  //     userModel = data;
  //     notifyListeners();
  //   } catch (e) {
  //     logger.e(e);
  //   }
  // }
}
