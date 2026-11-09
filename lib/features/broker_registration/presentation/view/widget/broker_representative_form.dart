import 'package:country_picker/country_picker.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/custom_widgets/bottom_sheet/option_picker_sheet.dart';
import '../../../../../core/custom_widgets/registration_form/registration_notice.dart';
import '../../../../../core/custom_widgets/registration_form/registration_phone_field.dart';
import '../../../../../core/custom_widgets/registration_form/registration_picker_field.dart';
import '../../../../../core/custom_widgets/registration_form/registration_text_field.dart';
import '../../../../../core/custom_widgets/validation/validation_mixin.dart';
import '../../../../../core/enum/id_type.dart';
import '../../../../../core/extension/context_ui_extension.dart';
import '../../../../../core/locale/app_locale_key.dart';
import '../../../../../core/models/uploaded_document.dart';
import '../../controller/broker_representative_cubit.dart';
import 'broker_upload_card.dart';

class BrokerRepresentativeForm extends StatefulWidget {
  const BrokerRepresentativeForm({super.key});

  @override
  State<BrokerRepresentativeForm> createState() => _BrokerRepresentativeFormState();
}

class _BrokerRepresentativeFormState extends State<BrokerRepresentativeForm> with ValidationMixin {
  late final TextEditingController _nameController;
  late final TextEditingController _idNumberController;
  late final TextEditingController _mobileController;
  late final TextEditingController _emailController;

  static const _noticeToFieldsGap = SizedBox(height: 28);
  static const _fieldGap = SizedBox(height: 18);
  static final _digitsOnly = [FilteringTextInputFormatter.digitsOnly];
  static final _alphanumericOnly = [FilteringTextInputFormatter.allow(RegExp('[a-zA-Z0-9]'))];

  @override
  void initState() {
    super.initState();
    final state = context.read<BrokerRepresentativeCubit>().state;
    _nameController = TextEditingController(text: state.fullName);
    _idNumberController = TextEditingController(text: state.idNumber);
    _mobileController = TextEditingController(text: state.mobileNumber);
    _emailController = TextEditingController(text: state.email);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _idNumberController.dispose();
    _mobileController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  Future<void> _pickIdType() async {
    final cubit = context.read<BrokerRepresentativeCubit>();
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

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<BrokerRepresentativeCubit>();

    return BlocListener<BrokerRepresentativeCubit, BrokerRepresentativeState>(
      listenWhen: (previous, current) => previous.idType != current.idType,
      listener: (_, _) => _idNumberController.clear(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          RegistrationNotice(message: AppLocaleKey.registeringAccountMustBeAuthorized.tr()),
          _noticeToFieldsGap,
          RegistrationTextField(
            controller: _nameController,
            title: AppLocaleKey.representativeFullName.tr(),
            hintText: AppLocaleKey.enterFullLegalName.tr(),
            isRequired: true,
            keyboardType: TextInputType.name,
            onChanged: cubit.fullNameChanged,
            validator: validateName,
          ),
          _fieldGap,
          BlocSelector<BrokerRepresentativeCubit, BrokerRepresentativeState, IdType?>(
            selector: (state) => state.idType,
            builder: (context, idType) => Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                RegistrationPickerField(
                  title: AppLocaleKey.idType.tr(),
                  hintText: AppLocaleKey.selectIdType.tr(),
                  value: idType?.labelKey.tr(),
                  isRequired: true,
                  onTap: _pickIdType,
                  validator: validateEmptyField,
                ),
                _fieldGap,
                RegistrationTextField(
                  controller: _idNumberController,
                  title: AppLocaleKey.idNumber.tr(),
                  hintText: AppLocaleKey.enterIdNumber.tr(),
                  isRequired: true,
                  keyboardType: idType == IdType.passport
                      ? TextInputType.text
                      : TextInputType.number,
                  inputFormatters: idType == IdType.passport ? _alphanumericOnly : _digitsOnly,
                  onChanged: cubit.idNumberChanged,
                  validator: validateEmptyField,
                ),
              ],
            ),
          ),
          _fieldGap,
          BlocSelector<BrokerRepresentativeCubit, BrokerRepresentativeState, Country>(
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
            isRequired: true,
            keyboardType: TextInputType.emailAddress,
            onChanged: cubit.emailChanged,
            validator: validateEmail,
          ),
          _fieldGap,
          BlocSelector<BrokerRepresentativeCubit, BrokerRepresentativeState, UploadedDocument?>(
            selector: (state) => state.proofOfAuthorization,
            builder: (context, document) => BrokerUploadCard(
              title: AppLocaleKey.proofOfAuthorization.tr(),
              isRequired: true,
              document: document,
              onAttach: cubit.attachProof,
              onRemove: cubit.removeProof,
            ),
          ),
        ],
      ),
    );
  }
}
