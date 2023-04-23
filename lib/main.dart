// ignore_for_file: prefer_const_constructors

import 'package:firebase_chat/features/chat/presentation/screens/home_screen/home_screen.dart';
import 'package:firebase_chat/features/login/presentation/pages/login_screen.dart';
import 'package:firebase_chat/features/theming/providers/theme_provider.dart';
import 'package:firebase_chat/firebase_options.dart';
import 'package:firebase_chat/init/initiators.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
      ],
      child: MaterialApp(
        navigatorKey: navigatorKey,
        theme: ThemeData(
          useMaterial3: true,
          textTheme: TextTheme(
            bodyLarge: TextStyle(
              color: Colors.white,
            ),
            bodyMedium: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
        debugShowCheckedModeBanner: false,
        title: 'Firebase chat',
        initialRoute: LoginScreen.routeName,
        routes: {
          HomeScreen.routeName: (ctx) => HomeScreen(),
          LoginScreen.routeName: (ctx) => LoginScreen(),
        },
      ),
    );
  }
}
