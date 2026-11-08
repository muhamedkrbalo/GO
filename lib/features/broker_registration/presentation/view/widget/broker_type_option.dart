import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/custom_widgets/selectable_option_card/selectable_option_card.dart';
import '../../../../../core/theme/extensions/theme_extensions.dart';
import '../../../data/model/broker_type.dart';
import '../../controller/broker_type_cubit.dart';

class BrokerTypeOption extends StatelessWidget {
  const BrokerTypeOption({super.key, required this.type});

  final BrokerType type;

  static const _selectedBorderWidth = 2.0;

  @override
  Widget build(BuildContext context) {
    final colors = context.customColors;

    return BlocSelector<BrokerTypeCubit, BrokerType?, bool>(
      selector: (selected) => selected == type,
      builder: (context, isSelected) => SelectableOptionCard(
        icon: type.icon,
        title: type.titleKey.tr(),
        description: type.descriptionKey.tr(),
        isSelected: isSelected,
        selectedBorderWidth: _selectedBorderWidth,
        selectedIconTileColor: colors.primary,
        selectedIconColor: colors.onPrimary,
        onTap: () => context.read<BrokerTypeCubit>().selectType(type),
      ),
    );
  }
}
