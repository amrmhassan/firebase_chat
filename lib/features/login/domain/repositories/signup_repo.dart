import 'package:firebase_chat/features/login/domain/entities/user_entity.dart';

abstract class SignUpRepo {
  Future<UserEntity> signUpWithEmailPassword(
    String email,
    String password,
    String name,
  );
}
