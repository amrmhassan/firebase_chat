// ignore_for_file: prefer_const_constructors

import 'package:dartz/dartz.dart';
import 'package:firebase_chat/features/login/data/models/user_model.dart';
import 'package:firebase_chat/features/login/domain/repositories/login_failures.dart';

import '../../../../core/errors/failure.dart';

class LoginRepo {
  Future<Either<Failure, UserModel>> emailPasswordLogin([
    String? email,
    String? pass,
  ]) async {
    return Left(NoUserFailure());
  }

  Future<Either<Failure, Unit>> logout() async {
    return Right(unit);
  }

  Future<Either<Failure, bool>> isSignedIn() async {
    return Right(false);
  }

  void test() {
    print(runtimeType);
  }
}
