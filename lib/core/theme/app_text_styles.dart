import 'package:flutter/material.dart';

import 'app_fonts.dart';

/// Colorless text styles. The color comes from the active theme
/// (`textTheme`), or add one with `.copyWith(color: ...)`.
class AppTextStyles {
  const AppTextStyles._();



  static const buttonStyle = TextStyle(
    fontFamily: AppFonts.inter,
    fontSize: 15,
    fontWeight: FontWeight.w700,
  );


  // xxs - 11
  static const xxsBold = TextStyle(
    fontFamily: AppFonts.inter,
    fontSize: 11,
    fontWeight: FontWeight.w700,
  );

  // xs - 12
  static const xsMedium = TextStyle(
    fontFamily: AppFonts.inter,
    fontSize: 12,
    fontWeight: FontWeight.w500,
  );

  static const xsRegular = TextStyle(
    fontFamily: AppFonts.inter,
    fontSize: 12,
    fontWeight: FontWeight.w400,
  );

   static const xsSemiBold = TextStyle(
    fontFamily: AppFonts.inter,
    fontSize: 13,
    fontWeight: FontWeight.w600,
  );


  // s - 14
  static const sRegular = TextStyle(
    fontFamily: AppFonts.inter,
    fontSize: 14,
    fontWeight: FontWeight.w400,
  );

  static const sMedium = TextStyle(
    fontFamily: AppFonts.inter,
    fontSize: 14,
    fontWeight: FontWeight.w500,
  );
   static const sSemiBold = TextStyle(
    fontFamily: AppFonts.inter,
    fontSize: 14,
    fontWeight: FontWeight.w600,
  );


  // m - 16
  static const mRegular = TextStyle(
    fontFamily: AppFonts.inter,
    fontSize: 16,
    fontWeight: FontWeight.w400,
  );

  static const mMedium = TextStyle(
    fontFamily: AppFonts.inter,
    fontSize: 16,
    fontWeight: FontWeight.w500,
  );

  static const mBold = TextStyle(
    fontFamily: AppFonts.inter,
    fontSize: 16,
    fontWeight: FontWeight.w700,
  );

  // xl - 20
  static const xlSemiBold = TextStyle(
    fontFamily: AppFonts.inter,
    fontSize: 20,
    fontWeight: FontWeight.w600,
  );

  static const xlBold = TextStyle(
    fontFamily: AppFonts.inter,
    fontSize: 20,
    fontWeight: FontWeight.w700,
  );

  // xxl - 28
  static const xxlBold = TextStyle(
    fontFamily: AppFonts.inter,
    fontSize: 28,
    fontWeight: FontWeight.w700,
  );

  // xxxl - 32
  static const xxxlBold = TextStyle(
    fontFamily: AppFonts.inter,
    fontSize: 32,
    fontWeight: FontWeight.w700,
  );
}
/*

9:51 PM
The naming is mostly good. Size plus weight (mRegular, xlBold) is a common, readable pattern, and keeping color out of the styles is the right call. There are a few inconsistencies worth fixing:

Issues
xsSemiBold is size 13, but the xs group is 12 (app_text_styles.dart:28). Either it's a typo, or 13 needs its own name. Each size label should map to exactly one font size, or the scale stops meaning anything.
The scale skips l. It goes xs → s → m → xl. If 18 isn't used yet, rename xl to l or leave a gap on purpose. Otherwise someone will add an 18 later and won't know what to call it.
buttonStyle breaks the pattern. It's 15 / w700, so it doesn't fit the scale, and the Style suffix repeats what the class name already says. Pick one approach:
If buttons can use an existing size, just use mBold (16 / w700) and delete buttonStyle.
If it's a semantic style on purpose, call it button and group it under a "semantic" section.
Single letters are terse. s and m read fine next to xs and xl, but sm/md/lg or small/medium/large are clearer when you see them alone at a call site (AppTextStyles.mMedium reads oddly: "medium medium").
Small cleanup: fix the indentation on line 26 and the extra blank lines (9–11, 17–18).
Suggested shape

// xs - 12
static const xsRegular  = ...12, w400
static const xsSemiBold = ...12, w600

// sm - 14
static const smRegular = ...14, w400
static const smMedium  = ...14, w500

// md - 16
static const mdRegular = ...16, w400
static const mdMedium  = ...16, w500
static const mdBold    = ...16, w700

// lg - 20   (or keep xl and add lg = 18 if needed)
static const lgSemiBold = ...20, w600
static const lgBold     = ...20, w700

// Semantic
static const button = ...15, w700
*/