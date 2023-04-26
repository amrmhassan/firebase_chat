// ignore_for_file: prefer_const_constructors

import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_chat/features/login/data/models/user_model.dart';
import 'package:firebase_chat/features/login/domain/repositories/login_failures.dart';

import '../../../../core/errors/failure.dart';
import '../../../../core/errors/firebase_errors.dart';

abstract class LoginRepo {
  Future<Either<Failure, UserModel>> login() async {
    try {
      var res = (await getCred()).fold((l) => l, (r) => r);
      if (res is Failure) {
        return Left(res);
      }
      var cred = res as UserCredential;

      final user = cred.user;
      if (user == null) {
        return Left(NoUserFailure());
      }
      if (user.email == null || user.displayName == null) {
        return Left(InsufficientGoogleInfoFailure());
      }
      UserModel userModel = UserModel(
        email: user.email!,
        name: user.displayName!,
        uid: user.uid,
      );
      return Right(userModel);
    } on FirebaseAuthException catch (e) {
      Failure failure = FirebaseErrors().getFailure(e.code);
      return Left(failure);
    } catch (e) {
      return Left(UnknownFailure(e));
    }
  }

  Future<Either<Failure, UserCredential>> getCred();
}
