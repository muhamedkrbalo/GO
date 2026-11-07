import 'package:country_picker/country_picker.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/custom_widgets/validation/validation_mixin.dart';
import '../../../../../core/locale/app_locale_key.dart';
import '../../../../../core/utils/country_code_methods.dart';
import '../../controller/owner_address_cubit.dart';
import 'address_type_card.dart';
import 'registration_picker_field.dart';
import 'registration_section_card.dart';
import 'registration_text_field.dart';

class OwnerAddressForm extends StatefulWidget {
  const OwnerAddressForm({super.key});

  @override
  State<OwnerAddressForm> createState() => _OwnerAddressFormState();
}

class _OwnerAddressFormState extends State<OwnerAddressForm> with ValidationMixin {
  final _governorateController = TextEditingController();
  final _cityController = TextEditingController();
  final _districtController = TextEditingController();
  final _addressLine1Controller = TextEditingController();
  final _addressLine2Controller = TextEditingController();
  final _postalCodeController = TextEditingController();

  static const _cardGap = SizedBox(height: 24);

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
      onSelect: context.read<OwnerAddressCubit>().selectCountry,
    );
  }

  void _clearDependentFields() {
    _governorateController.clear();
    _cityController.clear();
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<OwnerAddressCubit>();

    return BlocListener<OwnerAddressCubit, OwnerAddressState>(
      listenWhen: (previous, current) =>
          previous.country?.countryCode != current.country?.countryCode,
      listener: (_, _) => _clearDependentFields(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          RegistrationSectionCard(
            title: AppLocaleKey.locationSection.tr(),
            hint: AppLocaleKey.ownerBusinessEntity.tr(),
            children: [
              BlocSelector<OwnerAddressCubit, OwnerAddressState, Country?>(
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
              BlocSelector<OwnerAddressCubit, OwnerAddressState, bool>(
                selector: (state) => state.canEnterGovernorate,
                builder: (context, enabled) => RegistrationTextField(
                  controller: _governorateController,
                  title: AppLocaleKey.governorateState.tr(),
                  hintText: AppLocaleKey.enterGovernorate.tr(),
                  enabled: enabled,
                  onChanged: cubit.governorateChanged,
                ),
              ),
              BlocSelector<OwnerAddressCubit, OwnerAddressState, bool>(
                selector: (state) => state.canEnterCity,
                builder: (context, enabled) => RegistrationTextField(
                  controller: _cityController,
                  title: AppLocaleKey.city.tr(),
                  hintText: AppLocaleKey.enterCity.tr(),
                  enabled: enabled,
                  onChanged: cubit.cityChanged,
                ),
              ),
              RegistrationTextField(
                controller: _districtController,
                onChanged: cubit.districtChanged,
                title: AppLocaleKey.areaDistrict.tr(),
                hintText: AppLocaleKey.enterDistrictOrArea.tr(),
              ),
            ],
          ),
          _cardGap,
          RegistrationSectionCard(
            title: AppLocaleKey.addressDetailsSection.tr(),
            hint: AppLocaleKey.doNotEnterUnitAddress.tr(),
            children: [
              RegistrationTextField(
                controller: _addressLine1Controller,
                title: AppLocaleKey.addressLine1.tr(),
                hintText: AppLocaleKey.addressLine1Hint.tr(),
                isRequired: true,
                keyboardType: TextInputType.streetAddress,
                onChanged: cubit.addressLine1Changed,
                validator: validateEmptyField,
              ),
              RegistrationTextField(
                controller: _addressLine2Controller,
                title: AppLocaleKey.addressLine2.tr(),
                hintText: AppLocaleKey.addressLine2Hint.tr(),
                keyboardType: TextInputType.streetAddress,
              ),
              RegistrationTextField(
                controller: _postalCodeController,
                title: AppLocaleKey.postalCode.tr(),
                hintText: AppLocaleKey.enterPostalCode.tr(),
                keyboardType: TextInputType.number,
              ),
            ],
          ),
          _cardGap,
          const AddressTypeCard(),
        ],
      ),
    );
  }
}
