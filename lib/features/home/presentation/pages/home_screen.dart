// ignore_for_file: prefer_const_constructors, use_build_context_synchronously, prefer_const_literals_to_create_immutables

import 'dart:async';

import 'package:advanced_shadows/advanced_shadows.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_chat/core/types.dart';
import 'package:firebase_chat/fast_tools/helpers/responsive.dart';
import 'package:firebase_chat/fast_tools/widgets/v_space.dart';
import 'package:firebase_chat/features/auth/data/models/user_model.dart';
import 'package:firebase_chat/features/auth/presentation/pages/login_screen.dart';
import 'package:firebase_chat/features/theming/constants/styles.dart';
import 'package:firebase_chat/features/theming/theme_calls.dart';
import 'package:firebase_chat/utils/global_utils.dart';
import 'package:firebase_chat/utils/providers_calls.dart';
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
    UserModel? userModel = Providers.userP(context).userModel;
    if (userModel == null) return SizedBox();

    return Scaffold(
      backgroundColor: colorTheme.backGround,
      appBar: AppBar(
        title: HomeScreenAppBarTitle(userModel: userModel),
        actions: [
          HomeScreenAppBarActionInvite(userLoaded: userLoaded),
        ],
      ),
      body: userLoaded
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(width: double.infinity),
                VSpace(),
                VSpace(),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(width: double.infinity),
                      // AdvancedShadow(
                      //   innerShadows: [
                      //     BoxShadow(
                      //       color:
                      //           colorTheme.cardBackgroundDark.withOpacity(.3),
                      //       blurRadius:
                      //           Responsive.getWidthPercentage(context, .6) / 3,
                      //     ),
                      //   ],
                      //   outerShadows: [
                      //     BoxShadow(
                      //       color:
                      //           colorTheme.cardBackgroundDark.withOpacity(.3),
                      //       blurRadius: 20,
                      //     ),
                      //   ],
                      //   child: Container(
                      //     width: 100,
                      //     height: 100,
                      //     decoration: BoxDecoration(
                      //       color: colorTheme.backGround,
                      //       borderRadius: BorderRadius.circular(1000),
                      //     ),
                      //   ),
                      // ),

                      AdvancedShadow(
                        innerShadows: innerShadows,
                        outerShadows: outerShadows,
                        child: Container(
                          alignment: Alignment.center,
                          width: Responsive.getWidthPercentage(context, .6),
                          height: Responsive.getWidthPercentage(context, .6),
                          decoration: BoxDecoration(
                            color: colorTheme.backGround,
                            borderRadius: BorderRadius.circular(1000),
                          ),
                          child: Ink(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(1000),
                            ),
                            child: InkWell(
                              onTap: () {},
                              splashColor: Colors.grey,
                              borderRadius: BorderRadius.circular(1000),
                              child: Container(
                                alignment: Alignment.center,
                                child: Text(
                                  'Chat',
                                  style: h1TextStyle.copyWith(
                                    color: colorTheme.activeText,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
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
      // await Providers.userPf(context).loadCurrentUserInfo();
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

  List<BoxShadow> innerShadows = [
    BoxShadow(
      color: colorTheme.kBlueColor.withOpacity(.6),
      blurRadius: 20,
    ),
    BoxShadow(
      color: Colors.white.withOpacity(.9),
      blurRadius: 15,
    ),
    BoxShadow(
      color: Colors.blue.withOpacity(.3),
      blurRadius: 5,
    ),
  ];
  List<BoxShadow> get outerShadows => [
        BoxShadow(
          color: colorTheme.kBlueColor.withOpacity(.6),
          blurRadius: 5,
        ),
        BoxShadow(
          color: Colors.white.withOpacity(.9),
          blurRadius: 3,
        ),
        BoxShadow(
          color: Colors.blue.withOpacity(.3),
          blurRadius: 2,
        ),
      ];
}
