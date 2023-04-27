import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_chat/features/login/data/models/user_model.dart';
import 'package:firebase_chat/features/login/domain/repositories/signup_repo.dart';

import '../../../../core/errors/failure.dart';
import '../../../../core/errors/firebase_errors.dart';
import '../../../../init/initiators.dart';
import '../../domain/repositories/login_failures.dart';

class FirebaseSignupRepo implements SignUpRepo {
  final FirebaseAuth _firebaseAuth;

  const FirebaseSignupRepo(this._firebaseAuth);

  @override
  Future<Either<Failure, UserModel>> signUpWithEmailPassword(
    String email,
    String pass,
    String name,
  ) async {
    try {
      var cred = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: pass,
      );

      if (cred.user == null) {
        return Left(NoUserFailure());
      }
      UserModel userModel = UserModel(
        email: cred.user!.email!,
        uid: cred.user!.uid,
        name: name,
      );
      await cred.user!.updateDisplayName(name);
      // await saveUserToDB(userModel);

      return Right(userModel);
    } on FirebaseAuthException catch (e) {
      Failure failure = FirebaseErrors().getFailure(e.code);
      logger.e(failure);

      return Left(failure);
    } catch (e) {
      return Left(UnknownFailure(e));
    }
  }
}
