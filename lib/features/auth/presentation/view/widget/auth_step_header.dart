import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../../core/custom_widgets/buttons/header_back_button.dart';
import '../../../../../core/locale/app_locale_key.dart';
import '../../../../../core/theme/app_text_styles.dart';
import '../../../../../core/theme/extensions/theme_extensions.dart';

class AuthStepHeader extends StatelessWidget {
  const AuthStepHeader({
    super.key,
    required this.step,
    required this.stepCount,
    this.backgroundColor,
  });

  final int step;
  final int stepCount;
  final Color? backgroundColor;

  static const _minHeight = 72.0;
  static const _padding = EdgeInsetsDirectional.fromSTEB(24, 14, 24, 8);
  static const _backgroundOpacity = 0.96;
  static const _stepLetterSpacing = 1.4;
  static const _stepHeight = 1.5;

  @override
  Widget build(BuildContext context) {
    final colors = context.customColors;

    return Container(
      constraints: const BoxConstraints(minHeight: _minHeight),
      padding: _padding,
      color: backgroundColor ?? colors.canvas.withValues(alpha: _backgroundOpacity),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const HeaderBackButton(),
          Text(
            AppLocaleKey.stepXOfY.tr(args: ['$step', '$stepCount']).toUpperCase(),
            style: AppTextStyles.xxxsBold.copyWith(
              color: colors.stepLabel,
              letterSpacing: _stepLetterSpacing,
              height: _stepHeight,
            ),
          ),
        ],
      ),
    );
  }
}
