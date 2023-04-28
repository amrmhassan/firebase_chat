// ignore_for_file: prefer_const_constructors

import 'package:dartz/dartz.dart';
import 'package:firebase_chat/features/auth/data/models/user_model.dart';
import 'package:firebase_chat/features/auth/domain/repositories/auth_repo.dart';

import '../../../../core/errors/failure.dart';

abstract class LoginRepo implements AuthRepo {
  Future<Either<Failure, UserModel>> login();
}
