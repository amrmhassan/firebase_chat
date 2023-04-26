import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_chat/features/login/data/models/user_model.dart';
import 'package:firebase_chat/core/errors/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_chat/features/login/domain/repositories/login_failures.dart';
import 'package:firebase_chat/features/login/domain/repositories/login_repo.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

class FacebookSignImpl extends LoginRepo {
  @override
  Future<Either<Failure, UserCredential>> getCred() async {
    var facebookUser = await FacebookAuth.instance.login();
    if (facebookUser.accessToken == null) {
      return Left(FacebookAuthNotGranted());
    }
    var facebookCred =
        FacebookAuthProvider.credential(facebookUser.accessToken!.token);

    var cred = await FirebaseAuth.instance.signInWithCredential(facebookCred);
    return Right(cred);
  }
}
