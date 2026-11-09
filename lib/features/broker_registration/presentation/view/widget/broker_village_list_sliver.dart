import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/locale/app_locale_key.dart';
import '../../../../../core/theme/app_sizes.dart';
import '../../../../../core/theme/app_text_styles.dart';
import '../../../../../core/theme/extensions/theme_extensions.dart';
import '../../controller/broker_village_selection_cubit.dart';
import 'broker_village_card.dart';

class BrokerVillageListSliver extends StatelessWidget {
  const BrokerVillageListSliver({super.key});

  static const _emptyPadding = EdgeInsetsDirectional.symmetric(vertical: 32);

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<BrokerVillageSelectionCubit>();

    return BlocBuilder<BrokerVillageSelectionCubit, BrokerVillageSelectionState>(
      buildWhen: (previous, current) =>
          !listEquals(previous.visibleVillages, current.visibleVillages),
      builder: (context, state) {
        final villages = state.visibleVillages;
        if (villages.isEmpty) {
          return SliverToBoxAdapter(
            child: Padding(
              padding: _emptyPadding,
              child: Text(
                AppLocaleKey.noVillagesFound.tr(),
                textAlign: TextAlign.center,
                style: AppTextStyles.xsMedium.copyWith(color: context.customColors.textMuted),
              ),
            ),
          );
        }
        return SliverList.separated(
          itemCount: villages.length,
          separatorBuilder: (_, _) => AppSpacing.gapV10,
          itemBuilder: (context, index) {
            final village = villages[index];
            return BlocSelector<
              BrokerVillageSelectionCubit,
              BrokerVillageSelectionState,
              ({bool isSelected, bool canToggle})
            >(
              key: ValueKey(village.id),
              selector: (state) =>
                  (isSelected: state.isSelected(village), canToggle: state.canToggle(village)),
              builder: (context, selection) => BrokerVillageCard(
                village: village,
                isSelected: selection.isSelected,
                onTap: selection.canToggle ? () => cubit.toggleVillage(village) : null,
              ),
            );
          },
        );
      },
    );
  }
}
