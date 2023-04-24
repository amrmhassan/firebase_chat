import 'package:dartz/dartz.dart';
import 'package:firebase_chat/features/login/domain/entities/user_entity.dart';

import '../../../../core/errors/failure.dart';

abstract class LoginRepo {
  Future<Either<Failure, UserEntity>> emailPasswordLogin(
    String email,
    String pass,
  );
  Future<Either<Failure, Unit>> logout();
  Future<Either<Failure, bool>> isSignedIn();
}
