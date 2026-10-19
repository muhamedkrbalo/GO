import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hr_erb/core/locale/app_locale_key.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../images/app_images.dart';
import '../../theme/app_sizes.dart';
import '../../theme/app_text_styles.dart';
import '../../theme/extensions/theme_extensions.dart';

class InfoBanner extends StatelessWidget {
  const InfoBanner({super.key});


  static const _padding = EdgeInsets.symmetric(horizontal: 11.2, vertical: 9.6);
  static const _radius = BorderRadius.all(Radius.circular(10.4));
  static const _borderWidth = 1.6;
  static const _iconSize = 14.4;

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
              AppImages.assetsSvgInfo,
              width: _iconSize,
              height: _iconSize,
              colorFilter: ColorFilter.mode(colors.info, BlendMode.srcIn),
            ),
            AppSpacing.gapH8,
            Expanded(
              child: Text(
                AppLocaleKey.prototypeDataNotice.tr(),
                style: AppTextStyles.xxxsRegular.copyWith(color: colors.textMuted, height: 1.4),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
