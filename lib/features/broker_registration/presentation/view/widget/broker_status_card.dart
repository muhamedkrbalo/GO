import 'dart:ui' as ui;

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/custom_widgets/status_pill/review_status_pill.dart';
import '../../../../../core/locale/app_locale_key.dart';
import '../../../../../core/theme/app_text_styles.dart';
import '../../../../../core/theme/extensions/custom_colors_extension.dart';
import '../../../../../core/theme/extensions/theme_extensions.dart';
import '../../../data/model/broker_review_status.dart';
import '../../controller/broker_registration_status_cubit.dart';

extension BrokerReviewStatusTone on BrokerReviewStatus {
  (Color, Color) toneOf(CustomColors colors) => switch (this) {
    BrokerReviewStatus.pendingApproval => (colors.goldSurface, colors.goldLink),
    BrokerReviewStatus.correctionRequired => (colors.errorSurface, colors.error),
    BrokerReviewStatus.approved => (colors.successSurface, colors.success),
  };
}

class BrokerStatusCard extends StatelessWidget {
  const BrokerStatusCard({super.key});

  static final _dateFormat = DateFormat('dd MMM yyyy');
  static const _padding = EdgeInsetsDirectional.all(18);
  static const _radius = BorderRadius.all(Radius.circular(14));
  static const _messageGap = SizedBox(height: 12);
  static const _rowsGap = SizedBox(height: 15);
  static const _messageHeight = 1.5;

  @override
  Widget build(BuildContext context) {
    final colors = context.customColors;

    return BlocBuilder<BrokerRegistrationStatusCubit, BrokerRegistrationStatusState>(
      builder: (context, state) {
        final (background, foreground) = state.status.toneOf(colors);

        return DecoratedBox(
          decoration: BoxDecoration(
            color: colors.surface,
            borderRadius: _radius,
            border: Border.all(color: colors.subtleBorder),
          ),
          child: Padding(
            padding: _padding,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ReviewStatusPill(
                  label: state.status.labelKey.tr(),
                  background: background,
                  foreground: foreground,
                ),
                _messageGap,
                Text(
                  state.status.messageKey.tr(),
                  style: AppTextStyles.xsRegular.copyWith(
                    color: colors.formLabel,
                    height: _messageHeight,
                  ),
                ),
                _rowsGap,
                _StatusRow(
                  label: AppLocaleKey.registrationReference.tr(),
                  value: state.receipt.referenceNumber,
                  textDirection: ui.TextDirection.ltr,
                ),
                _StatusRow(
                  label: AppLocaleKey.submissionDate.tr(),
                  value: _dateFormat.format(state.receipt.submittedAt),
                ),
                _StatusRow(
                  label: AppLocaleKey.lastUpdated.tr(),
                  value: _dateFormat.format(state.lastUpdated),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _StatusRow extends StatelessWidget {
  const _StatusRow({required this.label, required this.value, this.textDirection});

  final String label;
  final String value;
  final ui.TextDirection? textDirection;

  static const _padding = EdgeInsetsDirectional.symmetric(vertical: 8);
  static const _gap = SizedBox(width: 12);
  static const _textHeight = 1.5;

  @override
  Widget build(BuildContext context) {
    final colors = context.customColors;

    return DecoratedBox(
      decoration: BoxDecoration(
        border: Border(top: BorderSide(color: colors.selectedSurface)),
      ),
      child: Padding(
        padding: _padding,
        child: Row(
          children: [
            Expanded(
              child: Text(
                label,
                style: AppTextStyles.xxxxxsMedium.copyWith(
                  color: colors.textMuted,
                  fontWeight: FontWeight.w400,
                  height: _textHeight,
                ),
              ),
            ),
            _gap,
            Text(
              value,
              textDirection: textDirection,
              style: AppTextStyles.xxxxxsMedium.copyWith(
                color: colors.textPrimary,
                fontWeight: FontWeight.w700,
                height: _textHeight,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
