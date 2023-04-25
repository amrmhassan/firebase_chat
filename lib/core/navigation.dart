import 'package:flutter/material.dart';

class CNav {
  static Future<dynamic> pushNamed(
    BuildContext context,
    String routeName,
  ) {
    if (context.mounted) {
      return Navigator.pushNamed(context, routeName);
    } else {
      return Future.value();
    }
  }

  static Future<dynamic> pushReplacementNamed(
    BuildContext context,
    String routeName,
  ) {
    if (context.mounted) {
      return Navigator.pushReplacementNamed(context, routeName);
    } else {
      return Future.value();
    }
  }

  static void pop<T extends Object?>(BuildContext context) {
    if (context.mounted) {
      return Navigator.pop(context);
    } else {
      return;
    }
  }
}
