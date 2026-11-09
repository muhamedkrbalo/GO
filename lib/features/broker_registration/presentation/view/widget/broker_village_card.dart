import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../../core/images/app_images.dart';
import '../../../../../core/locale/app_locale_key.dart';
import '../../../../../core/theme/app_text_styles.dart';
import '../../../../../core/theme/extensions/theme_extensions.dart';
import '../../../data/model/broker_village.dart';

class BrokerVillageCard extends StatelessWidget {
  const BrokerVillageCard({
    super.key,
    required this.village,
    required this.isSelected,
    required this.onTap,
  });

  final BrokerVillage village;
  final bool isSelected;
  final VoidCallback? onTap;

  static const _duration = Duration(milliseconds: 160);
  static const _padding = EdgeInsetsDirectional.all(12);
  static const _radius = BorderRadius.all(Radius.circular(11));
  static const _borderWidth = 1.5;
  static const _minHeight = 75.0;
  static const _gap = SizedBox(width: 11);
  static const _disabledOpacity = 0.6;

  @override
  Widget build(BuildContext context) {
    final colors = context.customColors;
    final isSelectable = village.status.isSelectable;

    final card = AnimatedContainer(
      duration: _duration,
      constraints: const BoxConstraints(minHeight: _minHeight),
      decoration: BoxDecoration(
        color: isSelected ? colors.selectedSurface : colors.surface,
        borderRadius: _radius,
        border: Border.all(
          color: isSelected ? colors.oceanAccent : colors.subtleBorder,
          width: _borderWidth,
        ),
      ),
      child: Material(
        type: MaterialType.transparency,
        child: InkWell(
          onTap: onTap,
          borderRadius: _radius,
          child: Padding(
            padding: _padding,
            child: Row(
              children: [
                _VillageCheckbox(isSelected: isSelected, duration: _duration),
                _gap,
                Expanded(child: _VillageDetails(village: village)),
                _gap,
                Text(
                  village.status.labelKey.tr(),
                  style: AppTextStyles.xxxxxsMedium.copyWith(
                    color: colors.oceanAccent,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );

    return Semantics(
      checked: isSelected,
      enabled: onTap != null,
      child: isSelectable ? card : Opacity(opacity: _disabledOpacity, child: card),
    );
  }
}

class _VillageDetails extends StatelessWidget {
  const _VillageDetails({required this.village});

  final BrokerVillage village;

  static const _nameHeight = 1.5;
  static const _locationHeight = 1.5;
  static const _nameToLocationGap = SizedBox(height: 4);

  @override
  Widget build(BuildContext context) {
    final colors = context.customColors;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          village.name,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: AppTextStyles.xxxsBold.copyWith(color: colors.textSecondary, height: _nameHeight),
        ),
        _nameToLocationGap,
        Text(
          AppLocaleKey.villageLocation.tr(args: [village.area, village.governorate]),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: AppTextStyles.xxxxxsMedium.copyWith(
            color: colors.textMuted,
            fontWeight: FontWeight.w400,
            height: _locationHeight,
          ),
        ),
      ],
    );
  }
}

class _VillageCheckbox extends StatelessWidget {
  const _VillageCheckbox({required this.isSelected, required this.duration});

  final bool isSelected;
  final Duration duration;

  static const _size = 21.0;
  static const _iconSize = 11.0;
  static const _borderWidth = 1.5;
  static const _radius = BorderRadius.all(Radius.circular(6));

  @override
  Widget build(BuildContext context) {
    final colors = context.customColors;

    return AnimatedContainer(
      duration: duration,
      width: _size,
      height: _size,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: isSelected ? colors.oceanAccent : colors.surface,
        borderRadius: _radius,
        border: Border.all(
          color: isSelected ? colors.oceanAccent : colors.border,
          width: _borderWidth,
        ),
      ),
      child: AnimatedScale(
        scale: isSelected ? 1 : 0,
        duration: duration,
        child: SvgPicture.asset(
          AppImages.assetsSvgCheck,
          width: _iconSize,
          height: _iconSize,
          colorFilter: ColorFilter.mode(colors.onPrimary, BlendMode.srcIn),
        ),
      ),
    );
  }
}
