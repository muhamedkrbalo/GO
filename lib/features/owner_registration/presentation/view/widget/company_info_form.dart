import 'package:country_picker/country_picker.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/custom_widgets/bottom_sheet/option_picker_sheet.dart';
import '../../../../../core/custom_widgets/registration_form/registration_phone_field.dart';
import '../../../../../core/custom_widgets/registration_form/registration_picker_field.dart';
import '../../../../../core/custom_widgets/registration_form/registration_text_field.dart';
import '../../../../../core/custom_widgets/validation/validation_mixin.dart';
import '../../../../../core/enum/legal_form.dart';
import '../../../../../core/extension/context_ui_extension.dart';
import '../../../../../core/locale/app_locale_key.dart';
import '../../../../../core/utils/country_code_methods.dart';
import '../../controller/company_info_cubit.dart';

class CompanyInfoForm extends StatefulWidget {
  const CompanyInfoForm({super.key});

  @override
  State<CompanyInfoForm> createState() => _CompanyInfoFormState();
}

class _CompanyInfoFormState extends State<CompanyInfoForm> with ValidationMixin {
  final _legalNameController = TextEditingController();
  final _tradeNameController = TextEditingController();
  final _registrationNumberController = TextEditingController();
  final _mobileController = TextEditingController();
  final _emailController = TextEditingController();

  static const _fieldGap = SizedBox(height: 18);

  @override
  void dispose() {
    _legalNameController.dispose();
    _tradeNameController.dispose();
    _registrationNumberController.dispose();
    _mobileController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  Future<void> _pickLegalForm() async {
    final cubit = context.read<CompanyInfoCubit>();
    final legalForm = await context.showAppBottomSheet<LegalForm>(
      OptionPickerSheet<LegalForm>(
        title: AppLocaleKey.legalForm.tr(),
        options: LegalForm.values,
        labelOf: (form) => form.labelKey.tr(),
        selected: cubit.state.legalForm,
      ),
    );
    if (legalForm != null) cubit.selectLegalForm(legalForm);
  }

  void _pickRegistrationCountry() {
    CountryCodeMethods.pickCountry(
      context: context,
      showPhoneCode: false,
      onSelect: context.read<CompanyInfoCubit>().selectRegistrationCountry,
    );
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<CompanyInfoCubit>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        RegistrationTextField(
          controller: _legalNameController,
          title: AppLocaleKey.legalCompanyName.tr(),
          hintText: AppLocaleKey.enterRegisteredCompanyName.tr(),
          isRequired: true,
          keyboardType: TextInputType.name,
          onChanged: cubit.legalNameChanged,
          validator: validateEmptyField,
        ),
        _fieldGap,
        RegistrationTextField(
          controller: _tradeNameController,
          title: AppLocaleKey.tradeName.tr(),
          hintText: AppLocaleKey.enterTradeName.tr(),
          keyboardType: TextInputType.name,
        ),
        _fieldGap,
        RegistrationTextField(
          controller: _registrationNumberController,
          title: AppLocaleKey.commercialRegistrationNumber.tr(),
          hintText: AppLocaleKey.enterRegistrationNumber.tr(),
          isRequired: true,
          onChanged: cubit.registrationNumberChanged,
          validator: validateEmptyField,
        ),
        _fieldGap,
        BlocSelector<CompanyInfoCubit, CompanyInfoState, LegalForm?>(
          selector: (state) => state.legalForm,
          builder: (context, legalForm) => RegistrationPickerField(
            title: AppLocaleKey.legalForm.tr(),
            hintText: AppLocaleKey.selectLegalForm.tr(),
            value: legalForm?.labelKey.tr(),
            onTap: _pickLegalForm,
          ),
        ),
        _fieldGap,
        BlocSelector<CompanyInfoCubit, CompanyInfoState, Country?>(
          selector: (state) => state.registrationCountry,
          builder: (context, country) => RegistrationPickerField(
            title: AppLocaleKey.countryOfRegistration.tr(),
            hintText: AppLocaleKey.selectCountryOfRegistration.tr(),
            value: country?.getTranslatedName(context) ?? country?.name,
            isRequired: true,
            showChevron: false,
            onTap: _pickRegistrationCountry,
            validator: validateEmptyField,
          ),
        ),
        _fieldGap,
        BlocSelector<CompanyInfoCubit, CompanyInfoState, Country>(
          selector: (state) => state.phoneCountry,
          builder: (context, country) => RegistrationPhoneField(
            controller: _mobileController,
            title: AppLocaleKey.officialMobileNumber.tr(),
            hintText: AppLocaleKey.enterMobileNumber.tr(),
            country: country,
            onCountrySelect: cubit.selectPhoneCountry,
            onChanged: cubit.mobileNumberChanged,
            validator: validateOptionalPhone,
          ),
        ),
        _fieldGap,
        RegistrationTextField(
          controller: _emailController,
          title: AppLocaleKey.officialEmailAddress.tr(),
          hintText: AppLocaleKey.enterEmailAddress.tr(),
          keyboardType: TextInputType.emailAddress,
          onChanged: cubit.emailChanged,
          validator: validateOptionalEmail,
        ),
      ],
    );
  }
}
