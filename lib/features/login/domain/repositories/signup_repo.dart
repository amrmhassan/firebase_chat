import 'package:dartz/dartz.dart';
import 'package:firebase_chat/features/login/data/models/user_model.dart';

import '../../../../core/errors/failure.dart';

abstract class SignUpRepo {
  Future<Either<Failure, UserModel>> signUpWithEmailPassword(
    String email,
    String password,
    String name,
  );
}
