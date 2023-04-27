// ignore_for_file: prefer_const_constructors

import 'package:firebase_chat/features/auth/presentation/pages/widgets/login_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../theming/theme_calls.dart';
import '../providers/user_provider.dart';

class AuthScreenWrapper extends StatelessWidget {
  final bool login;
  final Widget child;

  const AuthScreenWrapper({
    super.key,
    required this.login,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: colorTheme.backGround,
      extendBodyBehindAppBar: true,
      appBar: loginAppBar(false),
      body: Stack(
        children: [
          GestureDetector(
            onTap: () {
              FocusScope.of(context).requestFocus(FocusNode());
            },
            child: Align(
              alignment: Alignment.center,
              child: SingleChildScrollView(
                child: child,
              ),
            ),
          ),
          Selector<UserProvider, bool>(
            builder: (context, value, child) => value
                ? Container(
                    width: double.infinity,
                    height: double.infinity,
                    color: Colors.white.withOpacity(.3),
                  )
                : SizedBox(),
            selector: (p0, p1) => p1.loggingIn,
            shouldRebuild: (previous, next) => previous != next,
          )
        ],
      ),
    );
  }
}
