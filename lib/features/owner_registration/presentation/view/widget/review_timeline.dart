import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../../core/theme/app_text_styles.dart';
import '../../../../../core/theme/extensions/theme_extensions.dart';
import '../../../data/model/unit_review.dart';

class ReviewTimeline extends StatelessWidget {
  const ReviewTimeline({super.key, required this.events});

  final List<ReviewTimelineEvent> events;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        for (var index = 0; index < events.length; index++)
          _TimelineItem(event: events[index], hasConnector: index < events.length - 1),
      ],
    );
  }
}

class _TimelineItem extends StatelessWidget {
  const _TimelineItem({required this.event, required this.hasConnector});

  final ReviewTimelineEvent event;
  final bool hasConnector;

  static final _dateFormat = DateFormat('dd MMM yyyy');
  static const _minHeight = 48.0;
  static const _railWidth = 18.0;
  static const _dotSize = 11.0;
  static const _dotBorderWidth = 2.0;
  static const _dotTop = 3.0;
  static const _connectorWidth = 1.0;
  static const _connectorStart = 5.0;
  static const _connectorTop = 14.0;
  static const _gap = SizedBox(width: 10);
  static const _lineGap = SizedBox(height: 3);
  static const _textHeight = 1.5;

  @override
  Widget build(BuildContext context) {
    final colors = context.customColors;
    final isComplete = event.isComplete;

    return ConstrainedBox(
      constraints: const BoxConstraints(minHeight: _minHeight),
      child: Stack(
        children: [
          if (hasConnector)
            PositionedDirectional(
              start: _connectorStart,
              top: _connectorTop,
              bottom: 0,
              width: _connectorWidth,
              child: ColoredBox(color: colors.subtleBorder),
            ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: _railWidth,
                child: Padding(
                  padding: const EdgeInsetsDirectional.only(top: _dotTop),
                  child: Align(
                    alignment: AlignmentDirectional.topStart,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: isComplete ? colors.cyanAccent : colors.surface,
                        border: Border.all(
                          color: isComplete ? colors.oceanAccent : colors.border,
                          width: _dotBorderWidth,
                        ),
                      ),
                      child: const SizedBox.square(dimension: _dotSize),
                    ),
                  ),
                ),
              ),
              _gap,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      event.titleKey.tr(),
                      style: AppTextStyles.xxxxsBold.copyWith(
                        color: colors.formLabel,
                        height: _textHeight,
                      ),
                    ),
                    _lineGap,
                    Text(
                      _dateFormat.format(event.date),
                      style: AppTextStyles.xxxxxsMedium.copyWith(
                        color: colors.hint,
                        fontWeight: FontWeight.w400,
                        height: _textHeight,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
