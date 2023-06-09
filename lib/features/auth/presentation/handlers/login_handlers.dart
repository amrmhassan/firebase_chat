// ignore_for_file: use_build_context_synchronously

import 'package:firebase_chat/core/errors/failure.dart';
import 'package:firebase_chat/features/auth/presentation/providers/user_provider.dart';
import 'package:firebase_chat/utils/providers_calls.dart';
import 'package:flutter/widgets.dart';

import '../../../../core/types.dart';
import '../../../../init/runtime_variables.dart';
import '../../../../utils/global_utils.dart';
import '../../data/models/user_model.dart';

class LoginHandlers {
  static Future<void> googleLogin(BuildContext context) async {
    // var res = await Providers.userPf(context)
    //     .signIn(SignInImpl(GoogleLoginDataSource()));
    var res = await Providers.userPf(context).auth(AuthType.google);
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

  static Future<dynamic> facebookLogin(BuildContext context) async {
    var res = await Providers.userPf(context).auth(AuthType.facebook);
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
    return data;
  }
}
