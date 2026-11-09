import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../../core/images/app_images.dart';
import '../../../../../core/locale/app_locale_key.dart';
import '../../../../../core/theme/app_text_styles.dart';
import '../../../../../core/theme/extensions/theme_extensions.dart';
import '../../../data/model/broker_activation_checklist.dart';

class BrokerActivationRequirementsCard extends StatelessWidget {
  const BrokerActivationRequirementsCard({super.key, required this.checklist});

  final BrokerActivationChecklist checklist;

  static const _radius = BorderRadius.all(Radius.circular(12));
  static const _borderWidth = 1.5;

  @override
  Widget build(BuildContext context) {
    final colors = context.customColors;
    const requirements = BrokerActivationRequirement.values;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: _radius,
        border: Border.all(color: colors.subtleBorder, width: _borderWidth),
      ),
      child: Column(
        children: [
          for (var index = 0; index < requirements.length; index++)
            _RequirementRow(
              requirement: requirements[index],
              isComplete: checklist.isComplete(requirements[index]),
              hasDivider: index < requirements.length - 1,
            ),
        ],
      ),
    );
  }
}

class _RequirementRow extends StatelessWidget {
  const _RequirementRow({
    required this.requirement,
    required this.isComplete,
    required this.hasDivider,
  });

  final BrokerActivationRequirement requirement;
  final bool isComplete;
  final bool hasDivider;

  static const _minHeight = 48.0;
  static const _padding = EdgeInsetsDirectional.symmetric(horizontal: 12, vertical: 9);
  static const _gap = SizedBox(width: 9);
  static const _dividerWidth = 1.5;
  static const _textHeight = 1.5;

  @override
  Widget build(BuildContext context) {
    final colors = context.customColors;

    return Semantics(
      checked: isComplete,
      child: Container(
        constraints: const BoxConstraints(minHeight: _minHeight),
        padding: _padding,
        decoration: BoxDecoration(
          border: hasDivider
              ? Border(
                  bottom: BorderSide(color: colors.selectedSurface, width: _dividerWidth),
                )
              : null,
        ),
        child: Row(
          children: [
            _RequirementIndicator(isComplete: isComplete),
            _gap,
            Expanded(
              child: Text(
                requirement.labelKey.tr(),
                style: AppTextStyles.xxxxxsMedium.copyWith(
                  color: colors.formLabel,
                  fontWeight: FontWeight.w700,
                  height: _textHeight,
                ),
              ),
            ),
            _gap,
            Text(
              (isComplete ? AppLocaleKey.complete : AppLocaleKey.pending).tr(),
              style: AppTextStyles.xxxxxsMedium.copyWith(
                color: isComplete ? colors.success : colors.goldLink,
                fontWeight: FontWeight.w400,
                height: _textHeight,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _RequirementIndicator extends StatelessWidget {
  const _RequirementIndicator({required this.isComplete});

  final bool isComplete;

  static const _size = 18.0;
  static const _iconSize = 8.0;
  static const _borderWidth = 1.5;

  @override
  Widget build(BuildContext context) {
    final colors = context.customColors;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: isComplete ? colors.progressComplete : colors.surface,
        shape: BoxShape.circle,
        border: isComplete ? null : Border.all(color: colors.border, width: _borderWidth),
      ),
      child: SizedBox.square(
        dimension: _size,
        child: isComplete
            ? Center(
                child: SvgPicture.asset(
                  AppImages.assetsSvgCheck,
                  width: _iconSize,
                  height: _iconSize,
                  colorFilter: ColorFilter.mode(colors.onPrimary, BlendMode.srcIn),
                ),
              )
            : null,
      ),
    );
  }
}
