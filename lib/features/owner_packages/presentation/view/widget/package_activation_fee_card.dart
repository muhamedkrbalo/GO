import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../../core/locale/app_locale_key.dart';
import '../../../../../core/theme/app_sizes.dart';
import '../../../../../core/theme/app_text_styles.dart';
import '../../../../../core/theme/extensions/theme_extensions.dart';
import 'egp_amount.dart';
import 'package_details_section_card.dart';

class PackageActivationFeeCard extends StatelessWidget {
  const PackageActivationFeeCard({super.key, required this.fee});

  final double fee;

  static const _noteGap = SizedBox(height: 16);
  static const _textHeight = 1.5;

  @override
  Widget build(BuildContext context) {
    final colors = context.customColors;
    final mutedStyle = AppTextStyles.xxxxxsMedium.copyWith(
      color: colors.textMuted,
      fontWeight: FontWeight.w400,
      height: _textHeight,
    );

    return PackageDetailsSectionCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(child: Text(AppLocaleKey.oneTimeActivationFee.tr(), style: mutedStyle)),
              AppSpacing.gapH8,
              Text(
                formatEgpAmount(fee),
                style: AppTextStyles.xxxxxsMedium.copyWith(
                  color: colors.textPrimary,
                  fontWeight: FontWeight.w700,
                  height: _textHeight,
                ),
              ),
            ],
          ),
          _noteGap,
          Text(AppLocaleKey.activationFeeNote.tr(), style: mutedStyle),
        ],
      ),
    );
  }
}
