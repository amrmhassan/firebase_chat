import 'package:firebase_chat/core/errors/failure.dart';
import 'package:firebase_chat/features/login/data/models/user_model.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_chat/features/login/domain/repositories/signup_repo.dart';

class SignupUseCase {
  final SignUpRepo _loginRepo;

  const SignupUseCase(this._loginRepo);

  Future<Either<Failure, UserModel>> call(
      String email, String pass, String name) async {
    return _loginRepo.signUpWithEmailPassword(email, pass, name);
  }
}
