// ignore_for_file: prefer_const_constructors

import 'package:firebase_chat/features/auth/presentation/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../../../../fast_tools/widgets/custom_text_field.dart';
import '../../../../theming/constants/sizes.dart';
import '../../../../theming/constants/styles.dart';
import '../../../../theming/theme_calls.dart';

class LoginFormTextField extends StatefulWidget {
  final String hint;
  final String iconPath;
  final TextInputType? inputType;
  final bool password;
  final bool autoFocus;
  final Function(String value)? onChange;
  final TextEditingController? controller;
  final String? errorText;

  const LoginFormTextField({
    super.key,
    required this.hint,
    required this.iconPath,
    this.onChange,
    this.inputType,
    this.password = false,
    this.controller,
    this.autoFocus = false,
    this.errorText,
  });

  @override
  State<LoginFormTextField> createState() => _LoginFormTextFieldState();
}

class _LoginFormTextFieldState extends State<LoginFormTextField> {
  bool passwordShown = false;
  void togglePasswordShown() {
    setState(() {
      passwordShown = !passwordShown;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Selector<UserProvider, bool>(
      selector: (p0, p1) => p1.loggingIn,
      shouldRebuild: (previous, next) => previous != next,
      builder: (context, value, child) {
        return CustomTextField(
          title: widget.hint,
          enabled: !value,
          errorText: widget.errorText,
          controller: widget.controller,
          onChange: widget.onChange,
          autoFocus: widget.autoFocus,
          textInputType: widget.inputType,
          password: widget.password,
          handleShowPassword: togglePasswordShown,
          obscureText: !passwordShown && widget.password,
          color: Colors.red,
          backgroundColor: colorTheme.textFieldBackgroundColor,
          borderColor: Colors.transparent,
          textStyle: h4TextStyleInactive,
          borderRadius: BorderRadius.circular(mediumBorderRadius),
          leadingIcon: child,
          trailingIcon: passwordEye(),
        );
      },
      child: Container(
        padding: EdgeInsets.all(
          smallPadding,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(mediumBorderRadius),
        ),
        child: SvgPicture.asset(
          widget.iconPath,
          width: mediumIconSize * .8,
          colorFilter: ColorFilter.mode(
            colorTheme.kBlueColor,
            BlendMode.srcIn,
          ),
        ),
      ),
    );
  }

  Widget? passwordEye() {
    return widget.password && passwordShown
        ? GestureDetector(
            onTap: togglePasswordShown,
            child: SvgPicture.asset(
              'assets/svg/eye-closed.svg',
            ),
          )
        : widget.password && !passwordShown
            ? GestureDetector(
                onTap: togglePasswordShown,
                child: SvgPicture.asset(
                  'assets/svg/eye-open.svg',
                ),
              )
            : null;
  }
}
