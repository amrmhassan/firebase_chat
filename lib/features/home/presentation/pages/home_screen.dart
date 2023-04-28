// ignore_for_file: prefer_const_constructors, use_build_context_synchronously

import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_chat/core/constants/sign_provider.dart';
import 'package:firebase_chat/core/types.dart';
import 'package:firebase_chat/features/auth/presentation/pages/login_screen.dart';
import 'package:firebase_chat/utils/global_utils.dart';
import 'package:firebase_chat/utils/providers_calls.dart';
import 'package:flutter/material.dart';

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
      await Providers.userPf(context).loadCurrentUserInfo();
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
    SignProvider? signProvider =
        SignProvidersGet.get(user.providerData.first.providerId);
    bool verified = signProvider != SignProvider.email || user.emailVerified;

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
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(width: double.infinity),
                if (user.photoURL != null)
                  FutureBuilder<String?>(
                      future: Providers.userP(context).userModel?.photoUrl,
                      builder: (context, snapshot) {
                        if (snapshot.data == null) {
                          return SizedBox();
                        }
                        return Image.network(snapshot.data!);
                      }),
                Text(
                  user.providerData.first.email ?? 'No email',
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
                Text(
                  SignProvidersGet.get(user.providerData.first.providerId)
                      .toString(),
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
                Text(
                  'verified $verified',
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
                ...user.providerData.map(
                  (e) => Text(
                    e.providerId,
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                ),
                Text(
                  user.displayName ?? 'No name',
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
                if (!verified)
                  ElevatedButton(
                    onPressed: () {
                      user.sendEmailVerification();
                    },
                    child: Text('verify'),
                  ),
              ],
            )
          : Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}
