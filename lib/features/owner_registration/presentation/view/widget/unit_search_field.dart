import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/custom_widgets/custom_form_field/custom_form_field.dart';
import '../../../../../core/locale/app_locale_key.dart';
import '../../../../../core/theme/app_sizes.dart';
import '../../../../../core/theme/app_text_styles.dart';
import '../../../../../core/theme/extensions/theme_extensions.dart';
import '../../controller/unit_selection_cubit.dart';
import 'unit_filter_label.dart';

class UnitSearchField extends StatelessWidget {
  const UnitSearchField({super.key});

  static const _radius = 9.0;
  static const _borderWidth = 1.0;
  static const _contentPadding = EdgeInsetsDirectional.symmetric(horizontal: 11, vertical: 13.5);

  @override
  Widget build(BuildContext context) {
    final colors = context.customColors;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        UnitFilterLabel(text: AppLocaleKey.unitNumberOrCode.tr()),
        AppSpacing.gapV5,
        CustomFormField(
          hintText: AppLocaleKey.searchByUnitNumberOrCode.tr(),
          keyboardType: TextInputType.text,
          onChanged: context.read<UnitSelectionCubit>().search,
          radius: _radius,
          borderWidth: _borderWidth,
          borderColor: colors.subtleBorder,
          focusColor: colors.oceanAccent,
          fillColor: colors.canvas,
          contentPadding: _contentPadding,
          textStyle: AppTextStyles.xxsRegular.copyWith(color: colors.textSecondary),
          hintStyle: AppTextStyles.xxsRegular.copyWith(color: colors.hint),
        ),
      ],
    );
  }
}
