import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../../../../theming/constants/styles.dart';
import '../../../../theming/theme_calls.dart';
import '../signup_screen.dart';

class SwitchLoginMode extends StatelessWidget {
  final bool login;
  const SwitchLoginMode({
    super.key,
    this.login = true,
  });

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: login ? 'Not have an account? ' : 'Have an account? ',
            style: h4TextStyle,
          ),
          TextSpan(
            text: login ? 'Sign Up' : 'Login',
            style: h4TextStyle.copyWith(
              color: colorTheme.kBlueColor,
            ),
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                if (login) {
                  Navigator.pushNamed(
                    context,
                    SignUpScreen.routeName,
                  );
                } else {
                  Navigator.pop(context);
                }
              },
          ),
        ],
      ),
    );
  }
}
