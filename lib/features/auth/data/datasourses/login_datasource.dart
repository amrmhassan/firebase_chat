import 'package:dartz/dartz.dart';
import 'package:firebase_chat/core/errors/failure.dart';
import 'package:firebase_chat/features/auth/data/models/user_model.dart';

abstract class AuthDatasource {
  Future<Either<Failure, UserModel>> user();
}
