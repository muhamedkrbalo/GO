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
import '../../../../../core/utils/date_methods.dart';
import '../../controller/broker_company_info_cubit.dart';

class BrokerCompanyInfoForm extends StatefulWidget {
  const BrokerCompanyInfoForm({super.key});

  @override
  State<BrokerCompanyInfoForm> createState() => _BrokerCompanyInfoFormState();
}

class _BrokerCompanyInfoFormState extends State<BrokerCompanyInfoForm> with ValidationMixin {
  late final TextEditingController _legalNameController;
  late final TextEditingController _tradeNameController;
  late final TextEditingController _registrationNumberController;
  late final TextEditingController _taxNumberController;
  late final TextEditingController _mobileController;
  late final TextEditingController _emailController;

  static const _fieldGap = SizedBox(height: 18);
  static final _dateFormat = DateFormat('dd MMM yyyy');
  static final _firstRegistrationDate = DateTime(1900);

  @override
  void initState() {
    super.initState();
    final state = context.read<BrokerCompanyInfoCubit>().state;
    _legalNameController = TextEditingController(text: state.legalName);
    _tradeNameController = TextEditingController(text: state.tradeName);
    _registrationNumberController = TextEditingController(text: state.registrationNumber);
    _taxNumberController = TextEditingController(text: state.taxNumber);
    _mobileController = TextEditingController(text: state.mobileNumber);
    _emailController = TextEditingController(text: state.email);
  }

  @override
  void dispose() {
    _legalNameController.dispose();
    _tradeNameController.dispose();
    _registrationNumberController.dispose();
    _taxNumberController.dispose();
    _mobileController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  Future<void> _pickLegalForm() async {
    final cubit = context.read<BrokerCompanyInfoCubit>();
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

  Future<void> _pickRegistrationDate() {
    final cubit = context.read<BrokerCompanyInfoCubit>();
    final today = DateUtils.dateOnly(DateTime.now());
    return DateMethods.pickDate(
      context,
      initialDate: cubit.state.registrationDate ?? today,
      firstDate: _firstRegistrationDate,
      lastDate: today,
      onSuccess: cubit.selectRegistrationDate,
    );
  }

  void _pickRegistrationCountry() {
    CountryCodeMethods.pickCountry(
      context: context,
      showPhoneCode: false,
      onSelect: context.read<BrokerCompanyInfoCubit>().selectRegistrationCountry,
    );
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<BrokerCompanyInfoCubit>();

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
          onChanged: cubit.tradeNameChanged,
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
        RegistrationTextField(
          controller: _taxNumberController,
          title: AppLocaleKey.taxRegistrationNumber.tr(),
          hintText: AppLocaleKey.enterTaxRegistrationNumber.tr(),
          onChanged: cubit.taxNumberChanged,
        ),
        _fieldGap,
        BlocSelector<BrokerCompanyInfoCubit, BrokerCompanyInfoState, LegalForm?>(
          selector: (state) => state.legalForm,
          builder: (context, legalForm) => RegistrationPickerField(
            title: AppLocaleKey.legalForm.tr(),
            hintText: AppLocaleKey.selectLegalForm.tr(),
            value: legalForm?.labelKey.tr(),
            isRequired: true,
            onTap: _pickLegalForm,
            validator: validateEmptyField,
          ),
        ),
        _fieldGap,
        BlocSelector<BrokerCompanyInfoCubit, BrokerCompanyInfoState, DateTime?>(
          selector: (state) => state.registrationDate,
          builder: (context, date) => RegistrationPickerField(
            title: AppLocaleKey.registrationDate.tr(),
            hintText: AppLocaleKey.selectRegistrationDate.tr(),
            value: date == null ? null : _dateFormat.format(date),
            isRequired: true,
            showChevron: false,
            onTap: _pickRegistrationDate,
            validator: validateEmptyField,
          ),
        ),
        _fieldGap,
        BlocSelector<BrokerCompanyInfoCubit, BrokerCompanyInfoState, Country?>(
          selector: (state) => state.registrationCountry,
          builder: (context, country) => RegistrationPickerField(
            title: AppLocaleKey.countryOfRegistration.tr(),
            hintText: AppLocaleKey.selectCountry.tr(),
            value: country?.getTranslatedName(context) ?? country?.name,
            isRequired: true,
            showChevron: false,
            onTap: _pickRegistrationCountry,
            validator: validateEmptyField,
          ),
        ),
        _fieldGap,
        BlocSelector<BrokerCompanyInfoCubit, BrokerCompanyInfoState, Country>(
          selector: (state) => state.phoneCountry,
          builder: (context, country) => RegistrationPhoneField(
            controller: _mobileController,
            title: AppLocaleKey.officialMobileNumber.tr(),
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
          title: AppLocaleKey.officialEmailAddress.tr(),
          hintText: AppLocaleKey.enterOfficialEmail.tr(),
          isRequired: true,
          keyboardType: TextInputType.emailAddress,
          onChanged: cubit.emailChanged,
          validator: validateEmail,
        ),
      ],
    );
  }
}
