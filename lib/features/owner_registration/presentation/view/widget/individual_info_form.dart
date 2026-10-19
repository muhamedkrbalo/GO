import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/custom_widgets/bottom_sheet/option_picker_sheet.dart';
import '../../../../../core/custom_widgets/custom_form_field/custom_form_field.dart';
import '../../../../../core/custom_widgets/custom_form_field/custom_picker_field.dart';
import '../../../../../core/custom_widgets/validation/validation_mixin.dart';
import '../../../../../core/extension/context_ui_extension.dart';
import '../../../../../core/images/app_images.dart';
import '../../../../../core/locale/app_locale_key.dart';
import '../../../../../core/theme/app_shadows.dart';
import '../../../../../core/theme/app_sizes.dart';
import '../../../../../core/theme/extensions/theme_extensions.dart';
import '../../../../../core/utils/country_code_methods.dart';
import '../../../../../core/utils/date_methods.dart';
import '../../../data/model/gender.dart';
import '../../../data/model/id_type.dart';
import '../../controller/individual_info_cubit.dart';
import 'form_section_header.dart';

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

  static const _padding = EdgeInsets.all(19.2);
  static const _sectionPadding = EdgeInsets.fromLTRB(19.2, 16, 19.2, 19.2);
  static const _radius = BorderRadius.all(Radius.circular(14.4));
  static const _borderWidth = 1.6;

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

  Future<void> _pickGender() async {
    final cubit = context.read<IndividualInfoCubit>();
    final gender = await context.showAppBottomSheet<Gender>(
      OptionPickerSheet<Gender>(
        title: AppLocaleKey.gender.tr(),
        options: Gender.values,
        labelOf: (gender) => gender.labelKey.tr(),
        selected: cubit.state.gender,
      ),
    );
    if (gender != null) cubit.selectGender(gender);
  }

  void _pickNationality() {
    CountryCodeMethods.pickCountry(
      context: context,
      showPhoneCode: false,
      onSelect: context.read<IndividualInfoCubit>().selectNationality,
    );
  }

  Future<void> _pickDateOfBirth() {
    final cubit = context.read<IndividualInfoCubit>();
    final today = DateUtils.dateOnly(DateTime.now());
    return DateMethods.pickDate(
      context,
      initialDate: cubit.state.dateOfBirth ?? DateTime(today.year - 25),
      firstDate: DateTime(1900),
      lastDate: today,
      onSuccess: cubit.selectDateOfBirth,
    );
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.customColors;
    final languageCode = context.locale.languageCode;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: _radius,
        border: Border.all(color: colors.subtleBorder, width: _borderWidth),
        boxShadow: AppShadows.softCard,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: _padding,
            child: Column(
              children: [
                CustomFormField(
                  controller: _nameController,
                  title: AppLocaleKey.fullLegalName.tr(),
                  hintText: AppLocaleKey.enterFullLegalName.tr(),
                  isRequired: true,
                  keyboardType: TextInputType.name,
                  validator: validateName,
                ),
                AppSpacing.gapV16,
                BlocSelector<IndividualInfoCubit, IndividualInfoState, IdType?>(
                  selector: (state) => state.idType,
                  builder: (context, idType) => CustomPickerField(
                    title: AppLocaleKey.idType.tr(),
                    hintText: AppLocaleKey.selectIdType.tr(),
                    value: idType?.labelKey.tr(),
                    icon: AppImages.assetsSvgSelectArrow,
                    isRequired: true,
                    onTap: _pickIdType,
                    validator: validateEmptyField,
                  ),
                ),
                AppSpacing.gapV16,
                CustomFormField(
                  controller: _idNumberController,
                  title: AppLocaleKey.idNumber.tr(),
                  hintText: AppLocaleKey.enterIdNumber.tr(),
                  isRequired: true,
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  validator: validateEmptyField,
                ),
                AppSpacing.gapV16,
                BlocSelector<IndividualInfoCubit, IndividualInfoState, String?>(
                  selector: (state) => state.nationality?.countryCode,
                  builder: (context, _) {
                    final nationality = context.read<IndividualInfoCubit>().state.nationality;
                    return CustomPickerField(
                      title: AppLocaleKey.nationality.tr(),
                      hintText: AppLocaleKey.selectNationality.tr(),
                      value: nationality?.getTranslatedName(context) ?? nationality?.name,
                      icon: AppImages.assetsSvgSearch,
                      isRequired: true,
                      onTap: _pickNationality,
                      validator: validateEmptyField,
                    );
                  },
                ),
                AppSpacing.gapV16,
                BlocSelector<IndividualInfoCubit, IndividualInfoState, DateTime?>(
                  selector: (state) => state.dateOfBirth,
                  builder: (context, dateOfBirth) => CustomPickerField(
                    title: AppLocaleKey.dateOfBirth.tr(),
                    hintText: AppLocaleKey.selectDateOfBirth.tr(),
                    value: dateOfBirth == null
                        ? null
                        : DateFormat('dd MMM yyyy', languageCode).format(dateOfBirth),
                    icon: AppImages.assetsSvgSelectArrow,
                    isRequired: true,
                    onTap: _pickDateOfBirth,
                    validator: validateEmptyField,
                  ),
                ),
                AppSpacing.gapV16,
                BlocSelector<IndividualInfoCubit, IndividualInfoState, Gender?>(
                  selector: (state) => state.gender,
                  builder: (context, gender) => CustomPickerField(
                    title: AppLocaleKey.gender.tr(),
                    hintText: AppLocaleKey.selectGender.tr(),
                    value: gender?.labelKey.tr(),
                    icon: AppImages.assetsSvgSelectArrow,
                    isRequired: true,
                    onTap: _pickGender,
                    validator: validateEmptyField,
                  ),
                ),
              ],
            ),
          ),
          Divider(height: _borderWidth, thickness: _borderWidth, color: colors.subtleBorder),
          Padding(
            padding: _sectionPadding,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FormSectionHeader(
                  title: AppLocaleKey.businessContact.tr(),
                  subtitle: AppLocaleKey.businessContactDescription.tr(),
                ),
                AppSpacing.gapV16,
                CustomFormField(
                  controller: _mobileController,
                  title: AppLocaleKey.mobileNumber.tr(),
                  hintText: AppLocaleKey.enterMobileNumber.tr(),
                  isRequired: true,
                  keyboardType: TextInputType.phone,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  validator: validatePhone,
                ),
                AppSpacing.gapV16,
                CustomFormField(
                  controller: _emailController,
                  title: AppLocaleKey.emailAddress.tr(),
                  hintText: AppLocaleKey.enterEmailAddress.tr(),
                  isRequired: true,
                  keyboardType: TextInputType.emailAddress,
                  validator: validateEmail,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
