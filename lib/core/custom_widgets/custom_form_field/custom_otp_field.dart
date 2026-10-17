import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter_hr_erb/core/theme/app_sizes.dart';
import 'package:pinput/pinput.dart';
import '../../extension/context_extension.dart';
import 'package:flutter_hr_erb/core/theme/app_text_styles.dart';
import 'package:flutter_hr_erb/core/theme/extensions/theme_extensions.dart';
import 'package:flutter_hr_erb/core/theme/app_colors.dart';

class CustomOtpField extends StatefulWidget {
  final int length;
  final TextEditingController? controller;
  final void Function(String)? onCompleted;
  const CustomOtpField({super.key, this.length = 6, this.controller, this.onCompleted});

  @override
  State<CustomOtpField> createState() => _CustomOtpFieldState();
}

class _CustomOtpFieldState extends State<CustomOtpField> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Directionality(
        textDirection: ui.TextDirection.ltr,
        child: Pinput(
          controller: widget.controller,
          length: widget.length,
          defaultPinTheme: PinTheme(
            height: 48,
            width: 48,
            textStyle: AppTextStyles.xlSemiBold.copyWith(color: context.customColors.textSecondary),
            decoration: BoxDecoration(
              color: context.customColors.textFormFill,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: context.customColors.textFormBorder),
            ),
          ),
          focusedPinTheme: PinTheme(
            height: 56,
            width: 56,
            textStyle: AppTextStyles.xlSemiBold.copyWith(color: context.customColors.textSecondary),
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.primary),
              color: context.customColors.textFormFill,
              borderRadius: AppRadius.brM,
            ),
          ),
          submittedPinTheme: PinTheme(
            height: 56,
            width: 56,
            textStyle: AppTextStyles.xlSemiBold.copyWith(color: context.customColors.textSecondary),
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.primary),
              color: context.customColors.surface,
              borderRadius: AppRadius.brM,
            ),
          ),
          errorPinTheme: PinTheme(
            height: 56,
            width: 56,
            textStyle: AppTextStyles.xlSemiBold.copyWith(color: context.customColors.textSecondary),
            decoration: BoxDecoration(
              color: context.customColors.surfaceVariant,
              border: Border.all(color: Colors.red.shade700),
              borderRadius: AppRadius.brM,
            ),
          ),
          errorBuilder: (errorText, pin) {
            return Align(
              alignment: context.getByLang(
                ar: AlignmentDirectional.centerEnd,
                en: AlignmentDirectional.centerStart,
              ),
              child: Padding(
                padding: AppPadding.all5,
                child: Text(
                  errorText!,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.red.shade700,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            );
          },
          validator: (s) {
            return s!.trim().length == widget.length
                ? null
                : context.apiTr(
                    ar: 'الكود مكون من ${widget.length} ارقام',
                    en: 'The code consists of ${widget.length} digits',
                  );
          },
          pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
          onTapOutside: (event) {
            FocusManager.instance.primaryFocus?.unfocus();
          },
          onCompleted: widget.onCompleted,
        ),
      ),
    );
  }
}
