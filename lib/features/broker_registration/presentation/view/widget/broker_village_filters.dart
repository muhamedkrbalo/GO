import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/custom_widgets/custom_form_field/custom_form_field.dart';
import '../../../../../core/locale/app_locale_key.dart';
import '../../../../../core/theme/app_text_styles.dart';
import '../../../../../core/theme/extensions/theme_extensions.dart';
import '../../controller/broker_village_selection_cubit.dart';
import 'broker_village_area_dropdown.dart';

class BrokerVillageFilters extends StatelessWidget {
  const BrokerVillageFilters({super.key});

  static const _searchFlex = 5;
  static const _areaFlex = 3;
  static const _gap = SizedBox(width: 9);
  static const _radius = 9.0;
  static const _borderWidth = 1.5;
  static const _contentPadding = EdgeInsetsDirectional.symmetric(horizontal: 11, vertical: 14);

  @override
  Widget build(BuildContext context) {
    final colors = context.customColors;

    return Row(
      children: [
        Expanded(
          flex: _searchFlex,
          child: CustomFormField(
            hintText: AppLocaleKey.searchVillages.tr(),
            keyboardType: TextInputType.text,
            onChanged: context.read<BrokerVillageSelectionCubit>().search,
            radius: _radius,
            borderWidth: _borderWidth,
            borderColor: colors.subtleBorder,
            focusColor: colors.oceanAccent,
            fillColor: colors.surface,
            contentPadding: _contentPadding,
            textStyle: AppTextStyles.xxxsRegular.copyWith(color: colors.textSecondary),
            hintStyle: AppTextStyles.xxxsRegular.copyWith(color: colors.hint),
          ),
        ),
        _gap,
        const Expanded(flex: _areaFlex, child: BrokerVillageAreaDropdown()),
      ],
    );
  }
}
