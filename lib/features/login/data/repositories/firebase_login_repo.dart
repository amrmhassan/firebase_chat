import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_chat/core/errors/firebase_errors.dart';
import 'package:firebase_chat/features/login/data/datasourses/user_mixins.dart';
import 'package:firebase_chat/features/login/data/models/user_model.dart';
import 'package:firebase_chat/features/login/domain/repositories/login_failures.dart';
import 'package:firebase_chat/features/login/domain/repositories/login_repo.dart';
import 'package:firebase_chat/init/initiators.dart';

import '../../../../core/errors/failure.dart';

class FirebaseLoginRepo with UserMixin implements LoginRepo {
  final FirebaseAuth _firebaseAuth;
  const FirebaseLoginRepo(this._firebaseAuth);

  @override
  Future<Either<Failure, UserModel>> emailPasswordLogin(
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

      UserModel userEntity = await getUserByEmail(email);

      return Right(userEntity);
    } on FirebaseAuthException catch (e) {
      Failure failure = FirebaseErrors().getFailure(e.code);
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
