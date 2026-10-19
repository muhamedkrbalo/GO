import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../../core/images/app_images.dart';
import '../../../../../core/locale/app_locale_key.dart';
import '../../../../../core/theme/app_sizes.dart';
import '../../../../../core/theme/app_text_styles.dart';
import '../../../../../core/theme/extensions/theme_extensions.dart';

class AccountVerifiedBadge extends StatelessWidget {
  const AccountVerifiedBadge({super.key});

  static const _minHeight = 32.0;
  static const _padding = EdgeInsetsDirectional.fromSTEB(6, 5, 10.4, 5);
  static const _borderWidth = 1.6;
  static const _checkCircleSize = 20.0;
  static const _checkIconSize = 13.6;

  @override
  Widget build(BuildContext context) {
    final colors = context.customColors;

    return Container(
      constraints: const BoxConstraints(minHeight: _minHeight),
      padding: _padding,
      decoration: BoxDecoration(
        color: colors.successSurface,
        borderRadius: AppRadius.brCircle,
        border: Border.all(color: colors.successBorder, width: _borderWidth),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          DecoratedBox(
            decoration: BoxDecoration(
              color: colors.success,
              shape: BoxShape.circle,
            ),
            child: SizedBox.square(
              dimension: _checkCircleSize,
              child: Center(
                child: SvgPicture.asset(
                  AppImages.assetsSvgCheck,
                  width: _checkIconSize,
                  height: _checkIconSize,
                  colorFilter: ColorFilter.mode(
                    colors.surface,
                    BlendMode.srcIn,
                  ),
                ),
              ),
            ),
          ),
          AppSpacing.gapH5,
          Text(
            AppLocaleKey.accountVerifiedBadge.tr(),
            style: AppTextStyles.xxsBold.copyWith(
              color: colors.success,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}
