import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../../core/locale/app_locale_key.dart';
import '../../../../../core/theme/app_shadows.dart';
import '../../../../../core/theme/app_sizes.dart';
import '../../../../../core/theme/app_text_styles.dart';
import '../../../../../core/theme/extensions/theme_extensions.dart';
import '../../../data/model/owner_unit.dart';
import 'ownership_verification_status.dart';

class SelectedUnitReviewCard extends StatelessWidget {
  const SelectedUnitReviewCard({
    super.key,
    required this.unit,
    required this.onRemove,
    this.onViewDetails,
  });

  final OwnerUnit unit;
  final VoidCallback onRemove;
  final VoidCallback? onViewDetails;

  static const _radius = BorderRadius.all(Radius.circular(14));
  static const _headerPadding = EdgeInsetsDirectional.fromSTEB(15, 15, 15, 12);
  static const _bodyPadding = EdgeInsetsDirectional.symmetric(horizontal: 15);
  static const _actionsGap = SizedBox(height: 12);

  @override
  Widget build(BuildContext context) {
    final colors = context.customColors;

    return DecoratedBox(
      decoration: const BoxDecoration(borderRadius: _radius, boxShadow: AppShadows.roleCard),
      child: Material(
        color: colors.surface,
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: _radius,
          side: BorderSide(color: colors.subtleBorder),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: _headerPadding,
              child: _UnitHeader(unit: unit),
            ),
            Padding(
              padding: _bodyPadding,
              child: _UnitLocationDetails(building: unit.building, village: unit.village),
            ),
            const Padding(padding: _bodyPadding, child: OwnershipVerificationStatus()),
            _actionsGap,
            DecoratedBox(
              decoration: BoxDecoration(
                border: Border(top: BorderSide(color: colors.subtleBorder)),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: _CardAction(
                      label: AppLocaleKey.viewDetails.tr(),
                      color: colors.oceanAccent,
                      onTap: onViewDetails,
                      hasDivider: true,
                    ),
                  ),
                  Expanded(
                    child: _CardAction(
                      label: AppLocaleKey.remove.tr(),
                      color: colors.error,
                      onTap: onRemove,
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

class _UnitHeader extends StatelessWidget {
  const _UnitHeader({required this.unit});

  final OwnerUnit unit;

  static const _lineGap = SizedBox(height: 3);
  static const _badgePadding = EdgeInsetsDirectional.symmetric(horizontal: 8, vertical: 5);
  static const _textHeight = 1.5;
  static const _typeLetterSpacing = 0.48;

  @override
  Widget build(BuildContext context) {
    final colors = context.customColors;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                unit.name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: AppTextStyles.xs13Bold.copyWith(
                  color: colors.textSecondary,
                  height: _textHeight,
                ),
              ),
              _lineGap,
              Text(
                unit.type.labelKey.tr().toUpperCase(),
                style: AppTextStyles.xxxxxsMedium.copyWith(
                  color: colors.oceanAccent,
                  fontWeight: FontWeight.w700,
                  letterSpacing: _typeLetterSpacing,
                  height: _textHeight,
                ),
              ),
            ],
          ),
        ),
        AppSpacing.gapH8,
        DecoratedBox(
          decoration: BoxDecoration(color: colors.successSurface, borderRadius: AppRadius.brCircle),
          child: Padding(
            padding: _badgePadding,
            child: Text(
              AppLocaleKey.selected.tr(),
              style: AppTextStyles.xxxxxsMedium.copyWith(
                color: colors.success,
                fontWeight: FontWeight.w700,
                height: _textHeight,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _UnitLocationDetails extends StatelessWidget {
  const _UnitLocationDetails({required this.building, required this.village});

  final String? building;
  final String village;

  static const _padding = EdgeInsetsDirectional.symmetric(vertical: 12);
  static const _columnGap = 14.0;

  @override
  Widget build(BuildContext context) {
    final colors = context.customColors;
    final building = this.building;

    return DecoratedBox(
      decoration: BoxDecoration(
        border: Border(top: BorderSide(color: colors.subtleBorder)),
      ),
      child: Padding(
        padding: _padding,
        child: Row(
          children: [
            if (building != null)
              Expanded(
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    border: BorderDirectional(end: BorderSide(color: colors.subtleBorder)),
                  ),
                  child: Padding(
                    padding: const EdgeInsetsDirectional.only(end: _columnGap),
                    child: _DetailField(label: AppLocaleKey.building.tr(), value: building),
                  ),
                ),
              ),
            Expanded(
              child: Padding(
                padding: EdgeInsetsDirectional.only(start: building != null ? _columnGap : 0),
                child: _DetailField(label: AppLocaleKey.village.tr(), value: village),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DetailField extends StatelessWidget {
  const _DetailField({required this.label, required this.value});

  final String label;
  final String value;

  static const _gap = SizedBox(height: 3);
  static const _textHeight = 1.5;

  @override
  Widget build(BuildContext context) {
    final colors = context.customColors;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: AppTextStyles.xxxxxsMedium.copyWith(
            color: colors.hint,
            fontWeight: FontWeight.w600,
            height: _textHeight,
          ),
        ),
        _gap,
        Text(
          value,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: AppTextStyles.xxxsSemiBold.copyWith(color: colors.formLabel, height: _textHeight),
        ),
      ],
    );
  }
}

class _CardAction extends StatelessWidget {
  const _CardAction({
    required this.label,
    required this.color,
    required this.onTap,
    this.hasDivider = false,
  });

  final String label;
  final Color color;
  final VoidCallback? onTap;
  final bool hasDivider;

  static const _minHeight = 44.0;
  static const _textHeight = 1.5;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        border: hasDivider
            ? BorderDirectional(end: BorderSide(color: context.customColors.subtleBorder))
            : null,
      ),
      child: Semantics(
        button: true,
        child: InkWell(
          onTap: onTap,
          child: ConstrainedBox(
            constraints: const BoxConstraints(minHeight: _minHeight),
            child: Center(
              child: Text(
                label,
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: AppTextStyles.xxxxsBold.copyWith(color: color, height: _textHeight),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
