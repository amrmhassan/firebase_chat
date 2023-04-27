// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

import '../../../../../fast_tools/widgets/h_line.dart';
import '../../../../../fast_tools/widgets/padding_wrapper.dart';
import '../../../../theming/constants/sizes.dart';
import '../../../../theming/constants/styles.dart';
import '../../../../theming/theme_calls.dart';

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
