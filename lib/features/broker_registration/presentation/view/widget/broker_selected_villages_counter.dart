import 'dart:ui' as ui;

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/locale/app_locale_key.dart';
import '../../../../../core/theme/app_text_styles.dart';
import '../../../../../core/theme/extensions/theme_extensions.dart';
import '../../controller/broker_village_selection_cubit.dart';

class BrokerSelectedVillagesCounter extends StatelessWidget {
  const BrokerSelectedVillagesCounter({super.key});

  static const _padding = EdgeInsetsDirectional.symmetric(horizontal: 12, vertical: 10);
  static const _radius = BorderRadius.all(Radius.circular(9));
  static const _textHeight = 1.5;

  @override
  Widget build(BuildContext context) {
    final colors = context.customColors;
    final maxSelection = context.read<BrokerVillageSelectionCubit>().state.maxSelection;

    return DecoratedBox(
      decoration: BoxDecoration(color: colors.iconTileSurface, borderRadius: _radius),
      child: Padding(
        padding: _padding,
        child: Row(
          children: [
            Expanded(
              child: Text(
                AppLocaleKey.selectedVillages.tr(),
                style: AppTextStyles.xxxxsRegular.copyWith(
                  color: colors.textMuted,
                  height: _textHeight,
                ),
              ),
            ),
            BlocSelector<BrokerVillageSelectionCubit, BrokerVillageSelectionState, int>(
              selector: (state) => state.selectedCount,
              builder: (context, count) => Text(
                AppLocaleKey.selectedOfMax.tr(args: ['$count', '$maxSelection']),
                textDirection: ui.TextDirection.ltr,
                style: AppTextStyles.xxxxsBold.copyWith(
                  color: colors.textPrimary,
                  height: _textHeight,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
