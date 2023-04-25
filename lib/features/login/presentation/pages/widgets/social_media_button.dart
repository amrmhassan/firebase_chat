// ignore_for_file: prefer_const_constructors

import 'package:firebase_chat/features/login/presentation/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../fast_tools/widgets/button_wrapper.dart';
import '../../../../../fast_tools/widgets/h_space.dart';
import '../../../../theming/constants/sizes.dart';
import '../../../../theming/constants/styles.dart';
import '../../../../theming/theme_calls.dart';

class SocialMediaButton extends StatelessWidget {
  final String iconPath;
  final String title;
  final bool login;
  final VoidCallback? onTap;

  const SocialMediaButton({
    super.key,
    required this.iconPath,
    required this.title,
    this.onTap,
    this.login = true,
  });

  @override
  Widget build(BuildContext context) {
    return Selector<UserProvider, bool>(
      selector: (p0, p1) => p1.logging,
      shouldRebuild: (previous, next) => previous != next,
      builder: (context, value, child) => ButtonWrapper(
        onTap: onTap,
        active: !value,
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
        child: child,
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
