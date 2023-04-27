import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../features/auth/presentation/providers/user_provider.dart';

class Providers {
  static UserProvider userPf(BuildContext context) {
    return Provider.of<UserProvider>(context, listen: false);
  }

  static UserProvider userP(BuildContext context) {
    return Provider.of<UserProvider>(context);
  }
}
