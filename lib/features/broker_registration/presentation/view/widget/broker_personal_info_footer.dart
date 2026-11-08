import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/custom_widgets/buttons/primary_arrow_button.dart';
import '../../../../../core/custom_widgets/registration_form/registration_sticky_footer.dart';
import '../../../../../core/locale/app_locale_key.dart';
import '../../../../../core/theme/app_text_styles.dart';
import '../../controller/broker_personal_info_cubit.dart';

class BrokerPersonalInfoFooter extends StatelessWidget {
  const BrokerPersonalInfoFooter({super.key});

  void _continue(BuildContext context) {
    Form.of(context).validate();
  }

  @override
  Widget build(BuildContext context) {
    return RegistrationStickyFooter(
      saveAndExitAlignment: AlignmentDirectional.center,
      saveAndExitTextStyle: AppTextStyles.xxsBold,
      child: BlocSelector<BrokerPersonalInfoCubit, BrokerPersonalInfoState, bool>(
        selector: (state) => state.canContinue,
        builder: (context, canContinue) => PrimaryArrowButton(
          text: AppLocaleKey.continue_.tr(),
          textStyle: AppTextStyles.xs13Bold,
          //isEnabled: canContinue,
          isEnabled: true,
          onPressed: canContinue ? () => _continue(context) : null,
        ),
      ),
    );
  }
}
