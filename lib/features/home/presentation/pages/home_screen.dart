// ignore_for_file: prefer_const_constructors, use_build_context_synchronously, prefer_const_literals_to_create_immutables

import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_chat/core/types.dart';
import 'package:firebase_chat/fast_tools/widgets/padding_wrapper.dart';
import 'package:firebase_chat/fast_tools/widgets/v_space.dart';
import 'package:firebase_chat/features/auth/data/models/user_model.dart';
import 'package:firebase_chat/features/auth/presentation/pages/login_screen.dart';
import 'package:firebase_chat/features/theming/constants/sizes.dart';
import 'package:firebase_chat/features/theming/constants/styles.dart';
import 'package:firebase_chat/features/theming/theme_calls.dart';
import 'package:firebase_chat/transformers/collections.dart';
import 'package:firebase_chat/utils/global_utils.dart';
import 'package:firebase_chat/utils/providers_calls.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import '../widgets/home_screen_appbar.dart';

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
    checkUserInitData();
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
        title: HomeScreenAppBarTitle(userModel: userModel),
        actions: [
          HomeScreenAppBarActionSearch(userLoaded: userLoaded),
        ],
      ),
      body: userLoaded
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(width: double.infinity),
                VSpace(),
                PaddingWrapper(
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: kHPad,
                      vertical: kVPad,
                    ),
                    width: double.infinity,
                    height: 200,
                    decoration: BoxDecoration(
                      color: colorTheme.cardBackgroundDark,
                      borderRadius: BorderRadius.circular(largeBorderRadius),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          userModel.email,
                          style: h3LightTextStyle,
                          overflow: TextOverflow.ellipsis,
                        )
                      ],
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () async {
                    var ref = FirebaseDatabase.instance
                        .ref(
                          DBCollections.getRef(
                            [
                              DBCollections.users,
                              userModel.uid,
                              DBCollections.rooms,
                            ],
                          ),
                        )
                        .push();
                    await ref.set({
                      'name': 'This is my name',
                    });
                  },
                  child: Text('Create Chat'),
                ),
                StreamBuilder(
                  stream: FirebaseDatabase.instance
                      .ref(
                        DBCollections.getRef(
                          [
                            DBCollections.users,
                            userModel.uid,
                            DBCollections.rooms,
                          ],
                        ),
                      )
                      .limitToLast(1)
                      .onValue,
                  builder: (context, snapshot) {
                    var data = snapshot.data!.snapshot.value;
                    if (snapshot.hasData &&
                        snapshot.data != null &&
                        data != null) {
                      var rooms = (data as Map).cast();

                      return Expanded(
                          child: ListView(
                        children: rooms.entries
                            .map(
                              (e) => Text(e.key),
                            )
                            .toList(),
                      ));
                    }
                    return SizedBox();
                  },
                ),
                VSpace(),
              ],
            )
          : Center(
              child: CircularProgressIndicator(
                strokeWidth: 1.7,
              ),
            ),
    );
  }

  void checkUserInitData() async {
    Future.delayed(Duration.zero).then((value) async {
      await Providers.userPf(context).loadCurrentUserInfo();
      try {
        User? currentUser = FirebaseAuth.instance.currentUser;
        if (currentUser == null) {
          Navigator.pushReplacementNamed(context, LoginScreen.routeName);
        } else {
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
  }
}
