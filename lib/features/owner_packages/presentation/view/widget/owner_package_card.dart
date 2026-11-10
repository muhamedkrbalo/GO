import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../../core/locale/app_locale_key.dart';
import '../../../../../core/theme/app_sizes.dart';
import '../../../../../core/theme/app_text_styles.dart';
import '../../../../../core/theme/extensions/theme_extensions.dart';
import '../../../../owner_registration/presentation/view/widget/prototype_data_pill.dart';
import '../../../data/model/owner_package.dart';
import 'owner_package_action_button.dart';

class OwnerPackageCard extends StatelessWidget {
  const OwnerPackageCard({
    super.key,
    required this.package,
    required this.isSelected,
    required this.onSelect,
    this.onView,
  });

  final OwnerPackage package;
  final bool isSelected;
  final VoidCallback onSelect;
  final VoidCallback? onView;

  static const _duration = Duration(milliseconds: 180);
  static const _padding = EdgeInsetsDirectional.all(AppSpacing.l15);
  static const _radius = BorderRadius.all(Radius.circular(13));
  static const _borderWidth = 1.6;
  static const _limitsGap = SizedBox(height: 11);
  static const _actionsGap = SizedBox(height: 13);

  @override
  Widget build(BuildContext context) {
    final colors = context.customColors;

    return Semantics(
      container: true,
      selected: isSelected,
      child: AnimatedContainer(
        duration: _duration,
        padding: _padding,
        decoration: BoxDecoration(
          color: isSelected ? colors.selectedSurface : colors.surface,
          borderRadius: _radius,
          border: Border.all(
            color: isSelected ? colors.primary : colors.subtleBorder,
            width: _borderWidth,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _PackageHeader(name: package.name),
            AppSpacing.gapV12,
            _PackagePrice(price: package.price, durationMonths: package.durationMonths),
            AppSpacing.gapV12,
            _PackageFeatures(features: package.features),
            _limitsGap,
            _PackageLimits(
              unitsLimit: package.unitsLimit,
              businessUsersLimit: package.businessUsersLimit,
              isOnSelectedCard: isSelected,
            ),
            _actionsGap,
            Row(
              children: [
                Expanded(
                  child: OwnerPackageActionButton(
                    label: AppLocaleKey.viewPackage.tr(),
                    onPressed: onView,
                  ),
                ),
                AppSpacing.gapH8,
                Expanded(
                  child: OwnerPackageActionButton(
                    label: AppLocaleKey.selectPackage.tr(),
                    isFilled: true,
                    onPressed: onSelect,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _PackageHeader extends StatelessWidget {
  const _PackageHeader({required this.name});

  final String name;

  static const _subtitleGap = SizedBox(height: 4);
  static const _textHeight = 1.5;

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
                name,
                style: AppTextStyles.xsBold.copyWith(
                  color: colors.textPrimary,
                  height: _textHeight,
                ),
              ),
              _subtitleGap,
              Text(
                AppLocaleKey.ownerPackage.tr(),
                style: AppTextStyles.xxxxxsMedium.copyWith(
                  color: colors.textMuted,
                  fontWeight: FontWeight.w400,
                  height: _textHeight,
                ),
              ),
            ],
          ),
        ),
        AppSpacing.gapH8,
        PrototypeDataPill(label: AppLocaleKey.prototypeSampleData.tr()),
      ],
    );
  }
}

class _PackagePrice extends StatelessWidget {
  const _PackagePrice({required this.price, required this.durationMonths});

  final double price;
  final int durationMonths;

  static final _priceFormat = NumberFormat('#,##0.00', 'en');
  static const _textHeight = 1.5;

  @override
  Widget build(BuildContext context) {
    final colors = context.customColors;

    return Text.rich(
      TextSpan(
        text: AppLocaleKey.egpAmount.tr(args: [_priceFormat.format(price)]),
        style: AppTextStyles.mBold.copyWith(color: colors.textSecondary, height: _textHeight),
        children: [
          const TextSpan(text: ' '),
          TextSpan(
            text: AppLocaleKey.perMonths.tr(args: ['$durationMonths']),
            style: AppTextStyles.xxxxxsMedium.copyWith(
              color: colors.hint,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}

class _PackageFeatures extends StatelessWidget {
  const _PackageFeatures({required this.features});

  final List<String> features;

  static const _iconSize = 9.0;
  static const _iconGap = SizedBox(width: 4);
  static const _rowGap = 6.0;
  static const _textHeight = 1.5;

  @override
  Widget build(BuildContext context) {
    final colors = context.customColors;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: _rowGap,
      children: [
        for (final feature in features)
          Row(
            children: [
              Icon(Icons.check_rounded, size: _iconSize, color: colors.linkMuted),
              _iconGap,
              Expanded(
                child: Text(
                  feature,
                  style: AppTextStyles.xxxxxsMedium.copyWith(
                    color: colors.linkMuted,
                    fontWeight: FontWeight.w400,
                    height: _textHeight,
                  ),
                ),
              ),
            ],
          ),
      ],
    );
  }
}

class _PackageLimits extends StatelessWidget {
  const _PackageLimits({
    required this.unitsLimit,
    required this.businessUsersLimit,
    required this.isOnSelectedCard,
  });

  final int unitsLimit;
  final int businessUsersLimit;
  final bool isOnSelectedCard;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: AppSpacing.xs5,
      runSpacing: AppSpacing.xs5,
      children: [
        _LimitChip(
          label: AppLocaleKey.packageUnitsLimit.tr(args: ['$unitsLimit']),
          isOnSelectedCard: isOnSelectedCard,
        ),
        _LimitChip(
          label: AppLocaleKey.packageBusinessUsersLimit.tr(args: ['$businessUsersLimit']),
          isOnSelectedCard: isOnSelectedCard,
        ),
      ],
    );
  }
}

class _LimitChip extends StatelessWidget {
  const _LimitChip({required this.label, required this.isOnSelectedCard});

  final String label;
  final bool isOnSelectedCard;

  static const _padding = EdgeInsetsDirectional.symmetric(horizontal: 6, vertical: 4);
  static const _radius = BorderRadius.all(Radius.circular(6));
  static const _textHeight = 1.5;

  @override
  Widget build(BuildContext context) {
    final colors = context.customColors;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: isOnSelectedCard ? colors.surface : colors.surfaceVariant,
        borderRadius: _radius,
      ),
      child: Padding(
        padding: _padding,
        child: Text(
          label,
          style: AppTextStyles.xxxxxsMedium.copyWith(
            color: colors.textMuted,
            fontWeight: FontWeight.w400,
            height: _textHeight,
          ),
        ),
      ),
    );
  }
}
