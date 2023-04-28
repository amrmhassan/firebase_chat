// ignore_for_file: prefer_const_constructors, use_build_context_synchronously, prefer_const_literals_to_create_immutables

import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_chat/core/constants/sign_provider.dart';
import 'package:firebase_chat/core/types.dart';
import 'package:firebase_chat/fast_tools/widgets/h_space.dart';
import 'package:firebase_chat/fast_tools/widgets/v_line.dart';
import 'package:firebase_chat/features/auth/data/models/user_model.dart';
import 'package:firebase_chat/features/auth/presentation/pages/login_screen.dart';
import 'package:firebase_chat/features/theming/constants/sizes.dart';
import 'package:firebase_chat/features/theming/constants/styles.dart';
import 'package:firebase_chat/features/theming/theme_calls.dart';
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
    // User user = FirebaseAuth.instance.currentUser!;
    // SignProvider? signProvider =
    //     SignProvidersGet.get(user.providerData.first.providerId);
    // bool verified = signProvider != SignProvider.email || user.emailVerified;
    UserModel? userModel = Providers.userP(context).userModel;
    if (userModel == null) return SizedBox();

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            FutureBuilder<String?>(
                future: userModel.photoUrl,
                builder: (context, snapshot) {
                  if (snapshot.data == null) {
                    return SizedBox();
                  }
                  return Container(
                    clipBehavior: Clip.hardEdge,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(1000),
                    ),
                    child: Image.network(
                      snapshot.data!,
                      width: largeIconSize,
                      height: largeIconSize,
                      alignment: Alignment.topCenter,
                    ),
                  );
                }),
            HSpace(),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    userModel.name,
                    style: h3TextStyle,
                  ),
                  Text(
                    userModel.email,
                    style: h4TextStyleInactive,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
        actions: [
          Row(
            children: [
              VLine(
                color: colorTheme.kInactiveColor,
                thickness: 1,
                heightFactor: .5,
              ),
              userLoaded
                  ? IconButton(
                      onPressed: () async {
                        // await Providers.userPf(context).logout();
                        // Navigator.pop(context);
                      },
                      icon: Icon(
                        Icons.search,
                      ),
                    )
                  : IconButton(
                      onPressed: () {},
                      icon: SizedBox(
                        height: mediumIconSize,
                        width: mediumIconSize,
                        child: CircularProgressIndicator(
                          strokeWidth: 1.4,
                        ),
                      ),
                    ),
              HSpace(factor: .5),
            ],
          ),
        ],
      ),
      body: userLoaded
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(width: double.infinity),
              ],
            )
          : Center(
              child: CircularProgressIndicator(
                strokeWidth: 1.7,
              ),
            ),
    );
  }
}
