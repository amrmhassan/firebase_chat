import 'dart:ui';

import 'package:flutter/material.dart';

import '../../../../theming/theme_calls.dart';

loginAppBar([bool login = true]) => AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      title: Text(login ? 'Login' : 'Sign Up'),
      flexibleSpace: FlexibleSpaceBar(
          background: BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: 3,
          sigmaY: 3,
        ),
        child: Container(
          color: colorTheme.backGround.withOpacity(.5),
        ),
      )),
    );
