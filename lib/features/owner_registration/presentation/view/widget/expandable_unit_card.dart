import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../../core/custom_widgets/expanded_section/expanded_section.dart';
import '../../../../../core/images/app_images.dart';
import '../../../../../core/theme/app_sizes.dart';
import '../../../../../core/theme/app_text_styles.dart';
import '../../../../../core/theme/extensions/theme_extensions.dart';
import '../../../data/model/owner_unit.dart';

class ExpandableUnitCard extends StatefulWidget {
  const ExpandableUnitCard({
    super.key,
    required this.unit,
    required this.status,
    required this.child,
    this.bodyPadding = const EdgeInsets.all(16),
    this.initiallyExpanded = false,
  });

  final OwnerUnit unit;
  final Widget status;
  final Widget child;
  final EdgeInsetsGeometry bodyPadding;
  final bool initiallyExpanded;

  @override
  State<ExpandableUnitCard> createState() => _ExpandableUnitCardState();
}

class _ExpandableUnitCardState extends State<ExpandableUnitCard> {
  late bool _isExpanded = widget.initiallyExpanded;

  static const _duration = Duration(milliseconds: 200);
  static const _radius = BorderRadius.all(Radius.circular(12));
  static const _borderWidth = 1.6;
  static const _headerPadding = EdgeInsets.all(12);
  static const _headerMinHeight = 68.0;
  static const _chevronSize = 16.0;

  void _toggle() => setState(() => _isExpanded = !_isExpanded);

  @override
  Widget build(BuildContext context) {
    final colors = context.customColors;
    final unit = widget.unit;

    return AnimatedContainer(
      duration: _duration,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: _radius,
        border: Border.all(
          color: _isExpanded ? colors.primaryBorder : colors.subtleBorder,
          width: _borderWidth,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Material(
            type: MaterialType.transparency,
            child: InkWell(
              onTap: _toggle,
              child: ConstrainedBox(
                constraints: const BoxConstraints(minHeight: _headerMinHeight),
                child: Padding(
                  padding: _headerPadding,
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              unit.name,
                              style: AppTextStyles.xsBold.copyWith(
                                color: colors.textSecondary,
                                height: 1.3,
                              ),
                            ),
                            const SizedBox(height: AppSpacing.xxs2),
                            Text(
                              unit.location,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: AppTextStyles.xxxsRegular.copyWith(color: colors.textMuted),
                            ),
                          ],
                        ),
                      ),
                      AppSpacing.gapH8,
                      widget.status,
                      AppSpacing.gapH8,
                      AnimatedRotation(
                        turns: _isExpanded ? 0.5 : 0,
                        duration: _duration,
                        child: SvgPicture.asset(
                          AppImages.assetsSvgSelectArrow,
                          width: _chevronSize,
                          height: _chevronSize,
                          colorFilter: ColorFilter.mode(colors.textMuted, BlendMode.srcIn),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          ExpandedSection(
            expand: _isExpanded,
            child: DecoratedBox(
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(color: colors.subtleBorder, width: _borderWidth),
                ),
              ),
              child: Padding(padding: widget.bodyPadding, child: widget.child),
            ),
          ),
        ],
      ),
    );
  }
}
