import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../theme/app_shadows.dart';
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
    this.padding = const EdgeInsetsDirectional.symmetric(horizontal: 16, vertical: 18),
    this.minHeight = 116,
    this.borderRadius = const BorderRadius.all(Radius.circular(15)),
    this.iconTileSize = 52,
    this.iconSize = 25,
    this.iconTileRadius = const BorderRadius.all(Radius.circular(14)),
    this.gap = 15,
    this.titleToDescriptionGap = 7,
    this.indicatorSize = 22,
  });

  final String icon;
  final String title;
  final String description;
  final bool isSelected;
  final VoidCallback onTap;
  final EdgeInsetsGeometry padding;
  final double minHeight;
  final BorderRadius borderRadius;
  final double iconTileSize;
  final double iconSize;
  final BorderRadius iconTileRadius;
  final double gap;
  final double titleToDescriptionGap;
  final double indicatorSize;

  static const _duration = Duration(milliseconds: 180);
  static const _borderWidth = 1.0;
  static const _selectedBorderWidth = 1.6;
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
          borderRadius: borderRadius,
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
            borderRadius: borderRadius,
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: minHeight),
              child: Padding(
                padding: padding,
                child: Row(
                  children: [
                    DecoratedBox(
                      decoration: BoxDecoration(
                        color: colors.iconTileSurface,
                        borderRadius: iconTileRadius,
                      ),
                      child: SizedBox.square(
                        dimension: iconTileSize,
                        child: Center(
                          child: SvgPicture.asset(
                            icon,
                            width: iconSize,
                            height: iconSize,
                            colorFilter: ColorFilter.mode(colors.oceanAccent, BlendMode.srcIn),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: gap),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            title,
                            style: AppTextStyles.sBold.copyWith(
                              color: colors.textSecondary,
                              height: _textHeight,
                            ),
                          ),
                          SizedBox(height: titleToDescriptionGap),
                          Text(
                            description,
                            style: AppTextStyles.xxsRegular.copyWith(
                              color: colors.textMuted,
                              height: _textHeight,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: gap),
                    SelectionIndicator(
                      isSelected: isSelected,
                      duration: _duration,
                      size: indicatorSize,
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
