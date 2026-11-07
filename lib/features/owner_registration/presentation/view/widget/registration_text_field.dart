import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../../core/custom_widgets/custom_form_field/custom_form_field.dart';
import '../../../../../core/theme/app_text_styles.dart';
import '../../../../../core/theme/extensions/theme_extensions.dart';

class RegistrationTextField extends StatelessWidget {
  const RegistrationTextField({
    super.key,
    required this.title,
    required this.hintText,
    this.controller,
    this.isRequired = false,
    this.keyboardType,
    this.inputFormatters,
    this.validator,
    this.onChanged,
    this.helperText,
    this.prefixIcon,
    this.suffixIcon,
    this.readOnly = false,
    this.onTap,
    this.textDirection,
    this.enabled = true,
    this.minLines,
    this.maxLines = 1,
  });

  final String title;
  final String hintText;
  final TextEditingController? controller;
  final bool isRequired;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final String? Function(String?)? validator;
  final ValueChanged<String>? onChanged;
  final String? helperText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool readOnly;
  final VoidCallback? onTap;
  final ui.TextDirection? textDirection;
  final bool enabled;
  final int? minLines;
  final int? maxLines;

  static const _borderWidth = 1.0;
  static const _titleGap = 7.0;
  static const _helperGap = 7.0;
  static const _contentPadding = EdgeInsetsDirectional.symmetric(horizontal: 15, vertical: 15);
  static const _titleHeight = 1.5;
  static const _helperHeight = 1.4;

  @override
  Widget build(BuildContext context) {
    final colors = context.customColors;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomFormField(
          controller: controller,
          title: title,
          hintText: hintText,
          isRequired: isRequired,
          keyboardType: keyboardType,
          inputFormatters: inputFormatters,
          validator: validator,
          onChanged: onChanged,
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon,
          readOnly: readOnly,
          onTap: onTap,
          textDirection: textDirection,
          enabled: enabled,
          minLines: minLines,
          maxLines: maxLines,
          fillColor: enabled ? null : colors.selectedSurface,
          borderWidth: _borderWidth,
          borderColor: colors.subtleBorder,
          titleGap: _titleGap,
          contentPadding: _contentPadding,
          titleStyle: AppTextStyles.xs12SemiBold.copyWith(
            color: colors.textSecondary,
            height: _titleHeight,
          ),
          textStyle: AppTextStyles.sRegular.copyWith(color: colors.textSecondary),
          hintStyle: AppTextStyles.sRegular.copyWith(color: colors.hint),
        ),
        if (helperText != null) ...[
          const SizedBox(height: _helperGap),
          Text(
            helperText!,
            style: AppTextStyles.xxxxsRegular.copyWith(color: colors.hint, height: _helperHeight),
          ),
        ],
      ],
    );
  }
}
