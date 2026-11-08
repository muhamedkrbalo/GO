import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../../core/locale/app_locale_key.dart';
import '../../../../../core/theme/app_text_styles.dart';
import '../../../../../core/theme/extensions/theme_extensions.dart';

class BrokerSubmitReadiness extends StatelessWidget {
  const BrokerSubmitReadiness({super.key, required this.isReady});

  final bool isReady;

  static const _padding = EdgeInsetsDirectional.all(12);
  static const _radius = BorderRadius.all(Radius.circular(8));
  static const _accentWidth = 3.0;
  static const _gap = SizedBox(height: 6);
  static const _textHeight = 1.5;

  @override
  Widget build(BuildContext context) {
    final colors = context.customColors;
    final foreground = isReady ? colors.success : colors.goldLink;

    return ClipRRect(
      borderRadius: _radius,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: isReady ? colors.successSurface : colors.goldSurface,
          border: BorderDirectional(
            start: BorderSide(
              color: isReady ? colors.successBorder : colors.accentBar,
              width: _accentWidth,
            ),
          ),
        ),
        child: Padding(
          padding: _padding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                isReady ? AppLocaleKey.readyToSubmit.tr() : AppLocaleKey.actionRequired.tr(),
                style: AppTextStyles.xxxsBold.copyWith(color: foreground, height: _textHeight),
              ),
              _gap,
              Text(
                isReady
                    ? AppLocaleKey.allRequiredInfoComplete.tr()
                    : AppLocaleKey.completeRequiredInfoToSubmit.tr(),
                style: AppTextStyles.xxxxxsMedium.copyWith(
                  color: foreground,
                  fontWeight: FontWeight.w400,
                  height: _textHeight,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
