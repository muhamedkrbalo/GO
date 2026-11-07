import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../../core/images/app_images.dart';
import '../../../../../core/locale/app_locale_key.dart';
import '../../../../../core/theme/app_sizes.dart';
import '../../../../../core/theme/app_text_styles.dart';
import '../../../../../core/theme/extensions/theme_extensions.dart';
import '../../controller/registration_review_cubit.dart';

class SubmissionCheckCard extends StatelessWidget {
  const SubmissionCheckCard({super.key, required this.review});

  final RegistrationReviewState review;

  static const _padding = EdgeInsetsDirectional.all(15);
  static const _radius = BorderRadius.all(Radius.circular(13));
  static const _badgePadding = EdgeInsetsDirectional.symmetric(horizontal: 7, vertical: 4);
  static const _textHeight = 1.5;

  @override
  Widget build(BuildContext context) {
    final colors = context.customColors;
    final isReady = review.isReadyToSubmit;

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
            Row(
              children: [
                Expanded(
                  child: Text(
                    AppLocaleKey.submissionCheck.tr(),
                    style: AppTextStyles.xsBold.copyWith(
                      color: colors.textPrimary,
                      height: _textHeight,
                    ),
                  ),
                ),
                AppSpacing.gapH8,
                DecoratedBox(
                  decoration: BoxDecoration(
                    color: isReady ? colors.successSurface : colors.goldSurface,
                    borderRadius: AppRadius.brCircle,
                  ),
                  child: Padding(
                    padding: _badgePadding,
                    child: Text(
                      isReady ? AppLocaleKey.readyToSubmit.tr() : AppLocaleKey.actionRequired.tr(),
                      style: AppTextStyles.xxxxxsMedium.copyWith(
                        color: isReady ? colors.success : colors.goldLink,
                        fontWeight: FontWeight.w700,
                        height: _textHeight,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            AppSpacing.gapV10,
            _CheckRow(
              label: AppLocaleKey.requiredInformationCompleted.tr(),
              isDone: review.isOwnerInfoComplete,
            ),
            _CheckRow(
              label: AppLocaleKey.requiredDocumentsUploaded.tr(),
              isDone: review.areRequiredDocumentsUploaded,
            ),
            _CheckRow(
              label: AppLocaleKey.allUnitsHaveOwnership.tr(),
              isDone: review.allUnitsHaveOwnership,
            ),
          ],
        ),
      ),
    );
  }
}

class _CheckRow extends StatelessWidget {
  const _CheckRow({required this.label, required this.isDone});

  final String label;
  final bool isDone;

  static const _minHeight = 34.0;
  static const _circleSize = 17.0;
  static const _iconSize = 10.0;
  static const _textHeight = 1.5;

  @override
  Widget build(BuildContext context) {
    final colors = context.customColors;

    return Semantics(
      checked: isDone,
      child: DecoratedBox(
        decoration: BoxDecoration(
          border: Border(top: BorderSide(color: colors.selectedSurface)),
        ),
        child: ConstrainedBox(
          constraints: const BoxConstraints(minHeight: _minHeight),
          child: Row(
            children: [
              DecoratedBox(
                decoration: BoxDecoration(
                  color: isDone ? colors.success : null,
                  shape: BoxShape.circle,
                  border: isDone ? null : Border.all(color: colors.border),
                ),
                child: SizedBox.square(
                  dimension: _circleSize,
                  child: isDone
                      ? Center(
                          child: SvgPicture.asset(
                            AppImages.assetsSvgCheck,
                            width: _iconSize,
                            height: _iconSize,
                            colorFilter: ColorFilter.mode(colors.onPrimary, BlendMode.srcIn),
                          ),
                        )
                      : null,
                ),
              ),
              AppSpacing.gapH8,
              Expanded(
                child: Text(
                  label,
                  style: AppTextStyles.xxxxxsMedium.copyWith(
                    color: colors.formLabel,
                    fontWeight: FontWeight.w600,
                    height: _textHeight,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
