import 'package:flutter/material.dart';

import '../../../../../core/theme/app_text_styles.dart';
import '../../../../../core/theme/extensions/theme_extensions.dart';

class PackageOptionTile extends StatelessWidget {
  const PackageOptionTile({
    super.key,
    required this.label,
    required this.onTap,
    this.isSelectable = false,
    this.isSelected = false,
  });

  final String label;
  final VoidCallback? onTap;
  final bool isSelectable;
  final bool isSelected;

  static const height = 44.0;
  static const _duration = Duration(milliseconds: 180);
  static const _radius = BorderRadius.all(Radius.circular(9));
  static const _borderWidth = 1.6;
  static const _textHeight = 1.5;

  @override
  Widget build(BuildContext context) {
    final colors = context.customColors;

    return Semantics(
      button: true,
      selected: isSelectable ? isSelected : null,
      inMutuallyExclusiveGroup: isSelectable ? true : null,
      child: AnimatedContainer(
        duration: _duration,
        height: height,
        decoration: BoxDecoration(
          color: isSelected ? colors.iconTileSurface : colors.surface,
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
            child: Center(
              child: Text(
                label,
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: AppTextStyles.xxxxxsMedium.copyWith(
                  color: isSelectable && !isSelected ? colors.textMuted : colors.textPrimary,
                  fontWeight: FontWeight.w700,
                  height: _textHeight,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
