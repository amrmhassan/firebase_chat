import 'package:firebase_chat/features/search/presentation/providers/search_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../features/auth/presentation/providers/user_provider.dart';
import '../features/email_verification/presentation/providers/email_verification_provider.dart';

class Providers {
  static UserProvider userPf(BuildContext context) {
    return Provider.of<UserProvider>(context, listen: false);
  }

  static UserProvider userP(BuildContext context) {
    return Provider.of<UserProvider>(context);
  }

  static EVerifyProvider emailVPf(BuildContext context) {
    return Provider.of<EVerifyProvider>(context, listen: false);
  }

  static EVerifyProvider emailVP(BuildContext context) {
    return Provider.of<EVerifyProvider>(context);
  }

  static SearchProvider searchPf(BuildContext context) {
    return Provider.of<SearchProvider>(context, listen: false);
  }

  static SearchProvider searchP(BuildContext context) {
    return Provider.of<SearchProvider>(context);
  }
}
