import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/custom_widgets/buttons/primary_arrow_button.dart';
import '../../../../../core/locale/app_locale_key.dart';
import '../../../../../core/routes/routes_name.dart';
import '../../../../../core/theme/app_text_styles.dart';
import '../../../../../core/theme/extensions/theme_extensions.dart';
import '../../../data/model/broker_type.dart';
import '../../controller/broker_registration_draft_cubit.dart';
import '../../controller/broker_type_cubit.dart';

class BrokerTypeActions extends StatelessWidget {
  const BrokerTypeActions({super.key});

  static const _gap = 11.0;
  static const _minTapSize = Size.fromHeight(42);
  static const _textHeight = 1.5;

  void _continue(BuildContext context, BrokerType type) {
    context.read<BrokerRegistrationDraftCubit>().startRegistration(type);
    context.pushNamed(RouteNames.brokerPersonalInfo);
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.customColors;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        BlocBuilder<BrokerTypeCubit, BrokerType?>(
          builder: (context, selected) => PrimaryArrowButton(
            text: AppLocaleKey.continue_.tr(),
            isEnabled: selected != null,
            onPressed: selected == BrokerType.individual
                ? () => _continue(context, BrokerType.individual)
                : null,
          ),
        ),
        const SizedBox(height: _gap),
        TextButton(
          onPressed: () => context.goNamed(RouteNames.welcome),
          style: TextButton.styleFrom(
            minimumSize: _minTapSize,
            foregroundColor: colors.textPrimary,
            textStyle: AppTextStyles.xsBold.copyWith(height: _textHeight),
          ),
          child: Text(AppLocaleKey.saveAndExit.tr()),
        ),
      ],
    );
  }
}
