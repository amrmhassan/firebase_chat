// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, use_build_context_synchronously

import 'dart:ui';

import 'package:firebase_chat/core/navigation.dart';
import 'package:firebase_chat/features/login/presentation/handlers/login_handlers.dart';
import 'package:firebase_chat/utils/providers_calls.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../fast_tools/widgets/h_space.dart';
import '../../../../fast_tools/widgets/padding_wrapper.dart';
import '../../../../fast_tools/widgets/v_space.dart';
import '../../../theming/constants/sizes.dart';
import '../../../theming/theme_calls.dart';
import '../providers/user_provider.dart';
import 'widgets/login_button.dart';
import 'widgets/login_form_text_filed.dart';
import 'widgets/login_h_line.dart';
import 'widgets/social_media_button.dart';
import 'widgets/switch_login_mode.dart';

class SignUpScreen extends StatelessWidget {
  static const String routeName = '/SignUpScreen';
  const SignUpScreen({super.key});

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
                      'assets/sticker/verification.png',
                      width: largeIconSize * 6,
                    ),
                  ],
                ),
                VSpace(),
                Selector<UserProvider, String?>(
                  selector: (p0, p1) => p1.emailError,
                  shouldRebuild: (previous, next) => previous != next,
                  builder: (context, value, child) => LoginFormTextField(
                    errorText: value,
                    controller: Providers.userPf(context).emailController,
                    hint: 'you@example.com',
                    iconPath: 'assets/svg/email.svg',
                    inputType: TextInputType.emailAddress,
                  ),
                ),
                VSpace(factor: .5),
                Selector<UserProvider, String?>(
                  selector: (p0, p1) => p1.nameError,
                  shouldRebuild: (previous, next) => previous != next,
                  builder: (context, value, child) => LoginFormTextField(
                    errorText: value,
                    controller: Providers.userPf(context).nameController,
                    hint: 'Your name',
                    iconPath: 'assets/svg/user.svg',
                    inputType: TextInputType.text,
                  ),
                ),
                VSpace(factor: .5),
                Selector<UserProvider, String?>(
                  selector: (p0, p1) => p1.passwordError,
                  shouldRebuild: (previous, next) => previous != next,
                  builder: (context, value, child) => LoginFormTextField(
                    errorText: value,
                    controller: Providers.userPf(context).passwordController,
                    hint: 'At least 8 characters',
                    iconPath: 'assets/svg/lock.svg',
                    inputType: TextInputType.visiblePassword,
                    password: true,
                  ),
                ),
                VSpace(factor: .5),
                VSpace(),
                LoginButton(login: false),
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
                          onTap: () async {
                            await LoginHandlers.googleLogin(context);
                            CNav.pop(context);
                          },
                        ),
                      ),
                      HSpace(),
                      Expanded(
                        child: SocialMediaButton(
                          title: 'Facebook',
                          iconPath: 'assets/icons/facebook.png',
                          onTap: () async {
                            await LoginHandlers.facebookLogin(context);
                            CNav.pop(context);
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                VSpace(),
                SwitchLoginMode(login: false),
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
  title: Text('Sign Up'),
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
