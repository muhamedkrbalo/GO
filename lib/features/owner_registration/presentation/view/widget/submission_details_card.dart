import 'dart:ui' as ui;

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../../core/locale/app_locale_key.dart';
import '../../../../../core/theme/app_shadows.dart';
import '../../../../../core/theme/app_text_styles.dart';
import '../../../../../core/theme/extensions/theme_extensions.dart';
import '../../../data/model/registration_receipt.dart';

class SubmissionDetailsCard extends StatelessWidget {
  const SubmissionDetailsCard({super.key, required this.receipt});

  final RegistrationReceipt receipt;

  static final _dateFormat = DateFormat('dd MMM yyyy');
  static const _radius = BorderRadius.all(Radius.circular(14));
  static const _dotSize = 7.0;
  static const _dotGap = SizedBox(width: 6);

  @override
  Widget build(BuildContext context) {
    final colors = context.customColors;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: _radius,
        border: Border.all(color: colors.subtleBorder),
        boxShadow: AppShadows.roleCard,
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: _DetailCell(
                  label: AppLocaleKey.registrationReferenceNumber.tr(),
                  hasEndBorder: true,
                  hasBottomBorder: true,
                  child: _DetailValue(text: receipt.referenceNumber, isLtr: true),
                ),
              ),
              Expanded(
                child: _DetailCell(
                  label: AppLocaleKey.submissionDate.tr(),
                  hasBottomBorder: true,
                  child: _DetailValue(text: _dateFormat.format(receipt.submittedAt)),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: _DetailCell(
                  label: AppLocaleKey.totalSelectedUnits.tr(),
                  hasEndBorder: true,
                  child: _DetailValue(text: '${receipt.unitCount}'),
                ),
              ),
              Expanded(
                child: _DetailCell(
                  label: AppLocaleKey.overallStatus.tr(),
                  child: Row(
                    children: [
                      DecoratedBox(
                        decoration: BoxDecoration(color: colors.accentBar, shape: BoxShape.circle),
                        child: const SizedBox.square(dimension: _dotSize),
                      ),
                      _dotGap,
                      Flexible(
                        child: _DetailValue(
                          text: AppLocaleKey.pendingReview.tr(),
                          color: colors.goldLink,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _DetailCell extends StatelessWidget {
  const _DetailCell({
    required this.label,
    required this.child,
    this.hasEndBorder = false,
    this.hasBottomBorder = false,
  });

  final String label;
  final Widget child;
  final bool hasEndBorder;
  final bool hasBottomBorder;

  static const _minHeight = 70.0;
  static const _padding = EdgeInsetsDirectional.symmetric(horizontal: 12, vertical: 14);
  static const _gap = SizedBox(height: 5);
  static const _textHeight = 1.5;

  @override
  Widget build(BuildContext context) {
    final colors = context.customColors;
    final side = BorderSide(color: colors.subtleBorder);

    return DecoratedBox(
      decoration: BoxDecoration(
        border: BorderDirectional(
          end: hasEndBorder ? side : BorderSide.none,
          bottom: hasBottomBorder ? side : BorderSide.none,
        ),
      ),
      child: ConstrainedBox(
        constraints: const BoxConstraints(minHeight: _minHeight),
        child: Padding(
          padding: _padding,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: AppTextStyles.xxxxxsMedium.copyWith(
                  color: colors.hint,
                  fontWeight: FontWeight.w600,
                  height: _textHeight,
                ),
              ),
              _gap,
              child,
            ],
          ),
        ),
      ),
    );
  }
}

class _DetailValue extends StatelessWidget {
  const _DetailValue({required this.text, this.color, this.isLtr = false});

  final String text;
  final Color? color;
  final bool isLtr;

  static const _textHeight = 1.5;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      textDirection: isLtr ? ui.TextDirection.ltr : null,
      style: AppTextStyles.xxxsBold.copyWith(
        color: color ?? context.customColors.textPrimary,
        height: _textHeight,
      ),
    );
  }
}
