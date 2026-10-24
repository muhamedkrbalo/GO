import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../theme/app_sizes.dart';
import '../../theme/app_text_styles.dart';
import '../../theme/extensions/theme_extensions.dart';
import 'selection_indicator.dart';

class SelectableOptionCard extends StatelessWidget {
  const SelectableOptionCard({
    super.key,
    required this.icon,
    required this.title,
    required this.description,
    required this.isSelected,
    required this.onTap,
    this.padding = const EdgeInsets.all(17.6),
    this.minHeight = 136,
    this.iconTileSize = 48,
    this.iconSize = 24,
    this.iconTileRadius = const BorderRadius.all(Radius.circular(14.4)),
  });

  final String icon;
  final String title;
  final String description;
  final bool isSelected;
  final VoidCallback onTap;
  final EdgeInsetsGeometry padding;
  final double minHeight;
  final double iconTileSize;
  final double iconSize;
  final BorderRadius iconTileRadius;

  static const _duration = Duration(milliseconds: 180);
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
        decoration: BoxDecoration(
          color: isSelected ? colors.selectedSurface : colors.surface,
          borderRadius: AppRadius.brCard,
          border: Border.all(
            color: isSelected ? colors.primary : colors.subtleBorder,
            width: isSelected ? _selectedBorderWidth : _borderWidth,
          ),
        ),
        child: Material(
          type: MaterialType.transparency,
          child: InkWell(
            onTap: onTap,
            borderRadius: AppRadius.brCard,
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: minHeight),
              child: Padding(
                padding: padding,
                child: Row(
                  children: [
                    DecoratedBox(
                      decoration: BoxDecoration(
                        color: colors.primaryLight,
                        borderRadius: iconTileRadius,
                      ),
                      child: SizedBox.square(
                        dimension: iconTileSize,
                        child: Center(
                          child: SvgPicture.asset(
                            icon,
                            width: iconSize,
                            height: iconSize,
                            colorFilter: ColorFilter.mode(colors.accentText, BlendMode.srcIn),
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
                            title,
                            style: AppTextStyles.sBold.copyWith(
                              color: colors.textSecondary,
                              height: 1.35,
                            ),
                          ),
                          AppSpacing.gapV5,
                          Text(
                            description,
                            style: AppTextStyles.xsRegular.copyWith(
                              color: colors.textMuted,
                              height: 1.48,
                            ),
                          ),
                        ],
                      ),
                    ),
                    AppSpacing.gapH15,
                    SelectionIndicator(isSelected: isSelected, duration: _duration),
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
