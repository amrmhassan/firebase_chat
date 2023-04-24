import 'package:firebase_chat/features/theming/theme_calls.dart';
import 'package:flutter/material.dart';

import '../core/types.dart';
import '../init/initiators.dart';

class GlobalUtils {
  static void showSnackBar({
    required BuildContext context,
    required String message,
    Color? backgroundColor,
    Color? textColor,
    SnackBarType? snackBarType,
    bool aboveBottomNavBar = false,
    EdgeInsets? margin,
    VoidCallback? onActionTapped,
    String? actionString,
  }) {
    try {
      ScaffoldMessenger.of(context).removeCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          behavior: aboveBottomNavBar ? SnackBarBehavior.floating : null,
          content: Text(
            message,
          ),
          backgroundColor: backgroundColor ??
              ((snackBarType ?? SnackBarType.info) == SnackBarType.success
                  ? colorTheme.kGreenColor
                  : (snackBarType ?? SnackBarType.info) == SnackBarType.error
                      ? colorTheme.kDangerColor
                      : null),
          margin: margin,
          action: SnackBarAction(
            label: actionString ?? 'done',
            textColor: textColor ??
                ((snackBarType ?? SnackBarType.info) == SnackBarType.error ||
                        (snackBarType ?? SnackBarType.info) ==
                            SnackBarType.success ||
                        (snackBarType ?? SnackBarType.info) == SnackBarType.info
                    ? Colors.white
                    : null),
            onPressed: onActionTapped ?? () {},
          ),
        ),
      );
    } catch (e) {
      //
    }
  }

  static void fastSnackBar({
    required String msg,
    SnackBarType? snackBarType,
    GlobalKey<NavigatorState>? navKey,
  }) {
    BuildContext? ctx = (navKey ?? navigatorKey).currentContext;
    if (ctx == null) return;
    showSnackBar(
      context: ctx,
      message: msg,
      snackBarType: snackBarType,
    );
  }
}
