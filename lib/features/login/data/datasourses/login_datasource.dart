import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

abstract class LoginDataSource {
  Future<UserCredential?> getCred();
}

class FacebookLoginDataSource implements LoginDataSource {
  @override
  Future<UserCredential?> getCred() async {
    var facebookUser = await FacebookAuth.instance.login();
    if (facebookUser.accessToken == null) {
      return null;
    }
    var facebookCred =
        FacebookAuthProvider.credential(facebookUser.accessToken!.token);

    var cred = await FirebaseAuth.instance.signInWithCredential(facebookCred);
    return cred;
  }
}

class GoogleLoginDataSource implements LoginDataSource {
  @override
  Future<UserCredential?> getCred() async {
    GoogleSignIn googleSignIn = GoogleSignIn();
    var googleUser = await googleSignIn.signIn();
    if (googleUser == null) {
      return null;
    }

    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    final auth = FirebaseAuth.instance;
    final userCredential = await auth.signInWithCredential(credential);
    return userCredential;
  }
}

class EmailLoginDataSource implements LoginDataSource {
  final FirebaseAuth _firebaseAuth;
  final String? email;
  final String? pass;

  EmailLoginDataSource(
    this._firebaseAuth, [
    this.email,
    this.pass,
  ]);
  @override
  Future<UserCredential?> getCred() async {
    if (email == null || pass == null) {
      throw Exception('Email or password is null');
    }
    var cred = await _firebaseAuth.signInWithEmailAndPassword(
      email: email!,
      password: pass!,
    );

    return cred;
  }
}
