import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_chat/features/login/data/repositories/firebase_login_repo.dart';
import 'package:flutter/material.dart';

class LoginProvider extends ChangeNotifier {
  Future<void> login(String email, String pass) async {
    FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    FirebaseLoginRepo firebaseLoginRepo = FirebaseLoginRepo(firebaseAuth);
    await firebaseLoginRepo.emailPasswordLogin(email, pass);
  }
}
