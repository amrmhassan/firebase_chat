import 'package:flutter/material.dart';

class ScreenWrapper extends StatelessWidget {
  final Widget body;
  final PreferredSizeWidget? appBar;
  final Color? backgroundColor;
  const ScreenWrapper(
      {super.key, required this.body, this.appBar, this.backgroundColor});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: body,
      appBar: appBar,
    );
  }
}
