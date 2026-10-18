import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../../../core/custom_widgets/buttons/custom_button.dart';
import '../../../../../core/locale/app_locale_key.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_sizes.dart';
import '../../../../../core/theme/app_text_styles.dart';
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

  static const _dotSize = 7.0;
  static const _activeDotWidth = 26.0;
  static const _skipHeight = 44.0;

  @override
  Widget build(BuildContext context) {
    final colors = context.customColors;
    final cubit = context.read<OnboardingCubit>();

    return Padding(
      padding: AppPadding.h24b24,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SmoothPageIndicator(
            controller: controller,
            count: cubit.pageCount,
            effect: ExpandingDotsEffect(
              dotHeight: _dotSize,
              dotWidth: _dotSize,
              expansionFactor: _activeDotWidth / _dotSize,
              activeDotColor: AppColors.primary,
              dotColor: colors.border,
            ),
          ),
          AppSpacing.gapV24,
          BlocSelector<OnboardingCubit, int, bool>(
            selector: (_) => cubit.isLastPage,
            builder: (context, isLastPage) => Column(
              children: [
                CustomButton(
                  text: (isLastPage ? AppLocaleKey.getStarted : AppLocaleKey.next).tr(),
                  hasShadow: true,
                  onPressed: isLastPage ? onFinish : onNext,
                ),
                AppSpacing.gapV8,
                Visibility(
                  visible: !isLastPage,
                  maintainSize: true,
                  maintainAnimation: true,
                  maintainState: true,
                  child: TextButton(
                    onPressed: onFinish,
                    style: TextButton.styleFrom(
                      minimumSize: const Size(64, _skipHeight),
                      foregroundColor: colors.textMuted,
                      textStyle: AppTextStyles.sSemiBold,
                    ),
                    child: Text(AppLocaleKey.skip.tr()),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
