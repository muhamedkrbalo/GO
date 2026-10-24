import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../../core/custom_widgets/dotted_decoration/dotted_decoration.dart';
import '../../../../../core/locale/app_locale_key.dart';
import '../../../../../core/theme/app_sizes.dart';
import '../../../../../core/theme/app_text_styles.dart';
import '../../../../../core/theme/extensions/theme_extensions.dart';

class AddAddressButton extends StatelessWidget {
  const AddAddressButton({super.key, required this.onPressed});

  final VoidCallback onPressed;

  static const _height = 52.8;
  static const _iconCircleSize = 20.0;
  static const _iconSize = 15.0;
  static const _borderWidth = 1.6;
  static const _dash = [5, 4];

  @override
  Widget build(BuildContext context) {
    final colors = context.customColors;

    return Material(
      color: colors.selectedSurface,
      borderRadius: AppRadius.brSm,
      child: InkWell(
        onTap: onPressed,
        borderRadius: AppRadius.brSm,
        child: DecoratedBox(
          position: DecorationPosition.foreground,
          decoration: DottedDecoration(
            shape: Shape.box,
            borderRadius: AppRadius.brSm,
            color: colors.hint,
            dash: _dash,
            strokeWidth: _borderWidth,
          ),
          child: SizedBox(
            height: _height,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                DecoratedBox(
                  decoration: BoxDecoration(color: colors.primary, shape: BoxShape.circle),
                  child: SizedBox.square(
                    dimension: _iconCircleSize,
                    child: Icon(Icons.add_rounded, size: _iconSize, color: colors.onPrimary),
                  ),
                ),
                AppSpacing.gapH8,
                Text(
                  AppLocaleKey.addAnotherAddress.tr(),
                  style: AppTextStyles.xsBold.copyWith(color: colors.accentText),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
