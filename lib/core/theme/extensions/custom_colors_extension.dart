import 'package:flutter/material.dart';

import '../app_colors.dart';

/// Colors that change between light and dark mode.
///
/// Registered on [ThemeData.extensions], so it animates with theme changes.
/// Read it with `context.customColors`.
@immutable
class CustomColors extends ThemeExtension<CustomColors> {
  const CustomColors({
    required this.textPrimary,
    required this.textSecondary,
    required this.hint,
    required this.onBackground,
    required this.surface,
    required this.surfaceVariant,
    required this.appBar,
    required this.textFormFill,
    required this.textFormBorder,
    required this.divider,
    required this.grey,
    required this.lightGrey,
    required this.darkGrey,
    required this.primaryLight,
  });

  static const light = CustomColors(
    textPrimary: AppColors.text,
    textSecondary: AppColors.secondary,
    hint: AppColors.hint,
    onBackground: AppColors.black,
    surface: AppColors.white,
    surfaceVariant: AppColors.offWhite,
    appBar: AppColors.white,
    textFormFill: AppColors.textFormFill,
    textFormBorder: Colors.transparent,
    divider: AppColors.divider,
    grey: AppColors.grey,
    lightGrey: AppColors.lightGrey,
    darkGrey: AppColors.darkGrey,
    primaryLight: AppColors.primaryLight,
  );

  static const dark = CustomColors(
    textPrimary: AppColors.white,
    textSecondary: AppColors.darkSecondaryText,
    hint: AppColors.darkHint,
    onBackground: AppColors.white,
    surface: AppColors.darkSurface,
    surfaceVariant: AppColors.darkSurfaceVariant,
    appBar: AppColors.darkScaffold,
    textFormFill: AppColors.darkSurfaceVariant,
    textFormBorder: Colors.transparent,
    divider: AppColors.darkBorder,
    grey: AppColors.darkHint,
    lightGrey: AppColors.darkGrey,
    darkGrey: AppColors.darkHint,
    primaryLight: AppColors.primaryDark,
  );

  /// Strong text: titles, form labels, input text.
  final Color textPrimary;

  /// Default body text.
  final Color textSecondary;
  final Color hint;

  /// Pure black in light mode, pure white in dark mode (icons, plain text).
  final Color onBackground;

  /// Cards, sheets, popups.
  final Color surface;
  final Color surfaceVariant;
  final Color appBar;
  final Color textFormFill;
  final Color textFormBorder;
  final Color divider;
  final Color grey;
  final Color lightGrey;
  final Color darkGrey;
  final Color primaryLight;

  @override
  CustomColors copyWith({
    Color? textPrimary,
    Color? textSecondary,
    Color? hint,
    Color? onBackground,
    Color? surface,
    Color? surfaceVariant,
    Color? appBar,
    Color? textFormFill,
    Color? textFormBorder,
    Color? divider,
    Color? grey,
    Color? lightGrey,
    Color? darkGrey,
    Color? primaryLight,
  }) {
    return CustomColors(
      textPrimary: textPrimary ?? this.textPrimary,
      textSecondary: textSecondary ?? this.textSecondary,
      hint: hint ?? this.hint,
      onBackground: onBackground ?? this.onBackground,
      surface: surface ?? this.surface,
      surfaceVariant: surfaceVariant ?? this.surfaceVariant,
      appBar: appBar ?? this.appBar,
      textFormFill: textFormFill ?? this.textFormFill,
      textFormBorder: textFormBorder ?? this.textFormBorder,
      divider: divider ?? this.divider,
      grey: grey ?? this.grey,
      lightGrey: lightGrey ?? this.lightGrey,
      darkGrey: darkGrey ?? this.darkGrey,
      primaryLight: primaryLight ?? this.primaryLight,
    );
  }

  @override
  CustomColors lerp(CustomColors? other, double t) {
    if (other is! CustomColors) return this;
    return CustomColors(
      textPrimary: Color.lerp(textPrimary, other.textPrimary, t)!,
      textSecondary: Color.lerp(textSecondary, other.textSecondary, t)!,
      hint: Color.lerp(hint, other.hint, t)!,
      onBackground: Color.lerp(onBackground, other.onBackground, t)!,
      surface: Color.lerp(surface, other.surface, t)!,
      surfaceVariant: Color.lerp(surfaceVariant, other.surfaceVariant, t)!,
      appBar: Color.lerp(appBar, other.appBar, t)!,
      textFormFill: Color.lerp(textFormFill, other.textFormFill, t)!,
      textFormBorder: Color.lerp(textFormBorder, other.textFormBorder, t)!,
      divider: Color.lerp(divider, other.divider, t)!,
      grey: Color.lerp(grey, other.grey, t)!,
      lightGrey: Color.lerp(lightGrey, other.lightGrey, t)!,
      darkGrey: Color.lerp(darkGrey, other.darkGrey, t)!,
      primaryLight: Color.lerp(primaryLight, other.primaryLight, t)!,
    );
  }
}

extension CustomColorsExtension on ThemeData {
  CustomColors get customColors => extension<CustomColors>() ?? CustomColors.light;
}
