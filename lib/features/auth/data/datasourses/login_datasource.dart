import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_chat/features/auth/data/models/user_model.dart';

abstract class LoginDatasource {
  Future<UserCredential?> getCred();
  Future<UserModel> getTestUser();
}
