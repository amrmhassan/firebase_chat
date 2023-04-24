// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:ui';

import 'package:firebase_chat/utils/providers_calls.dart';
import 'package:flutter/material.dart';

import '../../../../fast_tools/widgets/h_space.dart';
import '../../../../fast_tools/widgets/padding_wrapper.dart';
import '../../../../fast_tools/widgets/v_space.dart';
import '../../../theming/constants/sizes.dart';
import '../../../theming/theme_calls.dart';
import 'widgets/forget_password_button.dart';
import 'widgets/login_button.dart';
import 'widgets/login_form_text_filed.dart';
import 'widgets/login_h_line.dart';
import 'widgets/social_media_button.dart';

class LoginScreen extends StatelessWidget {
  static const String routeName = '/LoginScreen';
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: colorTheme.backGround,
      extendBodyBehindAppBar: true,
      appBar: loginAppBar,
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Align(
          alignment: Alignment.center,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                VSpace(factor: 2),
                Column(
                  children: [
                    Image.asset(
                      'assets/sticker/log-in.png',
                      width: largeIconSize * 6,
                    ),
                  ],
                ),
                VSpace(),
                LoginFormTextField(
                  autoFocus: true,
                  hint: 'you@example.com',
                  iconPath: 'assets/svg/email.svg',
                  inputType: TextInputType.emailAddress,
                  onChange: Providers.loginPf(context).setEmail,
                ),
                VSpace(factor: .5),
                LoginFormTextField(
                  hint: 'At least 8 characters',
                  iconPath: 'assets/svg/lock.svg',
                  inputType: TextInputType.visiblePassword,
                  password: true,
                  onChange: Providers.loginPf(context).setPassword,
                ),
                VSpace(factor: .5),
                ForgetPasswordButton(),
                VSpace(),
                LoginButton(),
                VSpace(),
                LoginHLine(),
                VSpace(factor: 2),
                PaddingWrapper(
                  child: Row(
                    children: [
                      Expanded(
                        child: SocialMediaButton(
                          title: 'Google',
                          iconPath: 'assets/icons/google.png',
                        ),
                      ),
                      HSpace(),
                      Expanded(
                        child: SocialMediaButton(
                          title: 'Facebook',
                          iconPath: 'assets/icons/facebook.png',
                        ),
                      ),
                    ],
                  ),
                ),
                VSpace(factor: 2),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

var loginAppBar = AppBar(
  backgroundColor: Colors.transparent,
  elevation: 0,
  title: Text('Login'),
  flexibleSpace: FlexibleSpaceBar(
      background: BackdropFilter(
    filter: ImageFilter.blur(
      sigmaX: 3,
      sigmaY: 3,
    ),
    child: Container(
      color: colorTheme.backGround.withOpacity(.5),
    ),
  )),
);
