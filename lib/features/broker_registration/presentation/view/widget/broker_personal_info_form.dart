import 'package:country_picker/country_picker.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/custom_widgets/registration_form/registration_phone_field.dart';
import '../../../../../core/custom_widgets/registration_form/registration_picker_field.dart';
import '../../../../../core/custom_widgets/registration_form/registration_text_field.dart';
import '../../../../../core/custom_widgets/validation/validation_mixin.dart';
import '../../../../../core/locale/app_locale_key.dart';
import '../../../../../core/utils/country_code_methods.dart';
import '../../controller/broker_personal_info_cubit.dart';

class BrokerPersonalInfoForm extends StatefulWidget {
  const BrokerPersonalInfoForm({super.key});

  @override
  State<BrokerPersonalInfoForm> createState() => _BrokerPersonalInfoFormState();
}

class _BrokerPersonalInfoFormState extends State<BrokerPersonalInfoForm> with ValidationMixin {
  late final TextEditingController _nameController;
  late final TextEditingController _mobileController;
  late final TextEditingController _emailController;

  static const _fieldGap = SizedBox(height: 18);

  @override
  void initState() {
    super.initState();
    final state = context.read<BrokerPersonalInfoCubit>().state;
    _nameController = TextEditingController(text: state.fullName);
    _mobileController = TextEditingController(text: state.mobileNumber);
    _emailController = TextEditingController(text: state.email);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _mobileController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  void _pickNationality() {
    CountryCodeMethods.pickCountry(
      context: context,
      showPhoneCode: false,
      onSelect: context.read<BrokerPersonalInfoCubit>().selectNationality,
    );
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<BrokerPersonalInfoCubit>();

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
        BlocSelector<BrokerPersonalInfoCubit, BrokerPersonalInfoState, Country?>(
          selector: (state) => state.nationality,
          builder: (context, nationality) => RegistrationPickerField(
            title: AppLocaleKey.nationality.tr(),
            hintText: AppLocaleKey.selectNationality.tr(),
            value: nationality?.getTranslatedName(context) ?? nationality?.name,
            isRequired: true,
            showChevron: false,
            onTap: _pickNationality,
            validator: validateEmptyField,
          ),
        ),
        _fieldGap,
        BlocSelector<BrokerPersonalInfoCubit, BrokerPersonalInfoState, Country>(
          selector: (state) => state.phoneCountry,
          builder: (context, country) => RegistrationPhoneField(
            controller: _mobileController,
            title: AppLocaleKey.mobileNumber.tr(),
            hintText: AppLocaleKey.enterMobileNumber.tr(),
            isRequired: true,
            country: country,
            onCountrySelect: cubit.selectPhoneCountry,
            onChanged: cubit.mobileNumberChanged,
            validator: validatePhone,
          ),
        ),
        _fieldGap,
        RegistrationTextField(
          controller: _emailController,
          title: AppLocaleKey.emailAddress.tr(),
          hintText: AppLocaleKey.enterEmailAddress.tr(),
          helperText: AppLocaleKey.businessEntityContactNote.tr(),
          isRequired: true,
          keyboardType: TextInputType.emailAddress,
          onChanged: cubit.emailChanged,
          validator: validateEmail,
        ),
      ],
    );
  }
}
