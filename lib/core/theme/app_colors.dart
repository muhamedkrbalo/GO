import 'package:flutter/material.dart';

/// Raw color palette. Never changes with the theme.
///
/// For colors that differ between light and dark mode use
/// `context.customColors` (see [CustomColors]).
class AppColors {
  const AppColors._();

  // primary
  static const primary = Color(0xff082E50);
  static const primaryLight = Color(0xffE8EEF0);
  static const primaryDark = Color(0xff062B51);
  static const primarySurface = Color(0xffF1F5F7);
  static const primaryMuted = Color(0xff829BAD);
  static const primaryBorder = Color(0xffB9C5CF);
  static const secondary = Color(0xff172B3E);

  // accent
  static const gold = Color(0xffC5A36A);
  static const goldLight = Color(0xffEFD99D);
  static const goldDark = Color(0xffC49B48);
  static const goldText = Color(0xff8B7654);

  // neutrals
  static const white = Color(0xffffffff);
  static const offWhite = Color(0xffF1F5F7);
  static const ivory = Color(0xffF8F7F2);
  static const black = Color(0xff000000);
  static const text = Color(0xff172B3E);
  static const hint = Color(0xff94A1AF);
  static const lightText = Color(0xffC6D3DC);
  static const grey = Color(0xff8593A0);
  static const darkGrey = Color(0xff617689);
  static const lightGrey = Color(0xffB8C5C9);
  static const border = Color(0xffD8E0E8);
  static const lightBorder = Color(0xffE1E7EC);
  static const canvas = Color(0xffF8FAFC);
  static const muted = Color(0xff617184);
  static const mist = Color(0xffE8EEF0);
  static const divider = Color(0xffD8E0E8);
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
  static const success = Color(0xff205F57);
  static const successSurface = Color(0xffEDF8F6);
  static const successBorder = Color(0xff26766C);
  static const darkSuccess = Color(0xff32D583);
  static const darkSuccessSurface = Color(0xff053321);
  static const darkSuccessBorder = Color(0xff085D3A);
  static const info = Color(0xff0369A1);
  static const infoSurface = Color(0xffF0F9FF);
  static const infoBorder = Color(0xffBAE6FD);
  static const darkInfo = Color(0xff7DD3FC);
  static const darkInfoSurface = Color(0xff082F49);
  static const darkInfoBorder = Color(0xff075985);
  static const warning = Color(0xff92400E);
  static const warningSurface = Color(0xffFEF3C7);
  static const darkWarning = Color(0xffFBBF24);
  static const darkWarningSurface = Color(0xff422006);
}
