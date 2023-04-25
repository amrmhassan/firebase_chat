import 'package:firebase_chat/core/errors/failure.dart';
import 'package:firebase_chat/features/login/data/models/user_model.dart';
import 'package:firebase_chat/features/login/domain/repositories/login_repo.dart';
import 'package:dartz/dartz.dart';

class LoginUseCase {
  final LoginRepo _loginRepo;

  const LoginUseCase(this._loginRepo);

  Future<Either<Failure, UserModel>> call(String email, String pass) async {
    return _loginRepo.emailPasswordLogin(email, pass);
  }
}
