// ignore_for_file: prefer_const_constructors, use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_chat/core/types.dart';
import 'package:firebase_chat/features/login/data/models/user_model.dart';
import 'package:firebase_chat/features/login/presentation/pages/login_screen.dart';
import 'package:firebase_chat/features/login/presentation/providers/user_provider.dart';
import 'package:firebase_chat/utils/global_utils.dart';
import 'package:firebase_chat/utils/providers_calls.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = '/HomeScreen';
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool userLoaded = false;

  @override
  void initState() {
    Future.delayed(Duration.zero).then((value) async {
      try {
        User? currentUser = FirebaseAuth.instance.currentUser;
        if (currentUser == null) {
          Navigator.pushReplacementNamed(context, LoginScreen.routeName);
        } else {
          // await Providers.userPf(context).loadUserModel(currentUser.uid);
          setState(() {
            userLoaded = true;
          });
        }
      } catch (e) {
        GlobalUtils.showSnackBar(
          context: context,
          message: 'Error Occurred',
          snackBarType: SnackBarType.error,
        );
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    User user = FirebaseAuth.instance.currentUser!;
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Screen'),
        actions: [
          userLoaded
              ? IconButton(
                  onPressed: () async {
                    await Providers.userPf(context).logout();
                    // Navigator.pop(context);
                  },
                  icon: Icon(
                    Icons.logout,
                  ),
                )
              : IconButton(
                  onPressed: () {},
                  icon: CircularProgressIndicator(),
                ),
        ],
      ),
      body: userLoaded
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  user.uid,
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
                Text(
                  user.email ?? 'No email',
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
                Selector<UserProvider, UserModel?>(
                  selector: (p0, p1) => p1.userModel,
                  shouldRebuild: (previous, next) => previous?.uid != next?.uid,
                  builder: (context, value, child) => Text(
                    user.displayName ?? 'No name',
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            )
          : Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}
