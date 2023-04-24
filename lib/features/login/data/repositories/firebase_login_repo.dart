import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_chat/features/login/domain/entities/user_entity.dart';
import 'package:firebase_chat/features/login/domain/repositories/login_repo.dart';

import '../../../../core/errors/failure.dart';

class FirebaseLoginRepo implements LoginRepo {
  final FirebaseAuth _firebaseAuth;
  const FirebaseLoginRepo(this._firebaseAuth);

  @override
  Future<Either<Failure, UserEntity>> emailPasswordLogin(
      String email, String pass) async {
    var cred = await _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: pass,
    );
    if (cred.user == null) {
      throw Exception('User is not available');
    }
    UserEntity userEntity =
        UserEntity(email: cred.user!.email!, id: cred.user!.uid);
    return Right(userEntity);
  }

  @override
  Future<Either<Failure, bool>> isSignedIn() async {
    bool res = _firebaseAuth.currentUser != null;
    return Right(res);
  }

  @override
  Future<Either<Failure, Unit>> logout() async {
    await _firebaseAuth.signOut();
    return const Right(unit);
  }
}
