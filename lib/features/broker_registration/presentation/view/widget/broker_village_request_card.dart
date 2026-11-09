import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../../core/locale/app_locale_key.dart';
import '../../../../../core/theme/app_text_styles.dart';
import '../../../../../core/theme/extensions/theme_extensions.dart';
import '../../../data/model/broker_village.dart';

class BrokerVillageRequestCard extends StatelessWidget {
  const BrokerVillageRequestCard({super.key, required this.village});

  final BrokerVillage village;

  static const _padding = EdgeInsetsDirectional.all(12);
  static const _radius = BorderRadius.all(Radius.circular(9));
  static const _borderWidth = 1.5;
  static const _gap = SizedBox(width: 12);
  static const _nameToAreaGap = SizedBox(height: 3);
  static const _textHeight = 1.5;

  @override
  Widget build(BuildContext context) {
    final colors = context.customColors;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: _radius,
        border: Border.all(color: colors.subtleBorder, width: _borderWidth),
      ),
      child: Padding(
        padding: _padding,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    village.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyles.xxxxsBold.copyWith(
                      color: colors.textSecondary,
                      height: _textHeight,
                    ),
                  ),
                  _nameToAreaGap,
                  Text(
                    village.area,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyles.xxxxxsMedium.copyWith(
                      color: colors.textMuted,
                      fontWeight: FontWeight.w400,
                      height: _textHeight,
                    ),
                  ),
                ],
              ),
            ),
            _gap,
            Text(
              AppLocaleKey.pendingProcessing.tr(),
              style: AppTextStyles.xxxxxsMedium.copyWith(
                color: colors.goldLink,
                fontWeight: FontWeight.w700,
                height: _textHeight,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
