import 'package:flutter/material.dart';

import 'app_fonts.dart';

/// Colorless text styles. The color comes from the active theme
/// (`textTheme`), or add one with `.copyWith(color: ...)`.
class AppTextStyles {
  const AppTextStyles._();



  static const buttonStyle = TextStyle(
    fontFamily: AppFonts.poppins,
    fontSize: 15,
    fontWeight: FontWeight.w700,
  );

  // xs - 12
  static const xsRegular = TextStyle(
    fontFamily: AppFonts.poppins,
    fontSize: 12,
    fontWeight: FontWeight.w400,
  );

  // s - 14
  static const sRegular = TextStyle(
    fontFamily: AppFonts.poppins,
    fontSize: 14,
    fontWeight: FontWeight.w400,
  );

  static const sMedium = TextStyle(
    fontFamily: AppFonts.poppins,
    fontSize: 14,
    fontWeight: FontWeight.w500,
  );

  // m - 16
  static const mRegular = TextStyle(
    fontFamily: AppFonts.poppins,
    fontSize: 16,
    fontWeight: FontWeight.w400,
  );

  static const mMedium = TextStyle(
    fontFamily: AppFonts.poppins,
    fontSize: 16,
    fontWeight: FontWeight.w500,
  );

  static const mBold = TextStyle(
    fontFamily: AppFonts.poppins,
    fontSize: 16,
    fontWeight: FontWeight.w700,
  );

  // xl - 20
  static const xlSemiBold = TextStyle(
    fontFamily: AppFonts.poppins,
    fontSize: 20,
    fontWeight: FontWeight.w600,
  );

  static const xlBold = TextStyle(
    fontFamily: AppFonts.poppins,
    fontSize: 20,
    fontWeight: FontWeight.w700,
  );
}
