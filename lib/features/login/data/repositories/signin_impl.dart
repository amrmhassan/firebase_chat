import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_chat/core/errors/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_chat/features/login/data/datasourses/login_datasource.dart';
import 'package:firebase_chat/features/login/data/models/user_model.dart';
import 'package:firebase_chat/features/login/domain/repositories/login_failures.dart';
import 'package:firebase_chat/features/login/domain/repositories/login_repo.dart';

import '../../../../core/errors/firebase_errors.dart';

class SignInImpl implements LoginRepo {
  final LoginDataSource _loginDataSource;

  SignInImpl(this._loginDataSource);

  @override
  Future<Either<Failure, UserCredential>> getCred() async {
    var cred = await _loginDataSource.getCred();
    if (cred == null) {
      return Left(AuthPermissionNotGranted());
    }
    return Right(cred);
  }

  @override
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
}
