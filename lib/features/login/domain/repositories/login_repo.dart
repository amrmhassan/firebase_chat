import 'package:dartz/dartz.dart';
import 'package:firebase_chat/features/login/data/models/user_model.dart';

import '../../../../core/errors/failure.dart';

abstract class LoginRepo {
  Future<Either<Failure, UserModel>> emailPasswordLogin(
    String email,
    String pass,
  );
  Future<Either<Failure, Unit>> logout();
  Future<Either<Failure, bool>> isSignedIn();
}
