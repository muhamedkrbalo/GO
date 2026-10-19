import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../../core/images/app_images.dart';
import '../../../../../core/locale/app_locale_key.dart';
import '../../../../../core/theme/app_sizes.dart';
import '../../../../../core/theme/app_text_styles.dart';
import '../../../../../core/theme/extensions/theme_extensions.dart';
import 'owner_registration_header.dart';

class RegistrationProgressHeader extends StatelessWidget {
  const RegistrationProgressHeader({
    super.key,
    required this.step,
    required this.progress,
    required this.completedLabel,
  });

  final int step;
  final double progress;
  final String completedLabel;

  static const _padding = EdgeInsets.fromLTRB(20, 12.8, 20, 14.4);
  static const _borderWidth = 1.6;
  static const _barHeight = 4.8;
  static const _checkCircleSize = 16.0;
  static const _checkIconSize = 11.5;

  @override
  Widget build(BuildContext context) {
    final colors = context.customColors;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: colors.canvas,
        border: Border(
          bottom: BorderSide(color: colors.subtleBorder, width: _borderWidth),
        ),
      ),
      child: Padding(
        padding: _padding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const OwnerRegistrationHeader(),
            AppSpacing.gapV12,
            Row(
              children: [
                Expanded(
                  child: Text(
                    AppLocaleKey.stepOfOwnerRegistration.tr(args: ['$step']),
                    style: AppTextStyles.xsBold.copyWith(color: colors.textSecondary, height: 1.5),
                  ),
                ),
                Text(
                  '${(progress * 100).round()}%',
                  style: AppTextStyles.xxsBold.copyWith(
                    color: colors.textPrimary,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ],
            ),
            AppSpacing.gapV8,
            ClipRRect(
              borderRadius: AppRadius.brCircle,
              child: LinearProgressIndicator(
                value: progress,
                minHeight: _barHeight,
                backgroundColor: colors.subtleBorder,
                valueColor: AlwaysStoppedAnimation(colors.primary),
              ),
            ),
            AppSpacing.gapV8,
            Row(
              children: [
                DecoratedBox(
                  decoration: BoxDecoration(color: colors.primary, shape: BoxShape.circle),
                  child: SizedBox.square(
                    dimension: _checkCircleSize,
                    child: Center(
                      child: SvgPicture.asset(
                        AppImages.assetsSvgCheck,
                        width: _checkIconSize,
                        height: _checkIconSize,
                        colorFilter: ColorFilter.mode(colors.onPrimary, BlendMode.srcIn),
                      ),
                    ),
                  ),
                ),
                AppSpacing.gapH5,
                Text(
                  completedLabel,
                  style: AppTextStyles.xxsRegular.copyWith(
                    color: colors.textMuted,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
