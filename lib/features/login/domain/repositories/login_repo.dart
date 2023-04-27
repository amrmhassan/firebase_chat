// ignore_for_file: prefer_const_constructors

import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_chat/features/login/data/models/user_model.dart';
import 'package:firebase_chat/features/login/domain/repositories/login_failures.dart';

import '../../../../core/errors/failure.dart';
import '../../../../core/errors/firebase_errors.dart';

abstract class LoginRepo {
  Future<Either<Failure, UserModel>> login();

  Future<Either<Failure, UserCredential>> getCred();
}
