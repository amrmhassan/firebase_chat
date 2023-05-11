// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

import '../../features/theming/constants/sizes.dart';

class UserAvatar extends StatelessWidget {
  final String? userImage;
  final bool group;
  final double radius;
  final bool largeIcon;
  final double? borderRadius;
  final IconData? defaultIcon;

  const UserAvatar({
    super.key,
    required this.userImage,
    this.group = false,
    this.radius = largeIconSize * 1.2,
    this.largeIcon = false,
    this.borderRadius,
    this.defaultIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.hardEdge,
      alignment: Alignment.center,
      width: radius,
      height: radius,
      decoration: BoxDecoration(
        color: Colors.grey.withOpacity(.5),
        borderRadius: BorderRadius.circular(
          borderRadius ?? 1000,
        ),
      ),
      child: userImage == null
          ? Container(
              padding: EdgeInsets.all(smallPadding),
              child: Icon(
                defaultIcon ?? (group ? Icons.group : Icons.person),
                size: largeIcon
                    ? (radius - smallPadding * 7)
                    : (radius - smallPadding * 2) > mediumIconSize
                        ? mediumIconSize
                        : (radius - smallPadding * 2),
                color: Colors.black.withOpacity(.6),
              ),
            )
          : Image.network(
              userImage!,
              fit: BoxFit.cover,
              height: double.infinity,
              width: double.infinity,
              alignment: Alignment.topCenter,
            ),
    );
  }
}
