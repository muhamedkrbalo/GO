import 'dart:ui' as ui;

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_sizes.dart';
import '../../../../../core/theme/app_text_styles.dart';
import '../../../../../core/theme/extensions/theme_extensions.dart';
import '../../../data/model/verification_method.dart';

class VerificationMethodCard extends StatelessWidget {
  const VerificationMethodCard({
    super.key,
    required this.method,
    required this.destination,
    required this.isSelected,
    required this.onTap,
  });

  final VerificationMethod method;
  final String destination;
  final bool isSelected;
  final VoidCallback onTap;

  static const _duration = Duration(milliseconds: 180);
  static const _padding = EdgeInsets.all(18.4);
  static const _iconTileSize = 44.8;
  static const _iconSize = 21.6;
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
            child: Padding(
              padding: _padding,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
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
                          method.icon,
                          width: _iconSize,
                          height: _iconSize,
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
                          method.titleKey.tr(),
                          style: AppTextStyles.sBold.copyWith(
                            color: colors.textSecondary,
                            height: 1.35,
                          ),
                        ),
                        AppSpacing.gapV5,
                        Text(
                          method.descriptionKey.tr(),
                          style: AppTextStyles.xsRegular.copyWith(
                            color: colors.textMuted,
                            height: 1.45,
                          ),
                        ),
                        AppSpacing.gapV10,
                        Text(
                          destination,
                          textDirection: ui.TextDirection.ltr,
                          style: AppTextStyles.xsBold.copyWith(
                            color: colors.accentText,
                            letterSpacing: 0.3,
                          ),
                        ),
                      ],
                    ),
                  ),
                  AppSpacing.gapH15,
                  _SelectionIndicator(isSelected: isSelected, duration: _duration),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _SelectionIndicator extends StatelessWidget {
  const _SelectionIndicator({required this.isSelected, required this.duration});

  final bool isSelected;
  final Duration duration;

  static const _size = 20.0;
  static const _dotSize = 9.3;
  static const _borderWidth = 1.6;

  @override
  Widget build(BuildContext context) {
    final colors = context.customColors;

    return AnimatedContainer(
      duration: duration,
      width: _size,
      height: _size,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: colors.surface,
        shape: BoxShape.circle,
        border: Border.all(
          color: isSelected ? AppColors.primary : colors.hint,
          width: _borderWidth,
        ),
      ),
      child: AnimatedScale(
        scale: isSelected ? 1 : 0,
        duration: duration,
        child: const DecoratedBox(
          decoration: BoxDecoration(color: AppColors.primary, shape: BoxShape.circle),
          child: SizedBox.square(dimension: _dotSize),
        ),
      ),
    );
  }
}
