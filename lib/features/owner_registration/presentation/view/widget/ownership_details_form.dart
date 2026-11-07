import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/custom_widgets/bottom_sheet/option_picker_sheet.dart';
import '../../../../../core/extension/context_ui_extension.dart';
import '../../../../../core/locale/app_locale_key.dart';
import '../../../../../core/theme/extensions/theme_extensions.dart';
import '../../../../../core/utils/date_methods.dart';
import '../../../data/model/ownership_type.dart';
import '../../controller/ownership_details_cubit.dart';
import 'registration_picker_field.dart';
import 'registration_text_field.dart';

class OwnershipDetailsForm extends StatelessWidget {
  const OwnershipDetailsForm({super.key});

  static const _padding = EdgeInsetsDirectional.symmetric(horizontal: 16, vertical: 20);
  static const _radius = BorderRadius.all(Radius.circular(14));

  @override
  Widget build(BuildContext context) {
    final colors = context.customColors;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: _radius,
        border: Border.all(color: colors.subtleBorder),
      ),
      child: Padding(
        padding: _padding,
        child: BlocSelector<OwnershipDetailsCubit, OwnershipDetailsState, String>(
          selector: (state) => state.activeUnit.id,
          builder: (context, unitId) => _UnitOwnershipFields(key: ValueKey(unitId), unitId: unitId),
        ),
      ),
    );
  }
}

class _UnitOwnershipFields extends StatefulWidget {
  const _UnitOwnershipFields({super.key, required this.unitId});

  final String unitId;

  @override
  State<_UnitOwnershipFields> createState() => _UnitOwnershipFieldsState();
}

class _UnitOwnershipFieldsState extends State<_UnitOwnershipFields> {
  late final OwnershipDetailsCubit _cubit = context.read<OwnershipDetailsCubit>();
  late final _documentNumberController = TextEditingController(
    text: _cubit.state.detailsOf(widget.unitId).documentNumber,
  );
  late final _notesController = TextEditingController(
    text: _cubit.state.detailsOf(widget.unitId).notes,
  );

  static final _dateFormat = DateFormat('dd/MM/yyyy');
  static final _firstDate = DateTime(1950);
  static const _fieldGap = SizedBox(height: 18);
  static const _notesMinLines = 4;
  static const _notesMaxLines = 6;

  @override
  void dispose() {
    _documentNumberController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  Future<void> _pickType() async {
    final type = await context.showAppBottomSheet<OwnershipType>(
      OptionPickerSheet<OwnershipType>(
        title: AppLocaleKey.ownershipType.tr(),
        options: OwnershipType.values,
        labelOf: (type) => type.labelKey.tr(),
        selected: _cubit.state.detailsOf(widget.unitId).type,
      ),
    );
    if (type != null) _cubit.setType(widget.unitId, type);
  }

  Future<void> _pickDate(DateTime? current, ValueChanged<DateTime> onPicked) {
    final today = DateUtils.dateOnly(DateTime.now());
    return DateMethods.pickDate(
      context,
      initialDate: current ?? today,
      firstDate: _firstDate,
      lastDate: today,
      onSuccess: onPicked,
    );
  }

  @override
  Widget build(BuildContext context) {
    final unitId = widget.unitId;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        BlocSelector<OwnershipDetailsCubit, OwnershipDetailsState, OwnershipType?>(
          selector: (state) => state.detailsOf(unitId).type,
          builder: (context, type) => RegistrationPickerField(
            title: AppLocaleKey.ownershipType.tr(),
            hintText: AppLocaleKey.selectOwnershipType.tr(),
            value: type?.labelKey.tr(),
            isRequired: true,
            onTap: _pickType,
          ),
        ),
        _fieldGap,
        BlocSelector<OwnershipDetailsCubit, OwnershipDetailsState, DateTime?>(
          selector: (state) => state.detailsOf(unitId).date,
          builder: (context, date) => RegistrationPickerField(
            title: AppLocaleKey.ownershipDate.tr(),
            hintText: AppLocaleKey.dateHint.tr(),
            value: date == null ? null : _dateFormat.format(date),
            showChevron: false,
            onTap: () => _pickDate(date, (picked) => _cubit.setDate(unitId, picked)),
          ),
        ),
        _fieldGap,
        RegistrationTextField(
          controller: _documentNumberController,
          title: AppLocaleKey.ownershipDocumentNumber.tr(),
          hintText: AppLocaleKey.enterDocumentNumber.tr(),
          keyboardType: TextInputType.text,
          onChanged: (value) => _cubit.setDocumentNumber(unitId, value),
        ),
        _fieldGap,
        BlocSelector<OwnershipDetailsCubit, OwnershipDetailsState, DateTime?>(
          selector: (state) => state.detailsOf(unitId).documentDate,
          builder: (context, date) => RegistrationPickerField(
            title: AppLocaleKey.ownershipDocumentDate.tr(),
            hintText: AppLocaleKey.dateHint.tr(),
            value: date == null ? null : _dateFormat.format(date),
            showChevron: false,
            onTap: () => _pickDate(date, (picked) => _cubit.setDocumentDate(unitId, picked)),
          ),
        ),
        _fieldGap,
        RegistrationTextField(
          controller: _notesController,
          title: AppLocaleKey.additionalOwnershipDetails.tr(),
          hintText: AppLocaleKey.addAdditionalDetails.tr(),
          keyboardType: TextInputType.multiline,
          minLines: _notesMinLines,
          maxLines: _notesMaxLines,
          onChanged: (value) => _cubit.setNotes(unitId, value),
        ),
      ],
    );
  }
}
