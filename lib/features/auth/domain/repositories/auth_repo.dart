import 'package:dartz/dartz.dart';

import '../../../../core/errors/failure.dart';
import '../../data/models/user_model.dart';

abstract class AuthRepo {
  Future<Either<Failure, UserModel>> auth();
}
