import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_chat/features/login/domain/repositories/login_repo.dart';

import '../../../../core/errors/failure.dart';

class FirebaseLoginRepo extends LoginRepo {
  final FirebaseAuth _firebaseAuth;
  final String? email;
  final String? pass;

  FirebaseLoginRepo(
    this._firebaseAuth, [
    this.email,
    this.pass,
  ]);

  Future<UserCredential> _emailPasswordLogin() async {
    if (email == null || pass == null) {
      throw Exception('Email or password is null');
    }
    var cred = await _firebaseAuth.signInWithEmailAndPassword(
      email: email!,
      password: pass!,
    );

    return cred;
  }

  @override
  Future<Either<Failure, UserCredential>> getCred() async {
    return Right(await _emailPasswordLogin());
  }
}
