import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../../core/locale/app_locale_key.dart';
import '../../../../../core/theme/app_sizes.dart';
import '../../../../../core/theme/app_text_styles.dart';
import '../../../../../core/theme/extensions/theme_extensions.dart';
import 'package_details_section_card.dart';

class PackageResourceLimitsCard extends StatelessWidget {
  const PackageResourceLimitsCard({
    super.key,
    required this.unitsLimit,
    required this.businessUsersLimit,
  });

  final int unitsLimit;
  final int businessUsersLimit;

  @override
  Widget build(BuildContext context) {
    return PackageDetailsSectionCard(
      title: AppLocaleKey.resourceLimits.tr(),
      titleGap: 0,
      child: Column(
        children: [
          _LimitRow(label: AppLocaleKey.units.tr(), value: unitsLimit, showDivider: true),
          _LimitRow(label: AppLocaleKey.businessUsers.tr(), value: businessUsersLimit),
        ],
      ),
    );
  }
}

class _LimitRow extends StatelessWidget {
  const _LimitRow({required this.label, required this.value, this.showDivider = false});

  final String label;
  final int value;
  final bool showDivider;

  static const _padding = EdgeInsetsDirectional.symmetric(vertical: 9);
  static const _dividerWidth = 1.6;
  static const _textHeight = 1.5;

  @override
  Widget build(BuildContext context) {
    final colors = context.customColors;

    return DecoratedBox(
      decoration: BoxDecoration(
        border: showDivider
            ? Border(
                bottom: BorderSide(color: colors.surfaceVariant, width: _dividerWidth),
              )
            : null,
      ),
      child: Padding(
        padding: _padding,
        child: Row(
          children: [
            Expanded(
              child: Text(
                label,
                style: AppTextStyles.xxxxxsMedium.copyWith(
                  color: colors.textMuted,
                  fontWeight: FontWeight.w400,
                  height: _textHeight,
                ),
              ),
            ),
            AppSpacing.gapH8,
            Text(
              '$value',
              style: AppTextStyles.xxxxxsMedium.copyWith(
                color: colors.textPrimary,
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
