// ignore_for_file: prefer_const_constructors

import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_chat/core/constants/api_keys.dart';
import 'package:firebase_chat/core/constants/sign_provider.dart';
import 'package:firebase_chat/features/auth/data/models/user_model.dart';
import 'package:firebase_chat/features/auth/domain/repositories/signup_repo.dart';
import 'package:firebase_chat/transformers/apis.dart';

import '../../../../core/errors/failure.dart';
import '../../../../core/errors/firebase_errors.dart';
import '../../../../init/runtime_variables.dart';
import '../../domain/repositories/login_failures.dart';
import '../models/temp_mail_model.dart';

class FirebaseSignupRepo implements SignUpRepo {
  final FirebaseAuth _firebaseAuth;

  const FirebaseSignupRepo(this._firebaseAuth);

  Future<Either<Failure, Unit>> validateRealEmail(String email) async {
    TempMailModel testResult = await APITransformer.getDisposalEmail(
      apiKey: APIKeys.disposal_email_checker_api,
      email: email,
    );
    // check the test fields

    // first checking the score
    if (testResult.score < TempMailModel.minimumScore) {
      return Left(EmailIsTempFailure());
    }
    // check the deliverability
    else if (!testResult.deliverable) {
      return Left(EmailIsTempFailure());
    }
    // check disposability
    else if (testResult.disposal) {
      return Left(EmailIsTempFailure());
    }
    // email format might not be correct
    else if (testResult.autoCorrect.isNotEmpty) {
      return Left(EmailIsTempFailure());
    }
    // nothing check
    else if (testResult.mail != email) {
      return Left(EmailIsTempFailure());
    }
    return Right(unit);
  }

  @override
  Future<Either<Failure, UserModel>> signUpWithEmailPassword(
    String email,
    String pass,
    String name,
  ) async {
    try {
      var res = (await validateRealEmail(email)).fold((l) => l, (r) => r);
      if (res is Failure) {
        return Left(res);
      }
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
        accessToken: null,
        provider: SignProvidersConstants.email,
        providerId: cred.additionalUserInfo?.providerId,
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
