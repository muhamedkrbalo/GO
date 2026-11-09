import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../../core/locale/app_locale_key.dart';
import '../../../../../core/theme/app_sizes.dart';
import '../../../../../core/theme/app_text_styles.dart';
import '../../../../../core/theme/extensions/theme_extensions.dart';

class BrokerActivationStatusBanner extends StatelessWidget {
  const BrokerActivationStatusBanner({super.key, required this.isActive});

  final bool isActive;

  static const _padding = EdgeInsetsDirectional.all(16);
  static const _accentWidth = 1.5;
  static const _messageGap = SizedBox(height: 5);
  static const _titleHeight = 1.5;
  static const _messageHeight = 1.4;

  @override
  Widget build(BuildContext context) {
    final colors = context.customColors;
    final (surface, accent, foreground) = isActive
        ? (colors.successSurface, colors.progressComplete, colors.success)
        : (colors.goldSurface, colors.accentBar, colors.goldLink);

    return ClipRRect(
      borderRadius: AppRadius.brM,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: surface,
          border: BorderDirectional(
            start: BorderSide(color: accent, width: _accentWidth),
          ),
        ),
        child: Padding(
          padding: _padding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                (isActive ? AppLocaleKey.active : AppLocaleKey.inactive).tr(),
                style: AppTextStyles.xs13Bold.copyWith(color: foreground, height: _titleHeight),
              ),
              _messageGap,
              Text(
                (isActive
                        ? AppLocaleKey.allActivationRequirementsComplete
                        : AppLocaleKey.activationRequirementsPending)
                    .tr(),
                style: AppTextStyles.xxxxxsMedium.copyWith(
                  color: foreground,
                  fontWeight: FontWeight.w400,
                  height: _messageHeight,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
