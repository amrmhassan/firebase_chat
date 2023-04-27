// ignore_for_file: prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_chat/features/auth/presentation/pages/login_screen.dart';
import 'package:firebase_chat/features/auth/presentation/pages/signup_screen.dart';
import 'package:firebase_chat/features/auth/presentation/providers/user_provider.dart';
import 'package:firebase_chat/features/email_verification/presentation/pages/email_verification_screen.dart';
import 'package:firebase_chat/features/email_verification/presentation/providers/email_verification_provider.dart';
import 'package:firebase_chat/features/theming/providers/theme_provider.dart';
import 'package:firebase_chat/firebase_options.dart';
import 'package:firebase_chat/init/initiators.dart';
import 'package:firebase_chat/screens/loading_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'core/constants/sign_provider.dart';
import 'features/home/presentation/pages/home_screen.dart';

//
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ThemeProvider()),
        ChangeNotifierProvider(create: (context) => UserProvider()),
        ChangeNotifierProvider(create: (context) => EVerifyProvider()),
      ],
      child: MaterialApp(
        navigatorKey: navigatorKey,
        theme: ThemeData(
          useMaterial3: true,
          textTheme: TextTheme(
            bodyLarge: TextStyle(
              color: Color.fromARGB(255, 42, 35, 77),
            ),
            bodyMedium: TextStyle(
              color: Color.fromARGB(255, 42, 35, 77),
            ),
          ),
        ),
        debugShowCheckedModeBanner: false,
        title: 'Firebase chat',
        // initialRoute: HomeScreen.routeName,
        home: StreamBuilder(
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
        ),
        routes: {
          // HomeScreen.routeName: (ctx) => HomeScreen(),
          LoginScreen.routeName: (ctx) => LoginScreen(),
          SignUpScreen.routeName: (ctx) => SignUpScreen(),
          HomeScreen.routeName: (ctx) => HomeScreen(),
          EmailVerificationScreen.routeName: (ctx) => EmailVerificationScreen(),
        },
      ),
    );
  }
}
