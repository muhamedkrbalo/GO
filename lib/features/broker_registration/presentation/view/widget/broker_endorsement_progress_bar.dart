import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../../core/locale/app_locale_key.dart';
import '../../../../../core/theme/app_sizes.dart';
import '../../../../../core/theme/extensions/theme_extensions.dart';

class BrokerEndorsementProgressBar extends StatelessWidget {
  const BrokerEndorsementProgressBar({super.key, required this.received, required this.required});

  final int received;
  final int required;

  static const _segmentHeight = 5.0;
  static const _gap = SizedBox(width: 7);

  @override
  Widget build(BuildContext context) {
    final colors = context.customColors;

    return Semantics(
      label: AppLocaleKey.progress.tr(),
      value: AppLocaleKey.countOfTotal.tr(args: ['$received', '$required']),
      child: ExcludeSemantics(
        child: SizedBox(
          height: _segmentHeight,
          child: Row(
            children: [
              for (var index = 0; index < required; index++) ...[
                if (index > 0) _gap,
                Expanded(
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: index < received ? colors.progressComplete : colors.subtleBorder,
                      borderRadius: AppRadius.brCircle,
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
