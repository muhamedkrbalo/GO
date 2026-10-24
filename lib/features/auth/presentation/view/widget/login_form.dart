import 'dart:ui' as ui;

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../../core/custom_widgets/buttons/arrow_pill_button.dart';
import '../../../../../core/custom_widgets/custom_form_field/custom_form_field.dart';
import '../../../../../core/locale/app_locale_key.dart';
import '../../../../../core/theme/app_sizes.dart';
import '../../../../../core/theme/app_text_styles.dart';
import '../../../../../core/theme/extensions/theme_extensions.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({super.key});

  static const _inputPadding = EdgeInsets.all(15);
  static const _letterSpacing = 0.4;
  static const _labelHeight = 1.5;
  static const _fieldToButtonGap = 16.0;

  @override
  Widget build(BuildContext context) {
    final colors = context.customColors;
    final labelStyle = AppTextStyles.xxxsBold.copyWith(
      color: colors.formLabel,
      letterSpacing: _letterSpacing,
      height: _labelHeight,
    );
    final inputStyle = AppTextStyles.xs13Bold.copyWith(
      color: colors.textSecondary,
      letterSpacing: _letterSpacing,
    );
    final hintStyle = inputStyle.copyWith(color: colors.hint);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomFormField(
          title: AppLocaleKey.emailAddress.tr().toUpperCase(),
          titleStyle: labelStyle,
          hintText: AppLocaleKey.emailHint.tr(),
          hintStyle: hintStyle,
          textStyle: inputStyle,
          keyboardType: TextInputType.emailAddress,
          textDirection: ui.TextDirection.ltr,
          contentPadding: _inputPadding,
        ),
        AppSpacing.gapV12,
        CustomFormField(
          title: AppLocaleKey.password.tr().toUpperCase(),
          titleStyle: labelStyle,
          hintText: AppLocaleKey.passwordHint.tr(),
          hintStyle: hintStyle,
          textStyle: inputStyle,
          isPassword: true,
          contentPadding: _inputPadding,
        ),
        const SizedBox(height: _fieldToButtonGap),
        ArrowPillButton(text: AppLocaleKey.logIn.tr(), onPressed: () {}),
      ],
    );
  }
}
