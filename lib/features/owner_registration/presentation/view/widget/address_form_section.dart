import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/custom_widgets/bottom_sheet/option_picker_sheet.dart';
import '../../../../../core/custom_widgets/custom_form_field/custom_form_field.dart';
import '../../../../../core/custom_widgets/custom_form_field/custom_picker_field.dart';
import '../../../../../core/custom_widgets/validation/validation_mixin.dart';
import '../../../../../core/extension/context_ui_extension.dart';
import '../../../../../core/images/app_images.dart';
import '../../../../../core/locale/app_locale_key.dart';
import '../../../../../core/theme/app_sizes.dart';
import '../../../../../core/theme/app_text_styles.dart';
import '../../../../../core/theme/extensions/theme_extensions.dart';
import '../../../../../core/utils/country_code_methods.dart';
import '../../../data/model/address_type.dart';
import '../../controller/owner_address_cubit.dart';
import 'form_section_header.dart';

class AddressFormSection extends StatefulWidget {
  const AddressFormSection({super.key, required this.id, required this.number});

  final int id;
  final int number;

  @override
  State<AddressFormSection> createState() => _AddressFormSectionState();
}

class _AddressFormSectionState extends State<AddressFormSection> with ValidationMixin {
  final _cityController = TextEditingController();
  final _areaController = TextEditingController();
  final _streetController = TextEditingController();
  final _buildingController = TextEditingController();
  final _floorController = TextEditingController();
  final _postalCodeController = TextEditingController();

  static const _padding = EdgeInsets.all(19.2);
  static const _streetLines = 3;

  bool get _isPrimary => widget.number == 1;

  @override
  void dispose() {
    _cityController.dispose();
    _areaController.dispose();
    _streetController.dispose();
    _buildingController.dispose();
    _floorController.dispose();
    _postalCodeController.dispose();
    super.dispose();
  }

  Future<void> _pickType() async {
    final cubit = context.read<OwnerAddressCubit>();
    final type = await context.showAppBottomSheet<AddressType>(
      OptionPickerSheet<AddressType>(
        title: AppLocaleKey.addressType.tr(),
        options: AddressType.values,
        labelOf: (type) => type.labelKey.tr(),
        selected: cubit.state.addressById(widget.id)?.type,
      ),
    );
    if (type != null) cubit.selectType(widget.id, type);
  }

  void _pickCountry() {
    final cubit = context.read<OwnerAddressCubit>();
    CountryCodeMethods.pickCountry(
      context: context,
      showPhoneCode: false,
      onSelect: (country) => cubit.selectCountry(widget.id, country),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.customColors;
    final optional = AppLocaleKey.optional.tr();

    return Padding(
      padding: _padding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: FormSectionHeader(
                  title: AppLocaleKey.addressNumber.tr(args: ['${widget.number}']),
                  subtitle: _isPrimary
                      ? AppLocaleKey.primaryRegistrationAddress.tr()
                      : AppLocaleKey.additionalAddress.tr(),
                ),
              ),
              if (!_isPrimary)
                TextButton(
                  onPressed: () => context.read<OwnerAddressCubit>().removeAddress(widget.id),
                  style: TextButton.styleFrom(
                    foregroundColor: colors.error,
                    textStyle: AppTextStyles.xsBold,
                  ),
                  child: Text(AppLocaleKey.removeAddress.tr()),
                ),
            ],
          ),
          AppSpacing.gapV16,
          BlocSelector<OwnerAddressCubit, OwnerAddressState, AddressType?>(
            selector: (state) => state.addressById(widget.id)?.type,
            builder: (context, type) => CustomPickerField(
              title: AppLocaleKey.addressType.tr(),
              hintText: AppLocaleKey.selectAddressType.tr(),
              value: type?.labelKey.tr(),
              icon: AppImages.assetsSvgSelectArrow,
              isRequired: true,
              onTap: _pickType,
              validator: validateEmptyField,
            ),
          ),
          AppSpacing.gapV16,
          BlocSelector<OwnerAddressCubit, OwnerAddressState, String?>(
            selector: (state) => state.addressById(widget.id)?.country?.countryCode,
            builder: (context, _) {
              final country = context
                  .read<OwnerAddressCubit>()
                  .state
                  .addressById(widget.id)
                  ?.country;
              return CustomPickerField(
                title: AppLocaleKey.country.tr(),
                hintText: AppLocaleKey.searchCountry.tr(),
                value: country?.getTranslatedName(context) ?? country?.name,
                icon: AppImages.assetsSvgSearch,
                isRequired: true,
                onTap: _pickCountry,
                validator: validateEmptyField,
              );
            },
          ),
          AppSpacing.gapV16,
          _FieldPair(
            start: CustomFormField(
              controller: _cityController,
              title: AppLocaleKey.city.tr(),
              hintText: AppLocaleKey.enterCity.tr(),
              isRequired: true,
              keyboardType: TextInputType.text,
              validator: validateEmptyField,
            ),
            end: CustomFormField(
              controller: _areaController,
              title: AppLocaleKey.areaDistrict.tr(),
              hintText: optional,
            ),
          ),
          AppSpacing.gapV16,
          CustomFormField(
            controller: _streetController,
            title: AppLocaleKey.streetAddress.tr(),
            hintText: AppLocaleKey.streetAddressHint.tr(),
            isRequired: true,
            keyboardType: TextInputType.streetAddress,
            maxLines: _streetLines,
            validator: validateEmptyField,
          ),
          AppSpacing.gapV16,
          _FieldPair(
            start: CustomFormField(
              controller: _buildingController,
              title: AppLocaleKey.buildingNumber.tr(),
              hintText: optional,
            ),
            end: CustomFormField(
              controller: _floorController,
              title: AppLocaleKey.floorApartment.tr(),
              hintText: optional,
            ),
          ),
          AppSpacing.gapV16,
          _FieldPair(
            start: CustomFormField(
              controller: _postalCodeController,
              title: AppLocaleKey.postalCode.tr(),
              hintText: AppLocaleKey.enterPostalCode.tr(),
            ),
          ),
        ],
      ),
    );
  }
}

class _FieldPair extends StatelessWidget {
  const _FieldPair({required this.start, this.end});

  final Widget start;
  final Widget? end;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(child: start),
        AppSpacing.gapH12,
        Expanded(child: end ?? const SizedBox.shrink()),
      ],
    );
  }
}
