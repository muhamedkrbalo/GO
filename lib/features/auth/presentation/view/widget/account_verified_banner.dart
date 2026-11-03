import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../../core/images/app_images.dart';
import '../../../../../core/locale/app_locale_key.dart';
import '../../../../../core/theme/app_sizes.dart';
import '../../../../../core/theme/app_text_styles.dart';
import '../../../../../core/theme/extensions/theme_extensions.dart';

class AccountVerifiedBanner extends StatelessWidget {
  const AccountVerifiedBanner({super.key});

  static const _minHeight = 38.0;
  static const _padding = EdgeInsetsDirectional.symmetric(horizontal: 12, vertical: 8);
  static const _surfaceOpacity = 0.07;
  static const _borderOpacity = 0.13;
  static const _checkCircleSize = 20.0;
  static const _checkIconSize = 12.0;
  static const _textHeight = 1.35;

  @override
  Widget build(BuildContext context) {
    final colors = context.customColors;

    return Container(
      width: double.infinity,
      constraints: const BoxConstraints(minHeight: _minHeight),
      padding: _padding,
      decoration: BoxDecoration(
        color: colors.cyanAccent.withValues(alpha: _surfaceOpacity),
        borderRadius: AppRadius.brM,
        border: Border.all(color: colors.oceanAccent.withValues(alpha: _borderOpacity)),
      ),
      child: Row(
        children: [
          DecoratedBox(
            decoration: BoxDecoration(color: colors.oceanAccent, shape: BoxShape.circle),
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
          AppSpacing.gapH10,
          Expanded(
            child: Text(
              AppLocaleKey.accountVerifiedSuccessfully.tr(),
              style: AppTextStyles.xxsSemiBold.copyWith(
                color: colors.oceanText,
                height: _textHeight,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
