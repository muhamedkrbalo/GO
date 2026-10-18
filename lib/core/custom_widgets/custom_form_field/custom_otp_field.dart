import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pinput/pinput.dart';

import '../../theme/app_colors.dart';
import '../../theme/app_text_styles.dart';
import '../../theme/extensions/theme_extensions.dart';

class CustomOtpField extends StatelessWidget {
  const CustomOtpField({
    super.key,
    this.length = 6,
    this.controller,
    this.focusNode,
    this.onChanged,
    this.onCompleted,
    this.hasError = false,
    this.enabled = true,
    this.autofocus = true,
  });

  final int length;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onCompleted;
  final bool hasError;
  final bool enabled;
  final bool autofocus;

  static const _gap = 8.8;
  static const _height = 56.0;
  static const _maxBoxWidth = 56.0;
  static const _borderWidth = 1.6;
  static const _radius = BorderRadius.all(Radius.circular(12.8));

  @override
  Widget build(BuildContext context) {
    final colors = context.customColors;

    return SizedBox(
      height: _height,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final boxWidth = ((constraints.maxWidth - _gap * (length - 1)) / length).clamp(
            0.0,
            _maxBoxWidth,
          );

          PinTheme theme(Color fill, Color border) => PinTheme(
            width: boxWidth,
            height: _height,
            textStyle: AppTextStyles.xlBold.copyWith(color: colors.textSecondary),
            decoration: BoxDecoration(
              color: fill,
              borderRadius: _radius,
              border: Border.all(color: border, width: _borderWidth),
            ),
          );

          return Directionality(
            textDirection: ui.TextDirection.ltr,
            child: Pinput(
              length: length,
              controller: controller,
              focusNode: focusNode,
              enabled: enabled,
              autofocus: autofocus,
              forceErrorState: hasError,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              separatorBuilder: (_) => const SizedBox(width: _gap),
              hapticFeedbackType: HapticFeedbackType.lightImpact,
              defaultPinTheme: theme(colors.surface, colors.border),
              focusedPinTheme: theme(colors.surface, AppColors.primary),
              submittedPinTheme: theme(colors.selectedSurface, colors.filledBorder),
              errorPinTheme: theme(colors.errorSurface, colors.error),
              errorBuilder: (_, _) => const SizedBox.shrink(),
              onChanged: onChanged,
              onCompleted: onCompleted,
              onTapOutside: (_) => FocusManager.instance.primaryFocus?.unfocus(),
            ),
          );
        },
      ),
    );
  }
}
