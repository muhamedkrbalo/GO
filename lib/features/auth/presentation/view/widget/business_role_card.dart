import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_sizes.dart';
import '../../../../../core/theme/app_text_styles.dart';
import '../../../../../core/theme/extensions/theme_extensions.dart';
import '../../../data/model/business_role.dart';
import 'selection_indicator.dart';

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
  static const _minHeight = 115.2;
  static const _iconTileSize = 44.8;
  static const _iconSize = 22.4;
  static const _iconTileRadius = BorderRadius.all(Radius.circular(13.6));
  static const _borderWidth = 1.6;
  static const _selectedBorderWidth = 2.6;

  @override
  Widget build(BuildContext context) {
    final colors = context.customColors;

    return Semantics(
      button: true,
      selected: isSelected,
      inMutuallyExclusiveGroup: true,
      child: AnimatedContainer(
        duration: _duration,
        constraints: const BoxConstraints(minHeight: _minHeight),
        decoration: BoxDecoration(
          color: isSelected ? colors.selectedSurface : colors.surface,
          borderRadius: AppRadius.brCard,
          border: Border.all(
            color: isSelected ? AppColors.primary : colors.border,
            width: isSelected ? _selectedBorderWidth : _borderWidth,
          ),
        ),
        child: Material(
          type: MaterialType.transparency,
          child: InkWell(
            onTap: onTap,
            borderRadius: AppRadius.brCard,
            child: ConstrainedBox(
              constraints: const BoxConstraints(minHeight: _minHeight),
              child: Padding(
                padding: AppPadding.v16h16,
                child: Row(
                  children: [
                    DecoratedBox(
                      decoration: BoxDecoration(
                        color: colors.primaryLight,
                        borderRadius: _iconTileRadius,
                      ),
                      child: SizedBox.square(
                        dimension: _iconTileSize,
                        child: Center(
                          child: SvgPicture.asset(
                            role.icon,
                            width: _iconSize,
                            height: _iconSize,
                            colorFilter: ColorFilter.mode(
                              colors.accentText,
                              BlendMode.srcIn,
                            ),
                          ),
                        ),
                      ),
                    ),
                    AppSpacing.gapH15,
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            role.titleKey.tr(),
                            style: AppTextStyles.sBold.copyWith(
                              color: colors.textSecondary,
                              height: 1.35,
                            ),
                          ),
                          AppSpacing.gapV5,
                          Text(
                            role.descriptionKey.tr(),
                            style: AppTextStyles.xsRegular.copyWith(
                              color: colors.textMuted,
                              height: 1.45,
                            ),
                          ),
                        ],
                      ),
                    ),
                    AppSpacing.gapH15,
                    SelectionIndicator(
                      isSelected: isSelected,
                      duration: _duration,
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
