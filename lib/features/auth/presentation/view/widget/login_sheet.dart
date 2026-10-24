import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../../core/locale/app_locale_key.dart';
import '../../../../../core/theme/app_shadows.dart';
import '../../../../../core/theme/app_sizes.dart';
import '../../../../../core/theme/app_text_styles.dart';
import '../../../../../core/theme/extensions/theme_extensions.dart';
import 'login_back_button.dart';
import 'login_form.dart';

class LoginSheet extends StatelessWidget {
  const LoginSheet({super.key});

  static const _padding = EdgeInsetsDirectional.fromSTEB(24, 16, 24, 34);
  static const _radius = BorderRadius.vertical(top: Radius.circular(34));
  static const _handleWidth = 42.0;
  static const _handleHeight = 4.0;
  static const _eyebrowLetterSpacing = 1.8;
  static const _titleLetterSpacing = -0.9;
  static const _titleHeight = 1.5;
  static const _subtitleHeight = 1.55;
  static const _subtitleToFormGap = 18.0;

  @override
  Widget build(BuildContext context) {
    final colors = context.customColors;

    return Container(
      width: double.infinity,
      padding: _padding,
      decoration: BoxDecoration(
        color: colors.surfaceWarm,
        borderRadius: _radius,
        boxShadow: AppShadows.sheet,
      ),
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: _handleWidth,
                height: _handleHeight,
                decoration: BoxDecoration(
                  color: colors.lightGrey,
                  borderRadius: AppRadius.brCircle,
                ),
              ),
            ),
            AppSpacing.gapV10,
            const LoginBackButton(),
            AppSpacing.gapV10,
            Text(
              AppLocaleKey.welcomeBackTag.tr().toUpperCase(),
              style: AppTextStyles.xxxsBold.copyWith(
                color: colors.eyebrow,
                letterSpacing: _eyebrowLetterSpacing,
              ),
            ),
            AppSpacing.gapV8,
            Text(
              AppLocaleKey.loginToGo.tr(),
              style: AppTextStyles.displaySmBold.copyWith(
                color: colors.accentText,
                letterSpacing: _titleLetterSpacing,
                height: _titleHeight,
              ),
            ),
            Text(
              AppLocaleKey.loginSubtitle.tr(),
              style: AppTextStyles.xsRegular.copyWith(
                color: colors.darkGrey,
                height: _subtitleHeight,
              ),
            ),
            const SizedBox(height: _subtitleToFormGap),
            const LoginForm(),
          ],
        ),
      ),
    );
  }
}
