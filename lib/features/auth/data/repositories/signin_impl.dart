import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_chat/core/errors/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_chat/features/auth/data/datasourses/login_datasource.dart';
import 'package:firebase_chat/features/auth/data/models/user_model.dart';
import 'package:firebase_chat/features/auth/domain/repositories/login_repo.dart';

import '../../../../core/errors/firebase_errors.dart';

class SignInImpl implements LoginRepo {
  final LoginDatasource _loginDataSource;

  SignInImpl(this._loginDataSource);

  Future<Either<Failure, UserModel>> _realLogin() async {
    try {
      var res = await _loginDataSource.user();
      return res;
    } on FirebaseAuthException catch (e) {
      Failure failure = FirebaseErrors().getFailure(e.code);
      return Left(failure);
    } catch (e) {
      return Left(UnknownFailure(e));
    }
  }

  @override
  Future<Either<Failure, UserModel>> login() async {
    return _realLogin();
  }
}
