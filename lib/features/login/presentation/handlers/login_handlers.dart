// ignore_for_file: use_build_context_synchronously

import 'package:firebase_chat/core/errors/failure.dart';
import 'package:firebase_chat/utils/providers_calls.dart';
import 'package:flutter/widgets.dart';

import '../../../../core/types.dart';
import '../../../../init/initiators.dart';
import '../../../../utils/global_utils.dart';
import '../../data/models/user_model.dart';

class LoginHandlers {
  static Future<void> googleSignInHandler(BuildContext context) async {
    var res = await Providers.userPf(context).googleSignIn();
    var data = res.fold((l) => l, (r) => r);
    if (data is Failure) {
      logger.e(data);
      GlobalUtils.showSnackBar(
        context: context,
        message: ErrorMapper(data).map(),
        snackBarType: SnackBarType.error,
      );
    } else if (data is UserModel) {
      GlobalUtils.showSnackBar(
        context: context,
        message: 'Logged in successfully',
        snackBarType: SnackBarType.info,
      );
    }
  }
}
