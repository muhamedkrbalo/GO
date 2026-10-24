import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../../../core/custom_widgets/buttons/arrow_pill_button.dart';
import '../../../../../core/locale/app_locale_key.dart';
import '../../../../../core/theme/extensions/theme_extensions.dart';
import '../../controller/onboarding_cubit.dart';

class OnboardingBottomBar extends StatelessWidget {
  const OnboardingBottomBar({
    super.key,
    required this.controller,
    required this.onNext,
    required this.onFinish,
  });

  final PageController controller;
  final VoidCallback onNext;
  final VoidCallback onFinish;

  static const _padding = EdgeInsetsDirectional.fromSTEB(24, 0, 24, 30);
  static const _dotSize = 6.0;
  static const _activeDotWidth = 28.0;
  static const _dotSpacing = 7.0;
  static const _buttonWidth = 172.0;

  @override
  Widget build(BuildContext context) {
    final colors = context.customColors;
    final cubit = context.read<OnboardingCubit>();

    return Padding(
      padding: _padding,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SmoothPageIndicator(
            controller: controller,
            count: cubit.pageCount,
            textDirection: Directionality.of(context),
            effect: ExpandingDotsEffect(
              dotHeight: _dotSize,
              dotWidth: _dotSize,
              spacing: _dotSpacing,
              expansionFactor: _activeDotWidth / _dotSize,
              activeDotColor: colors.indicatorActive,
              dotColor: colors.lightGrey,
            ),
          ),
          BlocSelector<OnboardingCubit, int, bool>(
            selector: (_) => cubit.isLastPage,
            builder: (context, isLastPage) => ArrowPillButton(
              width: _buttonWidth,
              text: (isLastPage ? AppLocaleKey.getStarted : AppLocaleKey.continue_).tr(),
              onPressed: isLastPage ? onFinish : onNext,
            ),
          ),
        ],
      ),
    );
  }
}
