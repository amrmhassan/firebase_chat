import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_chat/core/errors/failure.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../../../core/errors/firebase_errors.dart';
import '../../domain/repositories/login_failures.dart';
import '../models/user_model.dart';

class GoogleSignImpl {
  Future<Either<Failure, UserModel>> sign() async {
    try {
      GoogleSignIn googleSignIn = GoogleSignIn();
      var googleUser = await googleSignIn.signIn();
      if (googleUser == null) {
        return left(NotSignedInWithGoogleFailure());
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      final auth = FirebaseAuth.instance;
      final userCredential = await auth.signInWithCredential(credential);
      final user = userCredential.user;
      if (user == null) {
        return Left(NoUserFailure());
      }
      if (user.email == null || user.displayName == null) {
        return Left(InsufficientGoogleInfoFailure());
      }
      UserModel userModel = UserModel(
        email: user.email!,
        name: user.displayName!,
        uid: user.uid,
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
