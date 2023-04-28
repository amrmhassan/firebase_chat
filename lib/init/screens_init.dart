// ignore_for_file: prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../core/constants/sign_provider.dart';
import '../features/auth/presentation/pages/login_screen.dart';
import '../features/auth/presentation/pages/signup_screen.dart';
import '../features/email_verification/presentation/pages/email_verification_screen.dart';
import '../features/home/presentation/pages/home_screen.dart';
import '../screens/loading_screen.dart';

class ScreensInit {
  static Map<String, Widget Function(BuildContext)> routes = {
    LoginScreen.routeName: (ctx) => LoginScreen(),
    SignUpScreen.routeName: (ctx) => SignUpScreen(),
    HomeScreen.routeName: (ctx) => HomeScreen(),
    EmailVerificationScreen.routeName: (ctx) => EmailVerificationScreen(),
  };

  static Widget? home = StreamBuilder(
    stream: FirebaseAuth.instance.userChanges(),
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return LoadingScreen();
      } else if (snapshot.data != null) {
        User user = FirebaseAuth.instance.currentUser!;
        SignProvider? signProvider =
            SignProvidersGet.get(user.providerData.first.providerId);
        bool verified =
            signProvider != SignProvider.email || user.emailVerified;

        if (verified) {
          return HomeScreen();
        } else {
          return EmailVerificationScreen();
        }
      } else {
        return LoginScreen();
      }
    },
  );
}