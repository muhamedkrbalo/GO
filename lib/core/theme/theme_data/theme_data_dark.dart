import 'package:flutter/material.dart';

import '../app_colors.dart';
import '../extensions/custom_colors_extension.dart';
import 'base_theme_data.dart';

ThemeData getDarkTheme() {
  return buildAppTheme(
    brightness: Brightness.dark,
    scaffold: AppColors.darkScaffold,
    colors: CustomColors.dark,
  );
}
