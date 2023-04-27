import 'package:flutter/material.dart';

import '../../../../../fast_tools/widgets/padding_wrapper.dart';
import '../../../../theming/constants/styles.dart';
import '../../../../theming/theme_calls.dart';

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
