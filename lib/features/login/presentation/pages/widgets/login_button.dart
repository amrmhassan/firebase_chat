// ignore_for_file: prefer_const_constructors, use_build_context_synchronously

import 'package:firebase_chat/core/errors/failure.dart';
import 'package:firebase_chat/core/types.dart';
import 'package:firebase_chat/features/login/domain/entities/user_entity.dart';
import 'package:firebase_chat/init/initiators.dart';
import 'package:firebase_chat/utils/global_utils.dart';
import 'package:firebase_chat/utils/providers_calls.dart';
import 'package:flutter/material.dart';

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
    return PaddingWrapper(
      child: ButtonWrapper(
        onTap: () => handleLogin(context),
        padding: EdgeInsets.symmetric(
          horizontal: kHPad,
          vertical: kVPad / 2,
        ),
        backgroundColor: colorTheme.kBlueColor,
        child: Text(
          login ? 'Login' : 'Sign Up',
          style: h3LightTextStyle,
        ),
      ),
    );
  }

  void handleLogin(BuildContext context) async {
    var res = await Providers.loginPf(context).login();
    var data = res.fold((l) => l, (r) => r);
    if (data is Failure) {
      logger.e(data);
      GlobalUtils.showSnackBar(
        context: context,
        message: ErrorMapper(data).map(),
        snackBarType: SnackBarType.error,
      );
    } else if (data is UserEntity) {
      GlobalUtils.showSnackBar(
        context: context,
        message: 'Logged in successfully',
        snackBarType: SnackBarType.info,
      );
    }
  }
}
