import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../../core/images/app_images.dart';
import '../../../../../core/locale/app_locale_key.dart';
import '../../../../../core/theme/app_sizes.dart';
import '../../../../../core/theme/app_text_styles.dart';
import '../../../../../core/theme/extensions/theme_extensions.dart';

class OwnershipReviewNotice extends StatelessWidget {
  const OwnershipReviewNotice({super.key});

  static const _padding = EdgeInsets.all(12.8);
  static const _radius = BorderRadius.all(Radius.circular(11.2));
  static const _borderWidth = 1.6;
  static const _iconSize = 16.0;

  @override
  Widget build(BuildContext context) {
    final colors = context.customColors;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: colors.infoSurface,
        borderRadius: _radius,
        border: Border.all(color: colors.infoBorder, width: _borderWidth),
      ),
      child: Padding(
        padding: _padding,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SvgPicture.asset(
              AppImages.assetsSvgShieldCheck,
              width: _iconSize,
              height: _iconSize,
              colorFilter: ColorFilter.mode(colors.info, BlendMode.srcIn),
            ),
            AppSpacing.gapH10,
            Expanded(
              child: Text(
                AppLocaleKey.ownershipReviewNotice.tr(),
                style: AppTextStyles.xxxsRegular.copyWith(color: colors.textMuted, height: 1.45),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
