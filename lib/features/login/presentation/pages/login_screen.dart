// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, use_build_context_synchronously

import 'package:firebase_chat/features/login/presentation/handlers/login_handlers.dart';
import 'package:firebase_chat/features/login/presentation/pages/widgets/login_app_bar.dart';
import 'package:firebase_chat/features/login/presentation/providers/user_provider.dart';
import 'package:firebase_chat/utils/providers_calls.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
import 'widgets/switch_login_mode.dart';

class LoginScreen extends StatelessWidget {
  static const String routeName = '/LoginScreen';
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: colorTheme.backGround,
      extendBodyBehindAppBar: true,
      appBar: loginAppBar(true),
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
                  selector: (p0, p1) => p1.passwordError,
                  shouldRebuild: (previous, next) => previous != next,
                  builder: (context, value, child) => LoginFormTextField(
                    errorText: value,
                    controller: Providers.userPf(context).passwordController,
                    hint: 'Enter password',
                    iconPath: 'assets/svg/lock.svg',
                    inputType: TextInputType.visiblePassword,
                    password: true,
                  ),
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
                          onTap: () => LoginHandlers.googleLogin(context),
                        ),
                      ),
                      HSpace(),
                      Expanded(
                        child: SocialMediaButton(
                          onTap: () => LoginHandlers.facebookLogin(context),
                          title: 'Facebook',
                          iconPath: 'assets/icons/facebook.png',
                        ),
                      ),
                    ],
                  ),
                ),
                VSpace(),
                SwitchLoginMode(),
                VSpace(factor: 2),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
