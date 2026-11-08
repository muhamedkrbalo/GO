import 'dart:ui' as ui;

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../../core/locale/app_locale_key.dart';
import '../../../../../core/theme/app_text_styles.dart';
import '../../../../../core/theme/extensions/theme_extensions.dart';
import '../../../data/model/broker_registration_receipt.dart';

class BrokerSubmissionDetailsCard extends StatelessWidget {
  const BrokerSubmissionDetailsCard({super.key, required this.receipt});

  final BrokerRegistrationReceipt receipt;

  static final _dateFormat = DateFormat('dd MMM yyyy');
  static const _radius = BorderRadius.all(Radius.circular(13));

  @override
  Widget build(BuildContext context) {
    final colors = context.customColors;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: _radius,
        border: Border.all(color: colors.subtleBorder),
      ),
      child: Column(
        children: [
          _DetailRow(
            label: AppLocaleKey.registrationReferenceNumber.tr(),
            value: receipt.referenceNumber,
            textDirection: ui.TextDirection.ltr,
          ),
          _DetailRow(
            label: AppLocaleKey.submissionDate.tr(),
            value: _dateFormat.format(receipt.submittedAt),
          ),
          _DetailRow(
            label: AppLocaleKey.status.tr(),
            value: AppLocaleKey.pendingApproval.tr(),
            valueColor: colors.goldLink,
            hasDivider: false,
          ),
        ],
      ),
    );
  }
}

class _DetailRow extends StatelessWidget {
  const _DetailRow({
    required this.label,
    required this.value,
    this.valueColor,
    this.textDirection,
    this.hasDivider = true,
  });

  final String label;
  final String value;
  final Color? valueColor;
  final ui.TextDirection? textDirection;
  final bool hasDivider;

  static const _padding = EdgeInsetsDirectional.symmetric(horizontal: 14, vertical: 12);
  static const _gap = SizedBox(width: 12);
  static const _textHeight = 1.5;

  @override
  Widget build(BuildContext context) {
    final colors = context.customColors;

    return DecoratedBox(
      decoration: BoxDecoration(
        border: hasDivider ? Border(bottom: BorderSide(color: colors.subtleBorder)) : null,
      ),
      child: Padding(
        padding: _padding,
        child: Row(
          children: [
            Expanded(
              child: Text(
                label,
                style: AppTextStyles.xxxxxsMedium.copyWith(
                  color: colors.hint,
                  fontWeight: FontWeight.w400,
                  height: _textHeight,
                ),
              ),
            ),
            _gap,
            Text(
              value,
              textDirection: textDirection,
              style: AppTextStyles.xxxxsBold.copyWith(
                color: valueColor ?? colors.textPrimary,
                height: _textHeight,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
