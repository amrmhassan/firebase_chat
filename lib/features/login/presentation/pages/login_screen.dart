// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:firebase_chat/fast_tools/widgets/h_line.dart';
import 'package:firebase_chat/fast_tools/widgets/h_space.dart';
import 'package:firebase_chat/fast_tools/widgets/padding_wrapper.dart';
import 'package:firebase_chat/fast_tools/widgets/v_space.dart';
import 'package:firebase_chat/features/theming/constants/sizes.dart';
import 'package:firebase_chat/features/theming/constants/styles.dart';
import 'package:firebase_chat/features/theming/theme_calls.dart';
import 'package:flutter/material.dart';

import '../../../../fast_tools/widgets/button_wrapper.dart';
import 'widgets/login_form_text_filed.dart';

class LoginScreen extends StatelessWidget {
  static const String routeName = '/LoginScreen';
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: colorTheme.backGround,
      appBar: AppBar(
        title: Text('Login'),
      ),
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
                ),
                VSpace(factor: .5),
                LoginFormTextField(
                  hint: 'At least 8 characters',
                  iconPath: 'assets/svg/lock.svg',
                  inputType: TextInputType.visiblePassword,
                  password: true,
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ForgetPasswordButton extends StatelessWidget {
  const ForgetPasswordButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return PaddingWrapper(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          GestureDetector(
            onTap: () {},
            child: Text(
              'Forgot password?',
              style: h4TextStyle.copyWith(
                color: colorTheme.kBlueColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class LoginButton extends StatelessWidget {
  const LoginButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return PaddingWrapper(
      child: ButtonWrapper(
        onTap: () {},
        padding: EdgeInsets.symmetric(
          horizontal: kHPad,
          vertical: kVPad / 2,
        ),
        backgroundColor: colorTheme.kBlueColor,
        child: Text(
          'Login',
          style: h3LightTextStyle,
        ),
      ),
    );
  }
}

class LoginHLine extends StatelessWidget {
  const LoginHLine({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return PaddingWrapper(
      child: HLine(
        color: colorTheme.kInactiveColor.withOpacity(.5),
        thickness: .5,
        alignment: Alignment.center,
        overlay: Container(
          padding: EdgeInsets.symmetric(
            horizontal: kHPad / 2,
          ),
          color: colorTheme.backGround,
          child: Text(
            'Or',
            style: h4TextStyleInactive,
          ),
        ),
      ),
    );
  }
}

class SocialMediaButton extends StatelessWidget {
  final String iconPath;
  final String title;

  const SocialMediaButton({
    super.key,
    required this.iconPath,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return ButtonWrapper(
      onTap: () {},
      alignment: Alignment.center,
      backgroundColor: colorTheme.backGround,
      padding: EdgeInsets.symmetric(
        horizontal: kHPad,
        vertical: kVPad / 2,
      ),
      border: Border.all(
        color: colorTheme.kInactiveColor.withOpacity(.5),
        width: 1,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            iconPath,
            width: mediumIconSize,
          ),
          HSpace(factor: .5),
          Text(
            title,
            style: h4TextStyle.copyWith(
              color: colorTheme.activeText,
            ),
          ),
        ],
      ),
    );
  }
}
