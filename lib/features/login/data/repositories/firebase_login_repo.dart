import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_chat/core/errors/firebase_errors.dart';
import 'package:firebase_chat/features/login/domain/entities/user_entity.dart';
import 'package:firebase_chat/features/login/domain/repositories/login_failures.dart';
import 'package:firebase_chat/features/login/domain/repositories/login_repo.dart';
import 'package:firebase_chat/init/initiators.dart';

import '../../../../core/errors/failure.dart';

class FirebaseLoginRepo implements LoginRepo {
  final FirebaseAuth _firebaseAuth;
  const FirebaseLoginRepo(this._firebaseAuth);

  @override
  Future<Either<Failure, UserEntity>> emailPasswordLogin(
    String email,
    String pass,
  ) async {
    try {
      var cred = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: pass,
      );
      if (cred.user == null) {
        return Left(NoUserFailure());
      }
      UserEntity userEntity =
          UserEntity(email: cred.user!.email!, id: cred.user!.uid);
      return Right(userEntity);
    } on FirebaseAuthException catch (e) {
      Failure failure = FirebaseErrors().getFailure(e.code);
      logger.e(failure);

      return Left(failure);
    } catch (e) {
      return Left(UnknownFailure(e));
    }
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
