import 'dart:ui' as ui;

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../../core/theme/app_shadows.dart';
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
  static const _minHeight = 88.0;
  static const _padding = EdgeInsets.all(16);
  static const _radius = BorderRadius.all(Radius.circular(14));
  static const _borderWidth = 1.6;
  static const _iconTileSize = 48.0;
  static const _iconSize = 23.0;
  static const _iconTileRadius = BorderRadius.all(Radius.circular(12));
  static const _gap = 14.0;
  static const _titleHeight = 1.5;
  static const _destinationLetterSpacing = 0.24;
  static const _destinationHeight = 1.5;

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
          color: colors.surface,
          borderRadius: _radius,
          border: Border.all(
            color: isSelected ? colors.accentBar : colors.border,
            width: _borderWidth,
          ),
          boxShadow: isSelected ? AppShadows.optionCardSelected : AppShadows.optionCard,
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
                  AnimatedContainer(
                    duration: _duration,
                    width: _iconTileSize,
                    height: _iconTileSize,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: isSelected ? colors.primary : colors.surfaceVariant,
                      borderRadius: _iconTileRadius,
                    ),
                    child: SvgPicture.asset(
                      method.icon,
                      width: _iconSize,
                      height: _iconSize,
                      colorFilter: ColorFilter.mode(
                        isSelected ? colors.onPrimary : colors.accentText,
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
                  const SizedBox(width: _gap),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          method.titleKey.tr(),
                          style: AppTextStyles.sBold.copyWith(
                            color: colors.textSecondary,
                            height: _titleHeight,
                          ),
                        ),
                        AppSpacing.gapV5,
                        Text(
                          destination,
                          textDirection: ui.TextDirection.ltr,
                          style: AppTextStyles.xsMedium.copyWith(
                            color: colors.textMuted,
                            letterSpacing: _destinationLetterSpacing,
                            height: _destinationHeight,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: _gap),
                  _RadioDot(isSelected: isSelected, duration: _duration),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _RadioDot extends StatelessWidget {
  const _RadioDot({required this.isSelected, required this.duration});

  final bool isSelected;
  final Duration duration;

  static const _size = 20.0;
  static const _dotSize = 10.0;
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
        shape: BoxShape.circle,
        border: Border.all(
          color: isSelected ? colors.accentBar : colors.primaryBorder,
          width: _borderWidth,
        ),
      ),
      child: AnimatedScale(
        duration: duration,
        scale: isSelected ? 1 : 0,
        child: Container(
          width: _dotSize,
          height: _dotSize,
          decoration: BoxDecoration(color: colors.accentBar, shape: BoxShape.circle),
        ),
      ),
    );
  }
}
