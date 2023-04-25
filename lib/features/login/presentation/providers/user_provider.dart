import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_chat/core/errors/failure.dart';
import 'package:firebase_chat/features/login/data/datasourses/user_mixins.dart';
import 'package:firebase_chat/features/login/data/models/user_model.dart';
import 'package:firebase_chat/features/login/data/repositories/firebase_login_repo.dart';
import 'package:firebase_chat/features/login/data/repositories/firebase_signup_repo.dart';
import 'package:firebase_chat/features/login/data/repositories/google_sign_repo_impl.dart';
import 'package:firebase_chat/features/login/domain/repositories/login_failures.dart';
import 'package:firebase_chat/features/login/domain/usecases/google_sign_usecase.dart';
import 'package:firebase_chat/features/login/domain/usecases/login_usecase.dart';
import 'package:firebase_chat/features/login/domain/usecases/signup_usecase.dart';
import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier with UserMixin {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();

  bool logging = false;
  UserModel? userModel;

  // this uses user model by uid
  Future<void> loadUserModel(String uid) async {
    userModel = await getUserByUID(uid);
    notifyListeners();
  }

  Future<Either<Failure, UserModel>> login() async {
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
    String email = emailController.text;
    String password = passwordController.text;
    String name = nameController.text;

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
    await FirebaseLoginRepo(FirebaseAuth.instance).logout();
  }
}
