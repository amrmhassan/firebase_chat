import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_chat/core/errors/failure.dart';
import 'package:firebase_chat/features/login/data/repositories/firebase_login_repo.dart';
import 'package:firebase_chat/features/login/domain/entities/user_entity.dart';
import 'package:firebase_chat/features/login/domain/repositories/login_failures.dart';
import 'package:firebase_chat/features/login/domain/usecases/login_usecase.dart';
import 'package:flutter/material.dart';

class LoginProvider extends ChangeNotifier {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();

  bool logging = false;

  Future<Either<Failure, UserEntity>> login() async {
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
}
