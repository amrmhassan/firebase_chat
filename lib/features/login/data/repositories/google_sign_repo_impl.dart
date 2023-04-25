import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_chat/core/errors/failure.dart';
import 'package:firebase_chat/features/login/data/datasourses/user_mixins.dart';
import 'package:firebase_chat/features/login/domain/repositories/google_sign_repo.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../domain/repositories/login_failures.dart';
import '../models/user_model.dart';

class GoogleSignImpl with UserMixin implements GoogleSignRepo {
  @override
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
      // await saveUserToDB(userModel);
      return Right(userModel);
    } catch (e) {
      return Left(UnknownFailure(e));
    }
  }
}
