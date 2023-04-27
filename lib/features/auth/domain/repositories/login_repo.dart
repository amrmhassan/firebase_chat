// ignore_for_file: prefer_const_constructors

import 'package:dartz/dartz.dart';
import 'package:firebase_chat/features/auth/data/models/user_model.dart';

import '../../../../core/errors/failure.dart';

abstract class LoginRepo {
  Future<Either<Failure, UserModel>> login();
}
