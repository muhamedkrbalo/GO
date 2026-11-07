import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../../core/locale/app_locale_key.dart';
import '../../../../../core/theme/app_text_styles.dart';
import '../../../../../core/theme/extensions/theme_extensions.dart';

class ReviewSectionCard extends StatefulWidget {
  const ReviewSectionCard({
    super.key,
    required this.number,
    required this.title,
    required this.onEdit,
    required this.child,
  });

  final int number;
  final String title;
  final VoidCallback onEdit;
  final Widget child;

  @override
  State<ReviewSectionCard> createState() => _ReviewSectionCardState();
}

class _ReviewSectionCardState extends State<ReviewSectionCard> {
  bool _isExpanded = true;

  static const _radius = BorderRadius.all(Radius.circular(13));
  static const _duration = Duration(milliseconds: 220);
  static const _bodyPadding = EdgeInsetsDirectional.fromSTEB(14, 4, 14, 14);

  void _toggle() => setState(() => _isExpanded = !_isExpanded);

  @override
  Widget build(BuildContext context) {
    final colors = context.customColors;

    return Material(
      color: colors.surface,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: _radius,
        side: BorderSide(color: colors.subtleBorder),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _ReviewSectionHeader(
            number: widget.number,
            title: widget.title,
            isExpanded: _isExpanded,
            onToggle: _toggle,
            onEdit: widget.onEdit,
          ),
          AnimatedSize(
            duration: _duration,
            curve: Curves.fastOutSlowIn,
            alignment: AlignmentDirectional.topCenter,
            child: _isExpanded
                ? DecoratedBox(
                    decoration: BoxDecoration(
                      border: Border(top: BorderSide(color: colors.subtleBorder)),
                    ),
                    child: Padding(padding: _bodyPadding, child: widget.child),
                  )
                : const SizedBox(width: double.infinity),
          ),
        ],
      ),
    );
  }
}

class _ReviewSectionHeader extends StatelessWidget {
  const _ReviewSectionHeader({
    required this.number,
    required this.title,
    required this.isExpanded,
    required this.onToggle,
    required this.onEdit,
  });

  final int number;
  final String title;
  final bool isExpanded;
  final VoidCallback onToggle;
  final VoidCallback onEdit;

  static const _minHeight = 58.0;
  static const _togglePadding = EdgeInsetsDirectional.fromSTEB(13, 9, 10, 9);
  static const _gap = SizedBox(width: 9);
  static const _ringSize = 28.0;
  static const _ringOpacity = 0.5;
  static const _iconSlot = 24.0;
  static const _iconSize = 16.0;
  static const _editMinHeight = 44.0;
  static const _editPadding = EdgeInsetsDirectional.symmetric(horizontal: 14);
  static const _textHeight = 1.5;

  @override
  Widget build(BuildContext context) {
    final colors = context.customColors;

    return ConstrainedBox(
      constraints: const BoxConstraints(minHeight: _minHeight),
      child: Row(
        children: [
          Expanded(
            child: Semantics(
              button: true,
              expanded: isExpanded,
              child: InkWell(
                onTap: onToggle,
                child: ConstrainedBox(
                  constraints: const BoxConstraints(minHeight: _minHeight),
                  child: Padding(
                    padding: _togglePadding,
                    child: Row(
                      children: [
                        DecoratedBox(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: colors.accentBar.withValues(alpha: _ringOpacity),
                            ),
                          ),
                          child: SizedBox.square(
                            dimension: _ringSize,
                            child: Center(
                              child: Text(
                                '$number'.padLeft(2, '0'),
                                style: AppTextStyles.xxxxxsMedium.copyWith(
                                  color: colors.stepLabel,
                                  fontWeight: FontWeight.w700,
                                  height: _textHeight,
                                ),
                              ),
                            ),
                          ),
                        ),
                        _gap,
                        Expanded(
                          child: Text(
                            title,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: AppTextStyles.xxsBold.copyWith(
                              color: colors.textSecondary,
                              height: _textHeight,
                            ),
                          ),
                        ),
                        _gap,
                        SizedBox.square(
                          dimension: _iconSlot,
                          child: Icon(
                            isExpanded ? Icons.remove_rounded : Icons.add_rounded,
                            size: _iconSize,
                            color: colors.oceanAccent,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          DecoratedBox(
            decoration: BoxDecoration(
              border: BorderDirectional(start: BorderSide(color: colors.subtleBorder)),
            ),
            child: Semantics(
              button: true,
              child: InkWell(
                onTap: onEdit,
                child: ConstrainedBox(
                  constraints: const BoxConstraints(minHeight: _editMinHeight),
                  child: Padding(
                    padding: _editPadding,
                    child: Center(
                      widthFactor: 1,
                      child: Text(
                        AppLocaleKey.edit.tr(),
                        style: AppTextStyles.xxxxsBold.copyWith(
                          color: colors.oceanAccent,
                          height: _textHeight,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
