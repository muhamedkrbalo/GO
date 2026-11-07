import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../../core/locale/app_locale_key.dart';
import '../../../../../core/theme/app_text_styles.dart';
import '../../../../../core/theme/extensions/theme_extensions.dart';

class OwnershipVerificationStatus extends StatelessWidget {
  const OwnershipVerificationStatus({super.key});

  static const _padding = EdgeInsetsDirectional.symmetric(horizontal: 11, vertical: 10);
  static const _radius = BorderRadius.all(Radius.circular(9));
  static const _ringSize = 8.0;
  static const _ringWidth = 2.0;
  static const _ringGap = SizedBox(width: 9);
  static const _lineGap = SizedBox(height: 2);
  static const _textHeight = 1.5;

  @override
  Widget build(BuildContext context) {
    final colors = context.customColors;

    return DecoratedBox(
      decoration: BoxDecoration(color: colors.goldSurface, borderRadius: _radius),
      child: Padding(
        padding: _padding,
        child: Row(
          children: [
            DecoratedBox(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: colors.accentBar, width: _ringWidth),
              ),
              child: const SizedBox.square(dimension: _ringSize),
            ),
            _ringGap,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppLocaleKey.ownershipVerificationStatus.tr(),
                    style: AppTextStyles.xxxxxsMedium.copyWith(
                      color: colors.stepLabel,
                      fontWeight: FontWeight.w400,
                      height: _textHeight,
                    ),
                  ),
                  _lineGap,
                  Text(
                    AppLocaleKey.notSubmitted.tr(),
                    style: AppTextStyles.xxxxsBold.copyWith(
                      color: colors.goldLink,
                      height: _textHeight,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
