// ignore_for_file: prefer_const_constructors, use_build_context_synchronously, prefer_const_literals_to_create_immutables

import 'package:firebase_chat/fast_tools/widgets/button_wrapper.dart';
import 'package:firebase_chat/fast_tools/widgets/h_space.dart';
import 'package:firebase_chat/fast_tools/widgets/v_line.dart';
import 'package:firebase_chat/features/auth/data/models/user_model.dart';
import 'package:firebase_chat/features/theming/constants/sizes.dart';
import 'package:firebase_chat/features/theming/constants/styles.dart';
import 'package:firebase_chat/features/theming/theme_calls.dart';
import 'package:firebase_chat/utils/providers_calls.dart';
import 'package:flutter/material.dart';

class HomeScreenAppBarActionSearch extends StatelessWidget {
  const HomeScreenAppBarActionSearch({
    super.key,
    required this.userLoaded,
  });

  final bool userLoaded;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        VLine(
          color: colorTheme.kInactiveColor,
          thickness: 1,
          heightFactor: .5,
        ),
        HSpace(factor: .5),
        userLoaded
            ? IconButton(
                onPressed: () async {},
                icon: Icon(
                  Icons.search,
                ),
              )
            : IconButton(
                onPressed: () {},
                icon: SizedBox(
                  height: mediumIconSize,
                  width: mediumIconSize,
                  child: CircularProgressIndicator(
                    strokeWidth: 1.4,
                  ),
                ),
              ),
        HSpace(factor: .5),
      ],
    );
  }
}

class HomeScreenAppBarActionInvite extends StatelessWidget {
  const HomeScreenAppBarActionInvite({
    super.key,
    required this.userLoaded,
  });

  final bool userLoaded;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        VLine(
          color: colorTheme.kInactiveColor,
          thickness: 1,
          heightFactor: .5,
        ),
        HSpace(factor: .5),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ButtonWrapper(
              onTap: userLoaded ? () {} : null,
              padding: EdgeInsets.symmetric(
                horizontal: kHPad / 2,
                vertical: kVPad / 2,
              ),
              borderRadius: 1000,
              backgroundColor: colorTheme.cardBackground,
              child: Row(
                children: [
                  Icon(
                    Icons.add,
                    size: smallIconSize,
                    color: colorTheme.activeText,
                  ),
                  Text(
                    'Invite',
                    style: h4TextStyleInactive.copyWith(
                      color: colorTheme.activeText,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        HSpace(factor: .5),
      ],
    );
  }
}

class HomeScreenAppBarTitle extends StatelessWidget {
  const HomeScreenAppBarTitle({
    super.key,
    required this.userModel,
  });

  final UserModel userModel;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        FutureBuilder<String?>(
            future: userModel.photoUrl,
            builder: (context, snapshot) {
              if (snapshot.data == null) {
                return SizedBox();
              }
              return ButtonWrapper(
                onTap: () {
                  Providers.userPf(context).logout();
                },
                clipBehavior: Clip.hardEdge,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(1000),
                ),
                child: Image.network(
                  snapshot.data!,
                  width: largeIconSize,
                  height: largeIconSize,
                  alignment: Alignment.topCenter,
                ),
              );
            }),
        HSpace(),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                userModel.name,
                style: h3TextStyle,
              ),
              Text(
                userModel.email,
                style: h5InactiveTextStyle,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
