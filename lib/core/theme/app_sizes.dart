import 'package:flutter/material.dart';

/// Spacing scale for padding, margins and gaps between widgets.
class AppSpacing {
  const AppSpacing._();

  static const double xxs2 = 2;
  static const double xs5 = 5;
  static const double s8= 8;
  static const double m10= 10;
  static const double l15 = 15;
  static const double l16 = 16;
  static const double xl20 = 20;
  static const double sm12 = 12;
  static const double xxl24 = 24;
  static const double xxxl32 = 32;
  static const double xxxxl40 = 40;

  // Gaps (use inside Row / Column)
  static const gapH5 = SizedBox(width: xs5);
  static const gapH8 = SizedBox(width: s8);
  static const gapH10 = SizedBox(width: m10);
  static const gapH15 = SizedBox(width: l15);
  static const gapH16 = SizedBox(width: l16);
  static const gapH20 = SizedBox(width: xl20);

  static const gapV5 = SizedBox(height: xs5);
  static const gapV8 = SizedBox(height: s8);
  static const gapV10 = SizedBox(height: m10);
  static const gapV12 = SizedBox(height: sm12);
  static const gapV15 = SizedBox(height: l15);
  static const gapV20 = SizedBox(height: xl20);
  static const gapV24 = SizedBox(height: xxl24);
  static const gapV32 = SizedBox(height: xxxl32);
}

/// Ready-made [EdgeInsets] for `padding:` (and `margin:` via [AppMargin]).
class AppPadding {
  const AppPadding._();

  // All sides
  static const all5 = EdgeInsets.all(AppSpacing.xs5);
  static const all8 = EdgeInsets.all(AppSpacing.s8);
  static const all10 = EdgeInsets.all(AppSpacing.m10);
  static const all15 = EdgeInsets.all(AppSpacing.l15);
  static const all20 = EdgeInsets.all(AppSpacing.xl20);

  // Horizontal only
  static const h10 = EdgeInsets.symmetric(horizontal: AppSpacing.m10);
  static const h15 = EdgeInsets.symmetric(horizontal: AppSpacing.l15);
  static const h20 = EdgeInsets.symmetric(horizontal: AppSpacing.xl20);
  static const h16 = EdgeInsets.symmetric(horizontal: AppSpacing.l16);
  static const h24 = EdgeInsets.symmetric(horizontal: AppSpacing.xxl24);

  // Vertical only
  static const v5 = EdgeInsets.symmetric(vertical: AppSpacing.xs5);
  static const v10 = EdgeInsets.symmetric(vertical: AppSpacing.m10);
  static const v20 = EdgeInsets.symmetric(vertical: AppSpacing.xl20);

  // Vertical + horizontal
  static const v5h10 = EdgeInsets.symmetric(vertical: AppSpacing.xs5, horizontal: AppSpacing.m10);
  static const v5h20 = EdgeInsets.symmetric(vertical: AppSpacing.xs5, horizontal: AppSpacing.xl20);
  static const v10h15 = EdgeInsets.symmetric(vertical: AppSpacing.m10, horizontal: AppSpacing.l15);
  static const v10h20 = EdgeInsets.symmetric(vertical: AppSpacing.m10, horizontal: AppSpacing.xl20);
  static const v20h10 = EdgeInsets.symmetric(vertical: AppSpacing.xl20, horizontal: AppSpacing.m10);
  static const v16h16 = EdgeInsets.symmetric(vertical: AppSpacing.l16, horizontal: AppSpacing.l16);

  // Per side (t = top, h = horizontal, b = bottom)
  static const h24b24 = EdgeInsets.fromLTRB(AppSpacing.xxl24, 0, AppSpacing.xxl24, AppSpacing.xxl24);
  static const t15h24b24 = EdgeInsets.fromLTRB(
    AppSpacing.xxl24,
    AppSpacing.l15,
    AppSpacing.xxl24,
    AppSpacing.xxl24,
  );
  static const t40h24b20 = EdgeInsets.fromLTRB(
    AppSpacing.xxl24,
    AppSpacing.xxxxl40,
    AppSpacing.xxl24,
    AppSpacing.xl20,
  );
  static const t40h24b24 = EdgeInsets.fromLTRB(
    AppSpacing.xxl24,
    AppSpacing.xxxxl40,
    AppSpacing.xxl24,
    AppSpacing.xxl24,
  );
}

/// Same values as [AppPadding], named for `margin:` so call sites read clearly.
typedef AppMargin = AppPadding;

/// Corner radius scale.
class AppRadius {
  const AppRadius._();

  static const double s8 = 8;
  static const double m10 = 10;
  static const double l25 = 25;
  static const double circle = 50;

  static const brS = BorderRadius.all(Radius.circular(s8));
  static const brM = BorderRadius.all(Radius.circular(m10));
  static const brL = BorderRadius.all(Radius.circular(l25));
  static const brCircle = BorderRadius.all(Radius.circular(circle));
}
