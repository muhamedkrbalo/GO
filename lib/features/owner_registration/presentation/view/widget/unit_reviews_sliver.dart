import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/locale/app_locale_key.dart';
import '../../../../../core/theme/app_text_styles.dart';
import '../../../../../core/theme/extensions/theme_extensions.dart';
import '../../controller/registration_status_cubit.dart';
import 'unit_review_card.dart';

class UnitReviewsSliver extends StatelessWidget {
  const UnitReviewsSliver({super.key});

  static const _cardGap = SizedBox(height: 11);
  static const _emptyPadding = EdgeInsetsDirectional.symmetric(vertical: 24);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegistrationStatusCubit, RegistrationStatusState>(
      buildWhen: (previous, current) =>
          !listEquals(previous.visibleReviews, current.visibleReviews),
      builder: (context, state) {
        final reviews = state.visibleReviews;
        if (reviews.isEmpty) {
          return SliverToBoxAdapter(
            child: Padding(
              padding: _emptyPadding,
              child: Text(
                AppLocaleKey.noUnitsInFilter.tr(),
                textAlign: TextAlign.center,
                style: AppTextStyles.xsMedium.copyWith(color: context.customColors.textMuted),
              ),
            ),
          );
        }
        return SliverList.separated(
          itemCount: reviews.length,
          separatorBuilder: (_, _) => _cardGap,
          itemBuilder: (context, index) =>
              UnitReviewCard(key: ValueKey(reviews[index].unit.id), review: reviews[index]),
        );
      },
    );
  }
}

class UnitReviewsHeader extends StatelessWidget {
  const UnitReviewsHeader({super.key});

  static const _textHeight = 1.5;

  @override
  Widget build(BuildContext context) {
    final colors = context.customColors;

    return Row(
      children: [
        Expanded(
          child: Text(
            AppLocaleKey.unitReviews.tr(),
            style: AppTextStyles.xs13Bold.copyWith(color: colors.textPrimary, height: _textHeight),
          ),
        ),
        BlocSelector<RegistrationStatusCubit, RegistrationStatusState, int>(
          selector: (state) => state.visibleReviews.length,
          builder: (context, count) => Text(
            AppLocaleKey.unitsCount.tr(args: ['$count']),
            style: AppTextStyles.xxxxxsMedium.copyWith(
              color: colors.textMuted,
              fontWeight: FontWeight.w600,
              height: _textHeight,
            ),
          ),
        ),
      ],
    );
  }
}
