import 'package:country_picker/country_picker.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/custom_widgets/bottom_sheet/option_picker_sheet.dart';
import '../../../../../core/custom_widgets/registration_form/registration_picker_field.dart';
import '../../../../../core/custom_widgets/registration_form/registration_text_field.dart';
import '../../../../../core/custom_widgets/validation/validation_mixin.dart';
import '../../../../../core/enum/address_type.dart';
import '../../../../../core/extension/context_ui_extension.dart';
import '../../../../../core/locale/app_locale_key.dart';
import '../../../../../core/utils/country_code_methods.dart';
import '../../controller/broker_business_address_cubit.dart';
import 'primary_business_address_checkbox.dart';

class BrokerBusinessAddressForm extends StatefulWidget {
  const BrokerBusinessAddressForm({super.key});

  @override
  State<BrokerBusinessAddressForm> createState() => _BrokerBusinessAddressFormState();
}

class _BrokerBusinessAddressFormState extends State<BrokerBusinessAddressForm>
    with ValidationMixin {
  final _governorateController = TextEditingController();
  final _cityController = TextEditingController();
  final _districtController = TextEditingController();
  final _addressLine1Controller = TextEditingController();
  final _addressLine2Controller = TextEditingController();
  final _postalCodeController = TextEditingController();

  static const _fieldGap = SizedBox(height: 18);

  @override
  void dispose() {
    _governorateController.dispose();
    _cityController.dispose();
    _districtController.dispose();
    _addressLine1Controller.dispose();
    _addressLine2Controller.dispose();
    _postalCodeController.dispose();
    super.dispose();
  }

  void _pickCountry() {
    CountryCodeMethods.pickCountry(
      context: context,
      showPhoneCode: false,
      onSelect: context.read<BrokerBusinessAddressCubit>().selectCountry,
    );
  }

  Future<void> _pickAddressType() async {
    final cubit = context.read<BrokerBusinessAddressCubit>();
    final type = await context.showAppBottomSheet<AddressType>(
      OptionPickerSheet<AddressType>(
        title: AppLocaleKey.addressType.tr(),
        options: AddressType.values,
        labelOf: (type) => type.labelKey.tr(),
        selected: cubit.state.type,
      ),
    );
    if (type != null) cubit.selectType(type);
  }

  void _clearDependentFields() {
    _governorateController.clear();
    _cityController.clear();
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<BrokerBusinessAddressCubit>();

    return BlocListener<BrokerBusinessAddressCubit, BrokerBusinessAddressState>(
      listenWhen: (previous, current) =>
          previous.country?.countryCode != current.country?.countryCode,
      listener: (_, _) => _clearDependentFields(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          BlocSelector<BrokerBusinessAddressCubit, BrokerBusinessAddressState, Country?>(
            selector: (state) => state.country,
            builder: (context, country) => RegistrationPickerField(
              title: AppLocaleKey.country.tr(),
              hintText: AppLocaleKey.selectCountry.tr(),
              value: country?.getTranslatedName(context) ?? country?.name,
              isRequired: true,
              showChevron: false,
              onTap: _pickCountry,
              validator: validateEmptyField,
            ),
          ),
          _fieldGap,
          BlocSelector<BrokerBusinessAddressCubit, BrokerBusinessAddressState, bool>(
            selector: (state) => state.canEnterGovernorate,
            builder: (context, enabled) => RegistrationTextField(
              controller: _governorateController,
              title: AppLocaleKey.governorateState.tr(),
              hintText: AppLocaleKey.enterGovernorate.tr(),
              isRequired: true,
              enabled: enabled,
              onChanged: cubit.governorateChanged,
              validator: validateEmptyField,
            ),
          ),
          _fieldGap,
          BlocSelector<BrokerBusinessAddressCubit, BrokerBusinessAddressState, bool>(
            selector: (state) => state.canEnterCity,
            builder: (context, enabled) => RegistrationTextField(
              controller: _cityController,
              title: AppLocaleKey.city.tr(),
              hintText: AppLocaleKey.enterCity.tr(),
              isRequired: true,
              enabled: enabled,
              onChanged: cubit.cityChanged,
              validator: validateEmptyField,
            ),
          ),
          _fieldGap,
          RegistrationTextField(
            controller: _districtController,
            title: AppLocaleKey.areaDistrict.tr(),
            hintText: AppLocaleKey.enterDistrictOrArea.tr(),
            onChanged: cubit.districtChanged,
          ),
          _fieldGap,
          RegistrationTextField(
            controller: _addressLine1Controller,
            title: AppLocaleKey.addressLine1.tr(),
            hintText: AppLocaleKey.addressLine1Hint.tr(),
            isRequired: true,
            keyboardType: TextInputType.streetAddress,
            onChanged: cubit.addressLine1Changed,
            validator: validateEmptyField,
          ),
          _fieldGap,
          RegistrationTextField(
            controller: _addressLine2Controller,
            title: AppLocaleKey.addressLine2.tr(),
            hintText: AppLocaleKey.floorSuiteDetailsHint.tr(),
            keyboardType: TextInputType.streetAddress,
            onChanged: cubit.addressLine2Changed,
          ),
          _fieldGap,
          RegistrationTextField(
            controller: _postalCodeController,
            title: AppLocaleKey.postalCode.tr(),
            hintText: AppLocaleKey.enterPostalCode.tr(),
            keyboardType: TextInputType.number,
            onChanged: cubit.postalCodeChanged,
          ),
          _fieldGap,
          BlocSelector<BrokerBusinessAddressCubit, BrokerBusinessAddressState, AddressType>(
            selector: (state) => state.type,
            builder: (context, type) => RegistrationPickerField(
              title: AppLocaleKey.addressType.tr(),
              hintText: AppLocaleKey.selectAddressType.tr(),
              value: type.labelKey.tr(),
              onTap: _pickAddressType,
            ),
          ),
          _fieldGap,
          const PrimaryBusinessAddressCheckbox(),
        ],
      ),
    );
  }
}
