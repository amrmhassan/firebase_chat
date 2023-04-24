import 'package:firebase_chat/core/errors/failure.dart';
import 'package:firebase_chat/features/login/domain/entities/user_entity.dart';
import 'package:firebase_chat/features/login/domain/repositories/login_repo.dart';
import 'package:dartz/dartz.dart';

class LoginUseCase {
  final LoginRepo _loginRepo;

  const LoginUseCase(this._loginRepo);

  Future<Either<Failure, UserEntity>> call(String email, String pass) async {
    return _loginRepo.emailPasswordLogin(email, pass);
  }
}
