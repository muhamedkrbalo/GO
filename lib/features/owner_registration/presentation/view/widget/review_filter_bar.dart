import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/theme/app_sizes.dart';
import '../../../../../core/theme/app_text_styles.dart';
import '../../../../../core/theme/extensions/theme_extensions.dart';
import '../../../data/model/unit_review.dart';
import '../../controller/registration_status_cubit.dart';

class ReviewFilterBar extends StatelessWidget {
  const ReviewFilterBar({super.key});

  static const _padding = EdgeInsetsDirectional.symmetric(horizontal: 20);
  static const _chipGap = SizedBox(width: 7);

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<RegistrationStatusCubit>();

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: _padding,
      child: BlocSelector<RegistrationStatusCubit, RegistrationStatusState, ReviewFilter>(
        selector: (state) => state.filter,
        builder: (context, selected) => Row(
          children: [
            for (final filter in ReviewFilter.values) ...[
              if (filter != ReviewFilter.values.first) _chipGap,
              _FilterChip(
                label: filter.labelKey.tr(),
                isSelected: filter == selected,
                onTap: () => cubit.selectFilter(filter),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _FilterChip extends StatelessWidget {
  const _FilterChip({required this.label, required this.isSelected, required this.onTap});

  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  static const _minHeight = 36.0;
  static const _padding = EdgeInsetsDirectional.symmetric(horizontal: 12);
  static const _textHeight = 1.5;

  @override
  Widget build(BuildContext context) {
    final colors = context.customColors;

    return Semantics(
      selected: isSelected,
      button: true,
      child: Material(
        color: isSelected ? colors.textPrimary : colors.surface,
        shape: StadiumBorder(
          side: BorderSide(color: isSelected ? colors.textPrimary : colors.subtleBorder),
        ),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onTap,
          borderRadius: AppRadius.brCircle,
          child: ConstrainedBox(
            constraints: const BoxConstraints(minHeight: _minHeight),
            child: Padding(
              padding: _padding,
              child: Center(
                widthFactor: 1,
                child: Text(
                  label,
                  style: AppTextStyles.xxxxxsMedium.copyWith(
                    color: isSelected ? colors.onPrimary : colors.textMuted,
                    fontWeight: FontWeight.w700,
                    height: _textHeight,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
