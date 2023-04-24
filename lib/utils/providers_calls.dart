import 'package:firebase_chat/features/login/presentation/providers/login_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Providers {
  static LoginProvider loginPf(BuildContext context) {
    return Provider.of<LoginProvider>(context, listen: false);
  }

  static LoginProvider loginP(BuildContext context) {
    return Provider.of<LoginProvider>(context);
  }
}
