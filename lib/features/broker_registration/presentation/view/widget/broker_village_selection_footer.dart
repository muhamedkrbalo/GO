import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/locale/app_locale_key.dart';
import '../../../../../core/routes/routes_name.dart';
import '../../controller/broker_village_selection_cubit.dart';
import 'broker_form_footer.dart';

class BrokerVillageSelectionFooter extends StatelessWidget {
  const BrokerVillageSelectionFooter({super.key});

  void _submit(BuildContext context) {
    context.pushNamed(
      RouteNames.brokerVillageRequestsSubmitted,
      extra: context.read<BrokerVillageSelectionCubit>().state.selectedVillages,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocSelector<BrokerVillageSelectionCubit, BrokerVillageSelectionState, bool>(
      selector: (state) => state.canSubmit,
      builder: (context, canSubmit) => BrokerFormFooter(
        label: AppLocaleKey.submitVillageRequests.tr(),
        isEnabled: canSubmit,
        onContinue: canSubmit ? () => _submit(context) : null,
      ),
    );
  }
}
