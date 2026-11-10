import 'package:flutter/material.dart';

import '../../../../../core/theme/app_text_styles.dart';
import '../../../../../core/theme/extensions/theme_extensions.dart';

class PaymentMethodTile extends StatelessWidget {
  const PaymentMethodTile({
    super.key,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  final String label;
  final bool isSelected;
  final VoidCallback onTap;

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
      selected: isSelected,
      inMutuallyExclusiveGroup: true,
      child: AnimatedContainer(
        duration: _duration,
        height: height,
        decoration: BoxDecoration(
          color: isSelected ? colors.selectedSurface : colors.surface,
          borderRadius: _radius,
          border: Border.all(
            color: isSelected ? colors.primary : colors.subtleBorder,
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
                  color: isSelected ? colors.textPrimary : colors.textMuted,
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
