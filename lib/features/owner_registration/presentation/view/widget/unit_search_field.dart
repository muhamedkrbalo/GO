import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../../core/custom_widgets/custom_form_field/custom_form_field.dart';
import '../../../../../core/images/app_images.dart';
import '../../../../../core/locale/app_locale_key.dart';
import '../../../../../core/theme/app_text_styles.dart';
import '../../../../../core/theme/extensions/theme_extensions.dart';
import '../../controller/unit_selection_cubit.dart';

class UnitSearchField extends StatelessWidget {
  const UnitSearchField({super.key});

  static const _iconSize = 24.0;
  static const _iconPadding = EdgeInsetsDirectional.only(start: 16, end: 8);

  @override
  Widget build(BuildContext context) {
    final colors = context.customColors;

    return CustomFormField(
      hintText: AppLocaleKey.searchUnitsHint.tr(),
      hintStyle: AppTextStyles.xsRegular.copyWith(color: colors.hint),
      keyboardType: TextInputType.text,
      onChanged: context.read<UnitSelectionCubit>().search,
      prefixIcon: Padding(
        padding: _iconPadding,
        child: SvgPicture.asset(
          AppImages.assetsSvgSearchLarge,
          width: _iconSize,
          height: _iconSize,
          colorFilter: ColorFilter.mode(colors.textMuted, BlendMode.srcIn),
        ),
      ),
    );
  }
}
