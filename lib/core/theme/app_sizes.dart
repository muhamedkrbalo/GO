import 'package:flutter/material.dart';

/// Spacing scale for padding, margins and gaps between widgets.
class AppSpacing {
  const AppSpacing._();

  static const double xxs2 = 2;
  static const double xs5 = 5;
  static const double s8= 8;
  static const double m10= 10;
  static const double l15 = 15;
  static const double xl20 = 20;
  static const double xxl24 = 24;

  // Gaps (use inside Row / Column)
  static const gapH5 = SizedBox(width: xs5);
  static const gapH8 = SizedBox(width: s8);
  static const gapH10 = SizedBox(width: m10);
  static const gapH15 = SizedBox(width: l15);
  static const gapH20 = SizedBox(width: xl20);

  static const gapV5 = SizedBox(height: xs5);
  static const gapV8 = SizedBox(height: s8);
  static const gapV10 = SizedBox(height: m10);
  static const gapV15 = SizedBox(height: l15);
  static const gapV20 = SizedBox(height: xl20);
  static const gapV24 = SizedBox(height: xxl24);
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
