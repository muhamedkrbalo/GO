import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/locale/app_locale_key.dart';
import '../../../../../core/theme/app_sizes.dart';
import '../../../../../core/theme/app_text_styles.dart';
import '../../../../../core/theme/extensions/theme_extensions.dart';
import '../../../data/model/owner_unit.dart';
import '../../../data/model/unit_details_status.dart';
import '../../controller/ownership_details_cubit.dart';

class UnitTabsCard extends StatelessWidget {
  const UnitTabsCard({super.key});

  static const _padding = EdgeInsetsDirectional.all(14);
  static const _radius = BorderRadius.all(Radius.circular(13));
  static const _tabGap = 8.0;

  @override
  Widget build(BuildContext context) {
    final colors = context.customColors;
    final units = context.read<OwnershipDetailsCubit>().state.units;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: _radius,
        border: Border.all(color: colors.subtleBorder),
      ),
      child: Padding(
        padding: _padding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const _ActiveUnitHeader(),
            AppSpacing.gapV12,
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  for (var index = 0; index < units.length; index++)
                    Padding(
                      padding: EdgeInsetsDirectional.only(
                        end: index == units.length - 1 ? 0 : _tabGap,
                      ),
                      child: _UnitTab(index: index, unit: units[index]),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ActiveUnitHeader extends StatelessWidget {
  const _ActiveUnitHeader();

  static const _textHeight = 1.5;

  @override
  Widget build(BuildContext context) {
    final colors = context.customColors;

    return BlocSelector<
      OwnershipDetailsCubit,
      OwnershipDetailsState,
      (int, int, UnitDetailsStatus)
    >(
      selector: (state) =>
          (state.activeIndex, state.units.length, state.statusOf(state.activeUnit.id)),
      builder: (context, header) {
        final (index, count, status) = header;
        return Row(
          children: [
            Expanded(
              child: Text(
                AppLocaleKey.unitXOfY.tr(args: ['${index + 1}', '$count']),
                style: AppTextStyles.xxsBold.copyWith(
                  color: colors.textPrimary,
                  height: _textHeight,
                ),
              ),
            ),
            AppSpacing.gapH8,
            _StatusPill(status: status),
          ],
        );
      },
    );
  }
}

class _StatusPill extends StatelessWidget {
  const _StatusPill({required this.status});

  final UnitDetailsStatus status;

  static const _padding = EdgeInsetsDirectional.symmetric(horizontal: 7, vertical: 4);
  static const _textHeight = 1.5;

  @override
  Widget build(BuildContext context) {
    final colors = context.customColors;
    final (background, foreground) = switch (status) {
      UnitDetailsStatus.notStarted => (colors.primaryLight, colors.textMuted),
      UnitDetailsStatus.inProgress => (colors.goldSurface, colors.goldLink),
      UnitDetailsStatus.completed => (colors.successSurface, colors.success),
    };

    return DecoratedBox(
      decoration: BoxDecoration(color: background, borderRadius: AppRadius.brCircle),
      child: Padding(
        padding: _padding,
        child: Text(
          status.labelKey.tr(),
          style: AppTextStyles.xxxxxsMedium.copyWith(
            color: foreground,
            fontWeight: FontWeight.w700,
            height: _textHeight,
          ),
        ),
      ),
    );
  }
}

class _UnitTab extends StatelessWidget {
  const _UnitTab({required this.index, required this.unit});

  final int index;
  final OwnerUnit unit;

  static const _radius = BorderRadius.all(Radius.circular(9));
  static const _minHeight = 38.0;
  static const _padding = EdgeInsetsDirectional.symmetric(horizontal: 11);
  static const _dotSize = 7.0;
  static const _dotGap = SizedBox(width: 7);
  static const _textHeight = 1.5;
  static const _scrollDuration = Duration(milliseconds: 250);

  @override
  Widget build(BuildContext context) {
    final colors = context.customColors;

    return BlocListener<OwnershipDetailsCubit, OwnershipDetailsState>(
      listenWhen: (previous, current) =>
          previous.activeIndex != current.activeIndex && current.activeIndex == index,
      listener: (context, _) {
        final renderObject = context.findRenderObject();
        if (renderObject == null) return;
        Scrollable.of(
          context,
          axis: Axis.horizontal,
        ).position.ensureVisible(renderObject, alignment: 0.5, duration: _scrollDuration);
      },
      child: BlocSelector<OwnershipDetailsCubit, OwnershipDetailsState, (bool, UnitDetailsStatus)>(
        selector: (state) => (state.activeIndex == index, state.statusOf(unit.id)),
        builder: (context, tab) {
          final (isActive, status) = tab;
          final dotColor = switch (status) {
            UnitDetailsStatus.notStarted => colors.border,
            UnitDetailsStatus.inProgress => colors.accentBar,
            UnitDetailsStatus.completed => colors.success,
          };

          return Semantics(
            selected: isActive,
            button: true,
            child: Material(
              color: isActive ? colors.iconTileSurface : colors.canvas,
              clipBehavior: Clip.antiAlias,
              shape: RoundedRectangleBorder(
                borderRadius: _radius,
                side: BorderSide(color: isActive ? colors.oceanAccent : colors.subtleBorder),
              ),
              child: InkWell(
                onTap: () => context.read<OwnershipDetailsCubit>().selectUnit(index),
                child: ConstrainedBox(
                  constraints: const BoxConstraints(minHeight: _minHeight),
                  child: Padding(
                    padding: _padding,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        DecoratedBox(
                          decoration: BoxDecoration(color: dotColor, shape: BoxShape.circle),
                          child: const SizedBox.square(dimension: _dotSize),
                        ),
                        _dotGap,
                        Text(
                          unit.name,
                          style: AppTextStyles.xxxxsBold.copyWith(
                            color: isActive ? colors.textPrimary : colors.textMuted,
                            height: _textHeight,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
