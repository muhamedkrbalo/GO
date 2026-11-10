import 'package:flutter/material.dart';

import '../../../../../core/custom_widgets/buttons/custom_button.dart';
import '../../../../../core/theme/app_sizes.dart';
import '../../../../../core/theme/app_text_styles.dart';
import '../../../../../core/theme/extensions/theme_extensions.dart';

class OwnerPackageActionButton extends StatelessWidget {
  const OwnerPackageActionButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.isFilled = false,
  });

  final String label;
  final VoidCallback? onPressed;
  final bool isFilled;

  static const _height = 39.0;
  static const _textHeight = 1.5;

  @override
  Widget build(BuildContext context) {
    final colors = context.customColors;

    return CustomButton(
      text: label,
      height: _height,
      radius: AppRadius.s8,
      color: isFilled ? colors.primary : colors.surface,
      borderColor: colors.primary,
      prefixIcon: null,
      suffixIcon: null,
      style: AppTextStyles.xxxxxsMedium.copyWith(
        color: isFilled ? colors.onPrimary : colors.primary,
        fontWeight: FontWeight.w700,
        height: _textHeight,
      ),
      onPressed: onPressed,
    );
  }
}
