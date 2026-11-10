import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../../core/locale/app_locale_key.dart';
import '../../../../../core/theme/app_sizes.dart';
import '../../../../../core/theme/app_text_styles.dart';
import '../../../../../core/theme/extensions/theme_extensions.dart';
import 'egp_amount.dart';
import 'package_details_section_card.dart';

class PackagePriceSummaryCard extends StatelessWidget {
  const PackagePriceSummaryCard({super.key, required this.price, required this.durationMonths});

  final double price;
  final int durationMonths;

  static const _padding = EdgeInsetsDirectional.all(AppSpacing.xl20);
  static const _radius = BorderRadius.all(Radius.circular(13));
  static const _priceGap = SizedBox(height: 6);
  static const _durationGap = SizedBox(height: 3);
  static const _textHeight = 1.5;

  @override
  Widget build(BuildContext context) {
    final colors = context.customColors;
    final captionStyle = AppTextStyles.xxxxxsMedium.copyWith(
      fontWeight: FontWeight.w400,
      height: _textHeight,
    );

    return PackageDetailsSectionCard(
      padding: _padding,
      borderRadius: _radius,
      child: Column(
        children: [
          Text(
            AppLocaleKey.packagePrice.tr(),
            style: captionStyle.copyWith(color: colors.textMuted),
          ),
          _priceGap,
          Text(
            formatEgpAmount(price),
            textAlign: TextAlign.center,
            style: AppTextStyles.xlBold.copyWith(color: colors.textPrimary, height: _textHeight),
          ),
          _durationGap,
          Text(
            AppLocaleKey.monthSubscription.tr(args: ['$durationMonths']),
            style: captionStyle.copyWith(color: colors.hint),
          ),
        ],
      ),
    );
  }
}
