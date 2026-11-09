import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../../core/locale/app_locale_key.dart';
import '../../../../../core/theme/extensions/theme_extensions.dart';
import 'broker_detail_row.dart';

class BrokerVillageRequestsSummaryCard extends StatelessWidget {
  const BrokerVillageRequestsSummaryCard({super.key, required this.requestCount});

  final int requestCount;

  static const _radius = BorderRadius.all(Radius.circular(13));
  static const _borderWidth = 1.5;

  @override
  Widget build(BuildContext context) {
    final colors = context.customColors;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: _radius,
        border: Border.all(color: colors.subtleBorder, width: _borderWidth),
      ),
      child: Column(
        children: [
          BrokerDetailRow(label: AppLocaleKey.numberOfRequests.tr(), value: '$requestCount'),
          BrokerDetailRow(
            label: AppLocaleKey.status.tr(),
            value: AppLocaleKey.pendingProcessing.tr(),
            valueColor: colors.goldLink,
            hasDivider: false,
          ),
        ],
      ),
    );
  }
}
