import 'dart:ui' as ui;

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../../core/locale/app_locale_key.dart';
import '../../../../../core/theme/extensions/theme_extensions.dart';
import '../../../data/model/broker_registration_receipt.dart';
import 'broker_detail_row.dart';

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
          BrokerDetailRow(
            label: AppLocaleKey.registrationReferenceNumber.tr(),
            value: receipt.referenceNumber,
            textDirection: ui.TextDirection.ltr,
          ),
          BrokerDetailRow(
            label: AppLocaleKey.submissionDate.tr(),
            value: _dateFormat.format(receipt.submittedAt),
          ),
          BrokerDetailRow(
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
