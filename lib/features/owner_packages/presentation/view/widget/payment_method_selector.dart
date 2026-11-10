import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/model/payment_method.dart';
import '../../controller/package_payment_cubit.dart';
import 'package_option_tile.dart';
import 'package_tile_grid.dart';

class PaymentMethodSelector extends StatelessWidget {
  const PaymentMethodSelector({super.key});

  @override
  Widget build(BuildContext context) {
    return PackageTileGrid(
      children: [for (final method in PaymentMethod.values) _PaymentMethodOption(method: method)],
    );
  }
}

class _PaymentMethodOption extends StatelessWidget {
  const _PaymentMethodOption({required this.method});

  final PaymentMethod method;

  @override
  Widget build(BuildContext context) {
    return BlocSelector<PackagePaymentCubit, PackagePaymentState, bool>(
      selector: (state) => state.method == method,
      builder: (context, isSelected) => PackageOptionTile(
        label: method.labelKey.tr(),
        isSelectable: true,
        isSelected: isSelected,
        onTap: () => context.read<PackagePaymentCubit>().selectMethod(method),
      ),
    );
  }
}
