import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/custom_widgets/bottom_sheet/option_picker_sheet.dart';
import '../../../../../core/custom_widgets/registration_form/registration_picker_field.dart';
import '../../../../../core/custom_widgets/registration_form/registration_text_field.dart';
import '../../../../../core/custom_widgets/validation/validation_mixin.dart';
import '../../../../../core/enum/id_type.dart';
import '../../../../../core/extension/context_ui_extension.dart';
import '../../../../../core/locale/app_locale_key.dart';
import '../../controller/broker_identity_info_cubit.dart';

class BrokerIdentityInfoForm extends StatefulWidget {
  const BrokerIdentityInfoForm({super.key});

  @override
  State<BrokerIdentityInfoForm> createState() => _BrokerIdentityInfoFormState();
}

class _BrokerIdentityInfoFormState extends State<BrokerIdentityInfoForm> with ValidationMixin {
  final _idNumberController = TextEditingController();

  static const _fieldGap = SizedBox(height: 18);
  static final _digitsOnly = [FilteringTextInputFormatter.digitsOnly];
  static final _alphanumericOnly = [FilteringTextInputFormatter.allow(RegExp('[a-zA-Z0-9]'))];

  @override
  void dispose() {
    _idNumberController.dispose();
    super.dispose();
  }

  Future<void> _pickIdType() async {
    final cubit = context.read<BrokerIdentityInfoCubit>();
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
    return BlocConsumer<BrokerIdentityInfoCubit, BrokerIdentityInfoState>(
      listenWhen: (previous, current) => previous.idType != current.idType,
      listener: (context, state) => _idNumberController.clear(),
      buildWhen: (previous, current) => previous.idType != current.idType,
      builder: (context, state) {
        final isPassport = state.idType == IdType.passport;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            RegistrationPickerField(
              title: AppLocaleKey.idType.tr(),
              hintText: AppLocaleKey.selectIdType.tr(),
              value: state.idType?.labelKey.tr(),
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
              keyboardType: isPassport ? TextInputType.text : TextInputType.number,
              inputFormatters: isPassport ? _alphanumericOnly : _digitsOnly,
              onChanged: context.read<BrokerIdentityInfoCubit>().idNumberChanged,
              validator: validateEmptyField,
            ),
          ],
        );
      },
    );
  }
}
