// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'constants/colors.dart';

part 'color_theme.g.dart';

@CopyWith()
class ColorTheme {
  final Color backGround;
  final Color cardBackground;
  final Color cardBackgroundDark;
  final Color lightCardBackground;
  final Color kInactiveColor;
  final Color kBlueColor;
  final Color textFieldBackgroundColor;
  final Color kMainIconColor;
  final Color kDangerColor;
  final Color kGreenColor;

  final Color activeText;
  final Color inActiveText;

  const ColorTheme({
    this.backGround = CustomColors.kBackgroundColor,
    this.cardBackground = CustomColors.kCardBackgroundColor,
    this.cardBackgroundDark = CustomColors.kCardBackgroundColorDark,
    this.lightCardBackground = CustomColors.kLightCardBackgroundColor,
    this.kInactiveColor = CustomColors.kInactiveColor,
    this.kBlueColor = CustomColors.kBlueColor,
    this.textFieldBackgroundColor = CustomColors.textFieldBackgroundColor,
    this.kMainIconColor = CustomColors.kBlueColor,
    this.kDangerColor = CustomColors.kDangerColor,
    this.kGreenColor = CustomColors.kGreenColor,
    this.activeText = TextColors.kActiveTextColor,
    this.inActiveText = TextColors.kInActiveTextColor,
  });
}
