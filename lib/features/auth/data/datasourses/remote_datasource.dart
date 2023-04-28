// ignore_for_file: prefer_const_constructors

import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_chat/core/errors/failure.dart';
import 'package:firebase_chat/features/auth/data/datasourses/login_datasource.dart';
import 'package:firebase_chat/features/auth/data/models/user_model.dart';
import 'package:firebase_chat/features/auth/domain/repositories/login_failures.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../../../core/constants/api_keys.dart';
import '../../../../core/constants/sign_provider.dart';
import '../../../../core/errors/firebase_errors.dart';
import '../../../../init/runtime_variables.dart';
import '../../../../transformers/apis.dart';
import '../models/temp_mail_model.dart';

abstract class RemoteDataSource implements AuthDatasource {}

class FacebookLoginDataSource implements RemoteDataSource {
  @override
  Future<Either<Failure, UserModel>> user() async {
    var facebookUser = await FacebookAuth.instance.login();
    if (facebookUser.accessToken == null) {
      return Left(AuthPermissionNotGranted());
    }
    var facebookCred =
        FacebookAuthProvider.credential(facebookUser.accessToken!.token);

    var cred = await FirebaseAuth.instance.signInWithCredential(facebookCred);
    var user = cred.user;
    if (user == null) {
      return Left(NoUserFailure());
    }
    if (user.providerData.first.email == null || user.displayName == null) {
      return Left(InsufficientGoogleInfoFailure());
    }
    if (facebookUser.accessToken == null) {
      return Left(AuthPermissionNotGranted());
    }

    UserModel userModel = UserModel(
      email: user.providerData.first.email!,
      name: user.displayName!,
      uid: user.uid,
      accessToken: facebookUser.accessToken!.token,
      provider: SignProvidersConstants.facebook,
      providerId: facebookUser.accessToken!.userId,
    );

    return Right(userModel);
  }
}

class GoogleLoginDataSource implements RemoteDataSource {
  @override
  Future<Either<Failure, UserModel>> user() async {
    GoogleSignIn googleSignIn = GoogleSignIn();
    var googleUser = await googleSignIn.signIn();
    if (googleUser == null) {
      return Left(AuthPermissionNotGranted());
    }

    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    final auth = FirebaseAuth.instance;
    final cred = await auth.signInWithCredential(credential);

    var user = cred.user;
    if (user == null) {
      return Left(NoUserFailure());
    }
    if (user.providerData.first.email == null || user.displayName == null) {
      return Left(InsufficientGoogleInfoFailure());
    }

    UserModel userModel = UserModel(
      email: user.providerData.first.email!,
      name: user.displayName!,
      uid: user.uid,
      accessToken: googleAuth.accessToken,
      provider: SignProvidersConstants.google,
      providerId: googleUser.id,
    );

    return Right(userModel);
  }
}

class EmailLoginDataSource implements RemoteDataSource {
  final FirebaseAuth _firebaseAuth;
  final String? email;
  final String? pass;

  EmailLoginDataSource(
    this._firebaseAuth, [
    this.email,
    this.pass,
  ]);
  @override
  Future<Either<Failure, UserModel>> user() async {
    if (email == null || pass == null) {
      throw Exception('Email or password is null');
    }
    var cred = await _firebaseAuth.signInWithEmailAndPassword(
      email: email!,
      password: pass!,
    );

    var user = cred.user;
    if (user == null) {
      return Left(NoUserFailure());
    }
    if (user.providerData.first.email == null || user.displayName == null) {
      return Left(InsufficientGoogleInfoFailure());
    }

    UserModel userModel = UserModel(
      email: user.providerData.first.email!,
      name: user.displayName!,
      uid: user.uid,
      accessToken: null,
      provider: SignProvidersConstants.email,
      providerId: cred.additionalUserInfo?.providerId,
    );

    return Right(userModel);
  }
}

class EmailSignupDataSource implements RemoteDataSource {
  final String email;
  final String pass;
  final String name;
  final FirebaseAuth _firebaseAuth;

  EmailSignupDataSource({
    required this.email,
    required this.name,
    required this.pass,
    required FirebaseAuth firebaseAuth,
  }) : _firebaseAuth = firebaseAuth;

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
  Future<Either<Failure, UserModel>> user() async {
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
