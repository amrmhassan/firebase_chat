import 'package:dartz/dartz.dart';
import 'package:firebase_chat/features/auth/data/models/user_model.dart';
import 'package:firebase_chat/features/auth/domain/repositories/auth_repo.dart';

import '../../../../core/errors/failure.dart';

abstract class SignUpRepo implements AuthRepo {
  Future<Either<Failure, UserModel>> signUpWithEmailPassword(
    String email,
    String password,
    String name,
  );
}
