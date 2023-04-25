import 'package:dartz/dartz.dart';
import 'package:firebase_chat/features/login/domain/entities/user_entity.dart';

import '../../../../core/errors/failure.dart';

abstract class SignUpRepo {
  Future<Either<Failure, UserEntity>> signUpWithEmailPassword(
    String email,
    String password,
    String name,
  );
}
