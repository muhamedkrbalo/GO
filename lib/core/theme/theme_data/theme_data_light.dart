import 'package:flutter/material.dart';

import '../app_colors.dart';
import '../extensions/custom_colors_extension.dart';
import 'base_theme_data.dart';

ThemeData getLightTheme() {
  return buildAppTheme(
    brightness: Brightness.light,
    scaffold: AppColors.white,
    colors: CustomColors.light,
  );
}
