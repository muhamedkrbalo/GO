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
    required this.textMuted,
    required this.border,
    required this.imagePlaceholder,
    required this.accentText,
    required this.subtleBorder,
    required this.surfaceWarm,
    required this.selectedSurface,
    required this.error,
    required this.errorSurface,
    required this.filledBorder,
    required this.success,
    required this.successSurface,
    required this.successBorder,
    required this.canvas,
    required this.primary,
    required this.onPrimary,
    required this.info,
    required this.infoSurface,
    required this.infoBorder,
    required this.warning,
    required this.warningSurface,
    required this.primaryBorder,
  });

  static const light = CustomColors(
    textPrimary: AppColors.primary,
    textSecondary: AppColors.secondary,
    hint: AppColors.hint,
    onBackground: AppColors.black,
    surface: AppColors.white,
    surfaceVariant: AppColors.offWhite,
    appBar: AppColors.white,
    textFormFill: AppColors.textFormFill,
    textFormBorder: AppColors.border,
    divider: AppColors.divider,
    grey: AppColors.grey,
    lightGrey: AppColors.lightGrey,
    darkGrey: AppColors.darkGrey,
    primaryLight: AppColors.primaryLight,
    textMuted: AppColors.muted,
    border: AppColors.border,
    imagePlaceholder: AppColors.mist,
    accentText: AppColors.primaryDark,
    subtleBorder: AppColors.lightBorder,
    surfaceWarm: AppColors.ivory,
    selectedSurface: AppColors.primarySurface,
    error: AppColors.error,
    errorSurface: AppColors.errorSurface,
    filledBorder: AppColors.primaryMuted,
    success: AppColors.success,
    successSurface: AppColors.successSurface,
    successBorder: AppColors.successBorder,
    canvas: AppColors.canvas,
    primary: AppColors.primary,
    onPrimary: AppColors.white,
    info: AppColors.info,
    infoSurface: AppColors.infoSurface,
    infoBorder: AppColors.infoBorder,
    warning: AppColors.warning,
    warningSurface: AppColors.warningSurface,
    primaryBorder: AppColors.primaryBorder,
  );

  static const dark = CustomColors(
    textPrimary: AppColors.primary,
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
    textMuted: AppColors.darkHint,
    border: AppColors.darkBorder,
    imagePlaceholder: AppColors.darkSurfaceVariant,
    accentText: AppColors.primaryLight,
    subtleBorder: AppColors.darkBorder,
    surfaceWarm: AppColors.darkSurfaceVariant,
    selectedSurface: AppColors.darkSurfaceVariant,
    error: AppColors.darkError,
    errorSurface: AppColors.darkErrorSurface,
    filledBorder: AppColors.primary,
    success: AppColors.darkSuccess,
    successSurface: AppColors.darkSuccessSurface,
    successBorder: AppColors.darkSuccessBorder,
    canvas: AppColors.darkScaffold,
    primary: AppColors.primary,
    onPrimary: AppColors.white,
    info: AppColors.darkInfo,
    infoSurface: AppColors.darkInfoSurface,
    infoBorder: AppColors.darkInfoBorder,
    warning: AppColors.darkWarning,
    warningSurface: AppColors.darkWarningSurface,
    primaryBorder: AppColors.primaryDark,
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

  /// Low-emphasis text: descriptions, captions, secondary buttons.
  final Color textMuted;

  /// Outlines of secondary buttons and inactive indicators.
  final Color border;

  /// Shown behind images while they load.
  final Color imagePlaceholder;

  /// Brand-colored text on a light surface (e.g. outlined button labels).
  final Color accentText;

  final Color subtleBorder;

  final Color surfaceWarm;
  final Color selectedSurface;
  final Color error;
  final Color errorSurface;
  final Color filledBorder;
  final Color success;
  final Color successSurface;
  final Color successBorder;
  final Color canvas;
  final Color primary;
  final Color onPrimary;
  final Color info;
  final Color infoSurface;
  final Color infoBorder;
  final Color warning;
  final Color warningSurface;
  final Color primaryBorder;

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
    Color? textMuted,
    Color? border,
    Color? imagePlaceholder,
    Color? accentText,
    Color? subtleBorder,
    Color? surfaceWarm,
    Color? selectedSurface,
    Color? error,
    Color? errorSurface,
    Color? filledBorder,
    Color? success,
    Color? successSurface,
    Color? successBorder,
    Color? canvas,
    Color? primary,
    Color? onPrimary,
    Color? info,
    Color? infoSurface,
    Color? infoBorder,
    Color? warning,
    Color? warningSurface,
    Color? primaryBorder,
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
      textMuted: textMuted ?? this.textMuted,
      border: border ?? this.border,
      imagePlaceholder: imagePlaceholder ?? this.imagePlaceholder,
      accentText: accentText ?? this.accentText,
      subtleBorder: subtleBorder ?? this.subtleBorder,
      surfaceWarm: surfaceWarm ?? this.surfaceWarm,
      selectedSurface: selectedSurface ?? this.selectedSurface,
      error: error ?? this.error,
      errorSurface: errorSurface ?? this.errorSurface,
      filledBorder: filledBorder ?? this.filledBorder,
      success: success ?? this.success,
      successSurface: successSurface ?? this.successSurface,
      successBorder: successBorder ?? this.successBorder,
      canvas: canvas ?? this.canvas,
      primary: primary ?? this.primary,
      onPrimary: onPrimary ?? this.onPrimary,
      info: info ?? this.info,
      infoSurface: infoSurface ?? this.infoSurface,
      infoBorder: infoBorder ?? this.infoBorder,
      warning: warning ?? this.warning,
      warningSurface: warningSurface ?? this.warningSurface,
      primaryBorder: primaryBorder ?? this.primaryBorder,
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
      textMuted: Color.lerp(textMuted, other.textMuted, t)!,
      border: Color.lerp(border, other.border, t)!,
      imagePlaceholder: Color.lerp(imagePlaceholder, other.imagePlaceholder, t)!,
      accentText: Color.lerp(accentText, other.accentText, t)!,
      subtleBorder: Color.lerp(subtleBorder, other.subtleBorder, t)!,
      surfaceWarm: Color.lerp(surfaceWarm, other.surfaceWarm, t)!,
      selectedSurface: Color.lerp(selectedSurface, other.selectedSurface, t)!,
      error: Color.lerp(error, other.error, t)!,
      errorSurface: Color.lerp(errorSurface, other.errorSurface, t)!,
      filledBorder: Color.lerp(filledBorder, other.filledBorder, t)!,
      success: Color.lerp(success, other.success, t)!,
      successSurface: Color.lerp(successSurface, other.successSurface, t)!,
      successBorder: Color.lerp(successBorder, other.successBorder, t)!,
      canvas: Color.lerp(canvas, other.canvas, t)!,
      primary: Color.lerp(primary, other.primary, t)!,
      onPrimary: Color.lerp(onPrimary, other.onPrimary, t)!,
      info: Color.lerp(info, other.info, t)!,
      infoSurface: Color.lerp(infoSurface, other.infoSurface, t)!,
      infoBorder: Color.lerp(infoBorder, other.infoBorder, t)!,
      warning: Color.lerp(warning, other.warning, t)!,
      warningSurface: Color.lerp(warningSurface, other.warningSurface, t)!,
      primaryBorder: Color.lerp(primaryBorder, other.primaryBorder, t)!,
    );
  }
}

extension CustomColorsExtension on ThemeData {
  CustomColors get customColors => extension<CustomColors>() ?? CustomColors.light;
}
