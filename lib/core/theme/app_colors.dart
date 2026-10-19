import 'package:flutter/material.dart';

/// Raw color palette. Never changes with the theme.
///
/// For colors that differ between light and dark mode use
/// `context.customColors` (see [CustomColors]).
class AppColors {
  const AppColors._();

  // primary
  static const primary = Color(0xff0F766E);
  static const primaryLight = Color(0xffCCFBF1);
  static const primaryDark = Color(0xff115E59);
  static const primarySurface = Color(0xffF0FDFA);
  static const primaryMuted = Color(0xff79AAA6);
  static const secondary = Color(0xff0F172A);

  // neutrals
  static const white = Color(0xffffffff);
  static const offWhite = Color(0xFFF5F5F5);
  static const ivory = Color(0xffFAF8F3);
  static const black = Color(0xff000000);
  static const text = Color(0xFF0A0A0A);
  static const hint = Color(0xff94A3B8);
  static const lightText = Color(0xffD1D5DC);
  static const grey = Color(0xFF888888);
  static const darkGrey = Color(0xff666666);
  static const lightGrey = Color(0xffA6A6A6);
  static const border = Color(0xffCBD5E1);
  static const lightBorder = Color(0xffE2E8F0);
  static const muted = Color(0xff64748B);
  static const mist = Color(0xffD8E8E8);
  static const divider = Color(0xFFDADADA);
  static const textFormFill = Color(0xffffffff);

  // dark mode neutrals
  static const darkScaffold = Color(0xff0D0D12);
  static const darkSurface = Color(0xff1A1B25);
  static const darkSurfaceVariant = Color(0xff272835);
  static const darkBorder = Color(0xff36394A);
  static const darkHint = Color(0xffA4ACB9);
  static const darkSecondaryText = Color(0xffDFE1E7);

  // status
  static const red = Color(0xffF5222D);
  static const error = Color(0xffB42318);
  static const errorSurface = Color(0xffFEF3F2);
  static const darkError = Color(0xffF97066);
  static const darkErrorSurface = Color(0xff3B1D1D);
  static const success = Color(0xff067647);
  static const successSurface = Color(0xffECFDF3);
  static const successBorder = Color(0xffA6F4C5);
  static const darkSuccess = Color(0xff32D583);
  static const darkSuccessSurface = Color(0xff053321);
  static const darkSuccessBorder = Color(0xff085D3A);



 
}
