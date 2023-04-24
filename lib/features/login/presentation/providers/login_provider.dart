import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_chat/core/errors/failure.dart';
import 'package:firebase_chat/features/login/data/repositories/firebase_login_repo.dart';
import 'package:firebase_chat/features/login/domain/entities/user_entity.dart';
import 'package:firebase_chat/features/login/domain/repositories/login_failures.dart';
import 'package:firebase_chat/features/login/domain/usecases/login_usecase.dart';
import 'package:flutter/material.dart';

class LoginProvider extends ChangeNotifier {
  bool logging = false;
  String? _email;
  String? _pass;

  void setEmail(String e) {
    _email = e;
    notifyListeners();
  }

  void setPassword(String p) {
    _pass = p;
    notifyListeners();
  }

  Future<Either<Failure, UserEntity>> login() async {
    if (_email == null || _pass == null) return Left(EmptyCredFailures());
    logging = true;
    notifyListeners();

    var res = await LoginUseCase(FirebaseLoginRepo(FirebaseAuth.instance))
        .call(_email!, _pass!);

    logging = false;
    notifyListeners();
    return res;
  }
}
