import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/theme/app_sizes.dart';
import '../../../data/model/payment_method.dart';
import '../../controller/package_payment_cubit.dart';
import 'payment_method_tile.dart';

class PaymentMethodSelector extends StatelessWidget {
  const PaymentMethodSelector({super.key});

  static const _columns = 2;

  @override
  Widget build(BuildContext context) {
    const methods = PaymentMethod.values;

    return Column(
      spacing: AppSpacing.s8,
      children: [
        for (var start = 0; start < methods.length; start += _columns)
          Row(
            spacing: AppSpacing.s8,
            children: [
              for (var index = start; index < start + _columns; index++)
                Expanded(
                  child: index < methods.length
                      ? _PaymentMethodOption(method: methods[index])
                      : const SizedBox.shrink(),
                ),
            ],
          ),
      ],
    );
  }
}

class _PaymentMethodOption extends StatelessWidget {
  const _PaymentMethodOption({required this.method});

  final PaymentMethod method;

  @override
  Widget build(BuildContext context) {
    return BlocSelector<PackagePaymentCubit, PaymentMethod?, bool>(
      selector: (selected) => selected == method,
      builder: (context, isSelected) => PaymentMethodTile(
        label: method.labelKey.tr(),
        isSelected: isSelected,
        onTap: () => context.read<PackagePaymentCubit>().selectMethod(method),
      ),
    );
  }
}
