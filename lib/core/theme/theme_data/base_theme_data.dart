import 'package:flutter/material.dart';
import 'package:flutter_hr_erb/core/theme/app_sizes.dart';

import '../app_colors.dart';
import '../app_fonts.dart';
import '../app_shadows.dart';
import '../app_text_styles.dart';
import '../extensions/custom_colors_extension.dart';

/// Shared [ThemeData] used by both light and dark themes.
/// Only the [brightness], [scaffold] color and [colors] differ.
ThemeData buildAppTheme({
  required Brightness brightness,
  required Color scaffold,
  required CustomColors colors,
}) {
  OutlineInputBorder border(Color color) => OutlineInputBorder(
        borderRadius: AppRadius.brM,
        borderSide: BorderSide(color: color),
      );

  return ThemeData(
    useMaterial3: false,
    brightness: brightness,
    platform: TargetPlatform.iOS,
    visualDensity: VisualDensity.adaptivePlatformDensity,
    fontFamily: AppFonts.poppins,
    primaryColor: AppColors.primary,
    hintColor: colors.hint,
    scaffoldBackgroundColor: scaffold,
    extensions: [colors],
    colorScheme: ColorScheme.fromSwatch(brightness: brightness).copyWith(
      primary: AppColors.primary,
      onPrimary: AppColors.white,
      secondary: AppColors.secondary,
      surface: colors.surface,
      onSurface: colors.textPrimary,
      error: AppColors.red,
    ),
    textTheme: ThemeData(brightness: brightness).textTheme.apply(
          fontFamily: AppFonts.poppins,
          bodyColor: colors.textSecondary,
          displayColor: colors.textPrimary,
        ),
    buttonTheme: const ButtonThemeData(
      buttonColor: AppColors.primary,
      alignedDropdown: true,
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: colors.appBar,
      foregroundColor: colors.textSecondary,
      elevation: 0,
      centerTitle: true,
      titleTextStyle: AppTextStyles.xlBold.copyWith(color: colors.textSecondary),
    ),
    bottomSheetTheme: BottomSheetThemeData(backgroundColor: colors.surface),
    dividerTheme: DividerThemeData(color: colors.divider),
    textSelectionTheme: const TextSelectionThemeData(cursorColor: AppColors.primary),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: colors.textFormFill,
      hintStyle: AppTextStyles.sRegular.copyWith(color: colors.hint),
      border: border(colors.textFormBorder),
      enabledBorder: border(colors.textFormBorder),
      disabledBorder: border(colors.textFormBorder),
      focusedBorder: border(AppColors.primary),
      errorBorder: border(AppColors.red),
    ),
    tabBarTheme: TabBarThemeData(
      dividerColor: Colors.transparent,
      indicatorSize: TabBarIndicatorSize.tab,
      indicator: const BoxDecoration(
        boxShadow: AppShadows.shadow1,
        color: AppColors.primary,
        borderRadius: AppRadius.brCircle,
      ),
      labelStyle: AppTextStyles.xsRegular.copyWith(color: AppColors.white),
      unselectedLabelStyle: AppTextStyles.xsRegular.copyWith(color: colors.darkGrey),
    ),
  );
}
