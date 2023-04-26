import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_chat/features/login/data/models/user_model.dart';
import 'package:firebase_chat/core/errors/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_chat/features/login/domain/repositories/login_failures.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

import '../../../../core/errors/firebase_errors.dart';

class FacebookSignImpl {
  Future<Either<Failure, UserModel>> sign() async {
    try {
      var facebookUser = await FacebookAuth.instance.login();
      if (facebookUser.accessToken == null) {
        return Left(FacebookAuthNotGranted());
      }
      var facebookCred =
          FacebookAuthProvider.credential(facebookUser.accessToken!.token);

      var cred = await FirebaseAuth.instance.signInWithCredential(facebookCred);
      User? firebaseUser = cred.user;
      if (firebaseUser == null) {
        return Left(NoUserFailure());
      }
      if (firebaseUser.email == null || firebaseUser.displayName == null) {
        return Left(InsufficientFacebookInfoFailure());
      }
      UserModel userModel = UserModel(
        email: firebaseUser.email!,
        name: firebaseUser.displayName!,
        uid: firebaseUser.uid,
      );
      return Right(userModel);
    } on FirebaseAuthException catch (e) {
      Failure failure = FirebaseErrors().getFailure(e.code);
      return Left(failure);
    } catch (e) {
      return Left(UnknownFailure(e));
    }
  }
}
