import 'package:firebase_chat/features/auth/data/models/user_model.dart';
import 'package:firebase_chat/core/errors/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_chat/features/auth/data/piping/auth_piping.dart';

class SignUpImpl extends AuthPiping {
  SignUpImpl(super.authDataSource);

  @override
  Future<Either<Failure, UserModel>> auth() {
    return handleErrors();
  }
}
