import 'package:dartz/dartz.dart';
import 'package:firebase_chat/core/errors/failure.dart';
import 'package:firebase_chat/features/login/data/models/user_model.dart';

import '../repositories/google_sign_repo.dart';

class GoogleSignUseCase {
  final GoogleSignRepo _googleSign;

  const GoogleSignUseCase(this._googleSign);
  Future<Either<Failure, UserModel>> call() async {
    return await _googleSign.sign();
  }
}
