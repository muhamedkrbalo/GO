import 'package:flutter/material.dart';

import 'custom_colors_extension.dart';

extension ThemeContextExtension on BuildContext {
  ThemeData get theme => Theme.of(this);

  TextTheme get textTheme => Theme.of(this).textTheme;

  bool get isDarkMode => Theme.of(this).brightness == Brightness.dark;

  CustomColors get customColors => Theme.of(this).customColors;
}
