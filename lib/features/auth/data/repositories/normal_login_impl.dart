import 'package:firebase_chat/features/auth/data/models/user_model.dart';
import 'package:firebase_chat/core/errors/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_chat/features/auth/domain/repositories/login_repo.dart';

class NormalLoginImpl implements LoginRepo {
  @override
  Future<Either<Failure, UserModel>> login() {
    throw UnimplementedError();
  }
}
