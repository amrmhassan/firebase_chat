// ignore_for_file: prefer_const_constructors

import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_chat/features/auth/domain/repositories/auth_repo.dart';

import '../../../../core/errors/failure.dart';
import '../../../../core/errors/firebase_errors.dart';
import '../datasourses/auth_datasource.dart';
import '../models/user_model.dart';

abstract class AuthPiping implements AuthRepo {
  final AuthDatasource _authDataSource;

  AuthPiping(this._authDataSource);

  Future<Either<Failure, UserModel>> handleErrors() async {
    try {
      var res = await _authDataSource.user();
      return res;
    } on FirebaseAuthException catch (e) {
      Failure failure = FirebaseErrors().getFailure(e.code);
      return Left(failure);
    } catch (e) {
      return Left(UnknownFailure(e));
    }
  }
}
