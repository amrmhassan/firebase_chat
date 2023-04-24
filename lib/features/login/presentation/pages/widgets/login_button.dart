// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

import '../../../../../fast_tools/widgets/button_wrapper.dart';
import '../../../../../fast_tools/widgets/padding_wrapper.dart';
import '../../../../theming/constants/sizes.dart';
import '../../../../theming/constants/styles.dart';
import '../../../../theming/theme_calls.dart';

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
