import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/locale/app_locale_key.dart';
import '../../../data/model/payment_method.dart';
import '../../controller/package_payment_cubit.dart';
import 'package_actions_bottom_bar.dart';

class PackagePaymentBottomBar extends StatelessWidget {
  const PackagePaymentBottomBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<PackagePaymentCubit, PaymentMethod?, bool>(
      selector: (method) => method != null,
      builder: (context, hasMethod) => PackageActionsBottomBar(
        confirmLabel: AppLocaleKey.submitPaymentDetails.tr(),
        backLabel: AppLocaleKey.cancel.tr(),
        isConfirmEnabled: hasMethod,
        onConfirm: null,
        onBack: () => context.pop(),
      ),
    );
  }
}
