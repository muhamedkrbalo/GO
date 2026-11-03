import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../../core/custom_widgets/selectable_option_card/selection_indicator.dart';
import '../../../../../core/theme/app_shadows.dart';
import '../../../../../core/theme/app_text_styles.dart';
import '../../../../../core/theme/extensions/theme_extensions.dart';
import '../../../data/model/business_role.dart';

class BusinessRoleCard extends StatelessWidget {
  const BusinessRoleCard({
    super.key,
    required this.role,
    required this.isSelected,
    required this.onTap,
  });

  final BusinessRole role;
  final bool isSelected;
  final VoidCallback onTap;

  static const _duration = Duration(milliseconds: 180);
  static const _minHeight = 106.0;
  static const _padding = EdgeInsetsDirectional.all(16);
  static const _radius = BorderRadius.all(Radius.circular(14));
  static const _borderWidth = 1.0;
  static const _selectedBorderWidth = 1.6;
  static const _iconTileSize = 50.0;
  static const _iconTileRadius = BorderRadius.all(Radius.circular(13));
  static const _iconSize = 24.0;
  static const _gap = 14.0;
  static const _titleToDescriptionGap = 6.0;
  static const _indicatorSize = 21.0;
  static const _textHeight = 1.5;

  @override
  Widget build(BuildContext context) {
    final colors = context.customColors;

    return Semantics(
      button: true,
      selected: isSelected,
      inMutuallyExclusiveGroup: true,
      child: AnimatedContainer(
        duration: _duration,
        decoration: BoxDecoration(
          color: isSelected ? colors.selectedSurface : colors.surface,
          borderRadius: _radius,
          border: Border.all(
            color: isSelected ? colors.primary : colors.subtleBorder,
            width: isSelected ? _selectedBorderWidth : _borderWidth,
          ),
          boxShadow: AppShadows.roleCard,
        ),
        child: Material(
          type: MaterialType.transparency,
          child: InkWell(
            onTap: onTap,
            borderRadius: _radius,
            child: ConstrainedBox(
              constraints: const BoxConstraints(minHeight: _minHeight),
              child: Padding(
                padding: _padding,
                child: Row(
                  children: [
                    DecoratedBox(
                      decoration: BoxDecoration(
                        color: colors.iconTileSurface,
                        borderRadius: _iconTileRadius,
                      ),
                      child: SizedBox.square(
                        dimension: _iconTileSize,
                        child: Center(
                          child: SvgPicture.asset(
                            role.icon,
                            width: _iconSize,
                            height: _iconSize,
                            colorFilter: ColorFilter.mode(colors.oceanAccent, BlendMode.srcIn),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: _gap),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            role.titleKey.tr(),
                            style: AppTextStyles.sBold.copyWith(
                              color: colors.textSecondary,
                              height: _textHeight,
                            ),
                          ),
                          const SizedBox(height: _titleToDescriptionGap),
                          Text(
                            role.descriptionKey.tr(),
                            style: AppTextStyles.xxsRegular.copyWith(
                              color: colors.textMuted,
                              height: _textHeight,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: _gap),
                    SelectionIndicator(
                      isSelected: isSelected,
                      duration: _duration,
                      size: _indicatorSize,
                      borderWidth: _borderWidth,
                      idleBorderColor: colors.border,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
