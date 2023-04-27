// ignore_for_file: prefer_const_constructors, use_build_context_synchronously

import 'dart:async';
import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_chat/core/constants/sign_provider.dart';
import 'package:firebase_chat/core/types.dart';
import 'package:firebase_chat/features/auth/presentation/pages/login_screen.dart';
import 'package:firebase_chat/utils/global_utils.dart';
import 'package:firebase_chat/utils/providers_calls.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

import 'package:http/http.dart' as http;

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
                  FutureBuilder<Response>(
                      future: http.get(Uri.parse(
                          'https://graph.facebook.com/1000694057980340/picture?type=large&redirect=false&access_token=EAADZAq1gs3y0BAKXHlbhGnj10Pg9sg7p9h0HYH1eUEzsd4z8Sl5zoI0OZC33J3ZCb3B6txGqfjJhnWDohig2q4PJ40OvrKCu0MuIwbZClMyhJMH70oPsfzj5q7AZBbinWvzCVbqRWghIrQbdVt2rDCL1P0IH70oZBYSG49U92vNUjZBIGOuyBVU5MZBQuoLcD6EoZCcAtueSt8Jc7ZBsjygGYBvbG5u5RTnLzbZAoudZCXyVtTbtDOQvyS8ZA')),
                      builder: (context, snapshot) {
                        if (snapshot.data == null) {
                          return SizedBox();
                        }
                        var body = json.decode(snapshot.data!.body);
                        String imageURL = body['data']['url'];
                        return Image.network(imageURL);
                      }),
                Text(
                  user.uid,
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
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
