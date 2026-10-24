import 'dart:ui' as ui;

import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hr_erb/core/theme/app_sizes.dart';
import 'package:flutter_hr_erb/core/theme/extensions/custom_colors_extension.dart';
import '../../extension/context_extension.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_hr_erb/core/theme/app_text_styles.dart';
import 'package:flutter_hr_erb/core/theme/extensions/theme_extensions.dart';
import 'package:flutter_hr_erb/core/theme/app_colors.dart';

enum FormFieldBorder { underLine, outLine, none }

class CustomFormField extends StatefulWidget {
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final void Function(String)? onChanged;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final bool isPassword;
  final String? hintText;
  final int? maxLines;
  final int? minLines;
  final void Function()? onTap;
  final bool readOnly;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final double radius;
  final Color? fillColor;
  final Color? focusColor;
  final Color? unFocusColor;
  final Color? passwordColor;
  final String? title;
  final bool isRequired;
  final String? otherSideTitle;
  final ui.TextDirection? textDirection;
  final Country? country;
  final List<TextInputFormatter>? inputFormatters;
  final void Function(Country)? onCountrySelect;
  final FormFieldBorder formFieldBorder;
  final TextStyle? titleStyle;
  final TextStyle? textStyle;
  final TextStyle? hintStyle;
  final int? maxLength;
  final double? width;
  final AutovalidateMode? autovalidateMode;
  final EdgeInsetsGeometry? contentPadding;
  final Widget Function(bool isObscured)? passwordToggleBuilder;
  const CustomFormField({
    super.key,
    this.controller,
    this.focusNode,
    this.onChanged,
    this.validator,
    this.keyboardType,
    this.isPassword = false,
    this.hintText,
    this.maxLines = 1,
    this.minLines,
    this.onTap,
    this.readOnly = false,
    this.prefixIcon,
    this.suffixIcon,
    this.radius = 12.0,
    this.fillColor,
    this.focusColor,
    this.unFocusColor,
    this.title,
    this.isRequired = false,
    this.textDirection,
    this.otherSideTitle,
    this.country,
    this.passwordColor,
    this.formFieldBorder = FormFieldBorder.outLine,
    this.inputFormatters,
    this.onCountrySelect,
    this.titleStyle,
    this.textStyle,
    this.hintStyle,
    this.maxLength,
    this.autovalidateMode,
    this.width,
    this.contentPadding,
    this.passwordToggleBuilder,
  });

  @override
  State<CustomFormField> createState() => _CustomFormFieldState();
}

class _CustomFormFieldState extends State<CustomFormField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width ?? MediaQuery.of(context).size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              if (widget.title != null) ...{
                Expanded(
                  child: Text.rich(
                    TextSpan(
                      text: widget.title,
                      children: [
                        if (widget.isRequired)
                          TextSpan(
                            text: ' *',
                            style: TextStyle(color: context.customColors.error),
                          ),
                      ],
                    ),
                    style: widget.titleStyle ?? AppTextStyles.xsSemiBold.copyWith(color: context.customColors.textSecondary),
                  ),
                ),
              },
              if (widget.otherSideTitle != null) ...{
                Text(
                  widget.otherSideTitle!,
                  style: widget.titleStyle ?? AppTextStyles.sMedium.copyWith(color: context.customColors.textPrimary),
                ),
              },
            ],
          ),
          if (widget.title != null || widget.otherSideTitle != null) ...{AppSpacing.gapV8},
          Directionality(
            textDirection: widget.textDirection != null
                ? widget.textDirection!
                : context.isRTL()
                ? ui.TextDirection.rtl
                : ui.TextDirection.ltr,
            child: TextFormField(
              onTapOutside: (event) {
                FocusManager.instance.primaryFocus?.unfocus();
              },
              controller: widget.controller,
              focusNode: widget.focusNode,
              onChanged: widget.onChanged,
              validator: widget.validator,
              onTap: widget.onTap,
              readOnly: widget.readOnly,
              keyboardType: widget.keyboardType,
              obscureText: widget.isPassword ? _obscureText : false,
              style: widget.textStyle ?? AppTextStyles.sSemiBold.copyWith(color: Theme.of(context).customColors.textSecondary),
              autovalidateMode: widget.autovalidateMode ?? AutovalidateMode.onUserInteraction,
              maxLines: widget.maxLines,
              minLines: widget.minLines,
              cursorColor: widget.focusColor ?? AppColors.primary,
              inputFormatters: widget.inputFormatters,
              maxLength: widget.maxLength,
              decoration: InputDecoration(
                hintMaxLines: 2,
                errorMaxLines: 2,
                hintText: widget.hintText,
                hintStyle: widget.hintStyle ?? AppTextStyles.sSemiBold.copyWith(color: context.customColors.hint),
                fillColor:
                    widget.fillColor ??context.customColors.textFormFill,
                    // (widget.formFieldBorder == FormFieldBorder.underLine
                    //     ? context.customColors.textFormFill
                    //     : context.customColors.textFormFill),
                filled: true,
                border: _border(
                  color: widget.unFocusColor ?? context.customColors.textFormBorder,
                ),
                disabledBorder: _border(
                  color: widget.unFocusColor ?? context.customColors.textFormBorder,
                ),
                focusedBorder: _border(
                  color: widget.unFocusColor ?? AppColors.primary,
                ),
                enabledBorder: _border(
                  color: widget.unFocusColor ?? context.customColors.textFormBorder,
                ),
                contentPadding: widget.contentPadding ?? AppPadding.v16h16,
                prefixIcon: widget.country != null && context.locale == const Locale('en')
                    ? Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          widget.prefixIcon ?? const SizedBox(),
                          TextButton(
                            onPressed: null,
                            // onPressed:
                            //     widget.onCountrySelect != null ? _select : null,
                            child: Text(
                              '${widget.country?.flagEmoji} +${widget.country?.phoneCode}',
                              style: widget.textStyle ?? AppTextStyles.sRegular.copyWith(color: context.customColors.textPrimary),
                              textDirection: ui.TextDirection.ltr,
                            ),
                          ),
                        ],
                      )
                    : widget.prefixIcon,
                suffixIcon: widget.country != null && context.locale == const Locale('ar')
                    ? Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          TextButton(
                            onPressed: null,
                            // onPressed:
                            //     widget.onCountrySelect != null ? _select : null,
                            child: Text(
                              '${widget.country?.flagEmoji} +${widget.country?.phoneCode}',
                              style: widget.textStyle ?? AppTextStyles.sRegular.copyWith(color: context.customColors.textPrimary),
                              textDirection: ui.TextDirection.ltr,
                            ),
                          ),
                          widget.suffixIcon ?? const SizedBox(),
                        ],
                      )
                    : widget.isPassword
                    ? InkWell(
                        onTap: () {
                          setState(() {
                            _obscureText = !_obscureText;
                          });
                        },
                        child:
                            widget.passwordToggleBuilder?.call(_obscureText) ??
                            Icon(
                              _obscureText ? Icons.visibility_off_rounded : Icons.visibility_rounded,
                              size: 20,
                              color: widget.passwordColor ?? context.customColors.hint,
                            ),
                      )
                    : widget.suffixIcon,
              ),
            ),
          ),
        ],
      ),
    );
  }

  InputBorder _border({required Color color}) {
    switch (widget.formFieldBorder) {
      case FormFieldBorder.outLine:
        return OutlineInputBorder(
          borderRadius: BorderRadius.circular(widget.radius),
          borderSide: BorderSide(color: color, width: 1.59),
        );
      case FormFieldBorder.underLine:
        return UnderlineInputBorder(
          borderRadius: BorderRadius.circular(0),
          borderSide: BorderSide(color: color, width: 1.59),
        );
      case FormFieldBorder.none:
        return InputBorder.none;
    }
  }

  // void _select() {
  //   CountryCodeMethods.pickCountry(
  //     onSelect: (v) {
  //       widget.onCountrySelect?.call(v);
  //     },
  //     context: context,
  //   );
  // }
}
