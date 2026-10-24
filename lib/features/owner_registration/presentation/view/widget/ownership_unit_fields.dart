import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/custom_widgets/bottom_sheet/option_picker_sheet.dart';
import '../../../../../core/custom_widgets/custom_form_field/custom_picker_field.dart';
import '../../../../../core/extension/context_ui_extension.dart';
import '../../../../../core/images/app_images.dart';
import '../../../../../core/locale/app_locale_key.dart';
import '../../../../../core/theme/app_sizes.dart';
import '../../../../../core/utils/date_methods.dart';
import '../../../data/model/ownership_type.dart';
import '../../controller/ownership_details_cubit.dart';

class OwnershipUnitFields extends StatelessWidget {
  const OwnershipUnitFields({super.key, required this.unitId});

  final String unitId;

  static final _dateFormat = DateFormat('dd/MM/yy');

  Future<void> _pickType(BuildContext context) async {
    final cubit = context.read<OwnershipDetailsCubit>();
    final type = await context.showAppBottomSheet<OwnershipType>(
      OptionPickerSheet<OwnershipType>(
        title: AppLocaleKey.ownershipType.tr(),
        options: OwnershipType.values,
        labelOf: (type) => type.labelKey.tr(),
        selected: cubit.state.detailsOf(unitId).type,
      ),
    );
    if (type != null) cubit.setType(unitId, type);
  }

  Future<void> _pickDate(BuildContext context) {
    final cubit = context.read<OwnershipDetailsCubit>();
    final today = DateUtils.dateOnly(DateTime.now());
    return DateMethods.pickDate(
      context,
      initialDate: cubit.state.detailsOf(unitId).date ?? today,
      firstDate: DateTime(1950),
      lastDate: today,
      onSuccess: (date) => cubit.setDate(unitId, date),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BlocSelector<OwnershipDetailsCubit, OwnershipDetailsState, OwnershipType?>(
          selector: (state) => state.detailsOf(unitId).type,
          builder: (context, type) => CustomPickerField(
            title: AppLocaleKey.ownershipType.tr(),
            hintText: AppLocaleKey.selectOwnershipType.tr(),
            value: type?.labelKey.tr(),
            icon: AppImages.assetsSvgSelectArrow,
            isRequired: true,
            onTap: () => _pickType(context),
          ),
        ),
        AppSpacing.gapV16,
        BlocSelector<OwnershipDetailsCubit, OwnershipDetailsState, DateTime?>(
          selector: (state) => state.detailsOf(unitId).date,
          builder: (context, date) => CustomPickerField(
            title: AppLocaleKey.ownershipDate.tr(),
            hintText: AppLocaleKey.dateHint.tr(),
            value: date == null ? null : _dateFormat.format(date),
            icon: AppImages.assetsSvgCalendar,
            isRequired: true,
            onTap: () => _pickDate(context),
          ),
        ),
      ],
    );
  }
}
