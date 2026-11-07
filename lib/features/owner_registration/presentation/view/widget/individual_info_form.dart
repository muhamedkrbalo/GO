import 'package:country_picker/country_picker.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/custom_widgets/bottom_sheet/option_picker_sheet.dart';
import '../../../../../core/custom_widgets/validation/validation_mixin.dart';
import '../../../../../core/extension/context_ui_extension.dart';
import '../../../../../core/locale/app_locale_key.dart';
import '../../../../../core/utils/country_code_methods.dart';
import '../../../data/model/id_type.dart';
import '../../controller/individual_info_cubit.dart';
import 'registration_phone_field.dart';
import 'registration_picker_field.dart';
import 'registration_text_field.dart';

class IndividualInfoForm extends StatefulWidget {
  const IndividualInfoForm({super.key});

  @override
  State<IndividualInfoForm> createState() => _IndividualInfoFormState();
}

class _IndividualInfoFormState extends State<IndividualInfoForm> with ValidationMixin {
  final _nameController = TextEditingController();
  final _idNumberController = TextEditingController();
  final _mobileController = TextEditingController();
  final _emailController = TextEditingController();

  static const _fieldGap = SizedBox(height: 18);

  @override
  void dispose() {
    _nameController.dispose();
    _idNumberController.dispose();
    _mobileController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  Future<void> _pickIdType() async {
    final cubit = context.read<IndividualInfoCubit>();
    final idType = await context.showAppBottomSheet<IdType>(
      OptionPickerSheet<IdType>(
        title: AppLocaleKey.idType.tr(),
        options: IdType.values,
        labelOf: (type) => type.labelKey.tr(),
        selected: cubit.state.idType,
      ),
    );
    if (idType != null) cubit.selectIdType(idType);
  }

  void _pickNationality() {
    CountryCodeMethods.pickCountry(
      context: context,
      showPhoneCode: false,
      onSelect: context.read<IndividualInfoCubit>().selectNationality,
    );
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<IndividualInfoCubit>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        RegistrationTextField(
          controller: _nameController,
          title: AppLocaleKey.fullLegalName.tr(),
          hintText: AppLocaleKey.enterFullLegalName.tr(),
          isRequired: true,
          keyboardType: TextInputType.name,
          onChanged: cubit.fullNameChanged,
          validator: validateName,
        ),
        _fieldGap,
        BlocSelector<IndividualInfoCubit, IndividualInfoState, IdType?>(
          selector: (state) => state.idType,
          builder: (context, idType) => RegistrationPickerField(
            title: AppLocaleKey.idType.tr(),
            hintText: AppLocaleKey.selectIdType.tr(),
            value: idType?.labelKey.tr(),
            isRequired: true,
            onTap: _pickIdType,
            validator: validateEmptyField,
          ),
        ),
        _fieldGap,
        RegistrationTextField(
          controller: _idNumberController,
          title: AppLocaleKey.idNumber.tr(),
          hintText: AppLocaleKey.enterIdNumber.tr(),
          isRequired: true,
          keyboardType: TextInputType.number,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          onChanged: cubit.idNumberChanged,
          validator: validateEmptyField,
        ),
        _fieldGap,
        BlocSelector<IndividualInfoCubit, IndividualInfoState, Country?>(
          selector: (state) => state.nationality,
          builder: (context, nationality) => RegistrationPickerField(
            title: AppLocaleKey.nationality.tr(),
            hintText: AppLocaleKey.selectNationality.tr(),
            value: nationality?.getTranslatedName(context) ?? nationality?.name,
            showChevron: false,
            onTap: _pickNationality,
          ),
        ),
        _fieldGap,
        BlocSelector<IndividualInfoCubit, IndividualInfoState, Country>(
          selector: (state) => state.phoneCountry,
          builder: (context, country) => RegistrationPhoneField(
            controller: _mobileController,
            title: AppLocaleKey.mobileNumber.tr(),
            hintText: AppLocaleKey.enterMobileNumber.tr(),
            helperText: AppLocaleKey.ownerContactNumberNote.tr(),
            country: country,
            onCountrySelect: cubit.selectPhoneCountry,
            onChanged: cubit.mobileNumberChanged,
            validator: validateOptionalPhone,
          ),
        ),
        _fieldGap,
        RegistrationTextField(
          controller: _emailController,
          title: AppLocaleKey.emailAddress.tr(),
          hintText: AppLocaleKey.enterEmailAddress.tr(),
          helperText: AppLocaleKey.ownerContactEmailNote.tr(),
          keyboardType: TextInputType.emailAddress,
          onChanged: cubit.emailChanged,
          validator: validateOptionalEmail,
        ),
      ],
    );
  }
}
