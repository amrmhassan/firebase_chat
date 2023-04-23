import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../init/initiators.dart';
import '../color_theme.dart';
import '../size_theme.dart';

ColorTheme _defaultColorTheme = const ColorTheme();
SizeTheme _defaultSizeTheme = SizeTheme();

class ThemeProvider extends ChangeNotifier {
  ColorTheme defaultColors = _defaultColorTheme;
  SizeTheme defaultSizes = _defaultSizeTheme;

  void updateColorTheme(ColorTheme newColorTheme) {
    defaultColors = newColorTheme;
    notifyListeners();
  }
}

ThemeProvider get themeProvider =>
    Provider.of<ThemeProvider>(navigatorKey.currentContext!);
