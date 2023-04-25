// ignore_for_file: prefer_const_constructors, use_build_context_synchronously

import 'package:firebase_chat/core/errors/failure.dart';
import 'package:firebase_chat/core/navigation.dart';
import 'package:firebase_chat/core/types.dart';
import 'package:firebase_chat/features/chat/presentation/screens/home_screen/home_screen.dart';
import 'package:firebase_chat/features/login/data/models/user_model.dart';
import 'package:firebase_chat/features/login/presentation/providers/user_provider.dart';
import 'package:firebase_chat/init/initiators.dart';
import 'package:firebase_chat/utils/global_utils.dart';
import 'package:firebase_chat/utils/providers_calls.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../fast_tools/widgets/button_wrapper.dart';
import '../../../../../fast_tools/widgets/padding_wrapper.dart';
import '../../../../theming/constants/sizes.dart';
import '../../../../theming/constants/styles.dart';
import '../../../../theming/theme_calls.dart';

class LoginButton extends StatelessWidget {
  final bool login;

  const LoginButton({
    super.key,
    this.login = true,
  });

  @override
  Widget build(BuildContext context) {
    logger.i('building');
    return PaddingWrapper(
      child: Selector<UserProvider, bool>(
        selector: (p0, p1) => p1.logging,
        shouldRebuild: (previous, next) => previous != next,
        builder: (BuildContext context, value, Widget? child) {
          return ButtonWrapper(
            active: !value,
            onTap: () => handleLoginButtonClick(context),
            padding: EdgeInsets.symmetric(
              horizontal: kHPad,
              vertical: kVPad / 2,
            ),
            backgroundColor: colorTheme.kBlueColor,
            child: Text(
              login ? 'Login' : 'Sign Up',
              style: h3LightTextStyle,
            ),
          );
        },
      ),
    );
  }

  void handleLoginButtonClick(BuildContext context) async {
    logger.i('logging');
    if (login) {
      await handleLogin(context);
    } else {
      await handleSignup(context);
    }
    // if (data is UserModel) {
    //   Navigator.pushNamed(context, HomeScreen.routeName);
    // }
  }

  Future<dynamic> handleLogin(BuildContext context) async {
    var res = await Providers.userPf(context).login();
    var data = res.fold((l) => l, (r) => r);
    if (data is Failure) {
      logger.e(data);
      GlobalUtils.showSnackBar(
        context: context,
        message: ErrorMapper(data).map(),
        snackBarType: SnackBarType.error,
      );
    } else if (data is UserModel) {
      GlobalUtils.showSnackBar(
        context: context,
        message: 'Logged in successfully',
        snackBarType: SnackBarType.info,
      );
    }
    return data;
  }

  Future<dynamic> handleSignup(BuildContext context) async {
    var res = await Providers.userPf(context).signUp();
    var data = res.fold((l) => l, (r) => r);
    if (data is Failure) {
      logger.e(data);
      GlobalUtils.showSnackBar(
        context: context,
        message: ErrorMapper(data).map(),
        snackBarType: SnackBarType.error,
      );
    } else if (data is UserModel) {
      GlobalUtils.showSnackBar(
        context: context,
        message: 'Singed you up successfully',
        snackBarType: SnackBarType.info,
      );
    }
    CNav.pop(context);
    return data;
  }
}
