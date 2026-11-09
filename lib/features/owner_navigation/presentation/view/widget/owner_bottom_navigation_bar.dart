import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../../core/theme/app_shadows.dart';
import '../../../../../core/theme/app_text_styles.dart';
import '../../../../../core/theme/extensions/theme_extensions.dart';
import '../../../data/model/owner_navigation_tab.dart';

class OwnerBottomNavigationBar extends StatelessWidget {
  const OwnerBottomNavigationBar({
    super.key,
    required this.currentTab,
    required this.onTabSelected,
  });

  final OwnerNavigationTab currentTab;
  final ValueChanged<OwnerNavigationTab> onTabSelected;

  static const _padding = EdgeInsetsDirectional.fromSTEB(8, 7, 8, 13);
  static const _minHeight = 68.0;
  static const _borderWidth = 1.5;
  static const _backgroundOpacity = 0.98;

  @override
  Widget build(BuildContext context) {
    final colors = context.customColors;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: colors.surface.withValues(alpha: _backgroundOpacity),
        border: Border(
          top: BorderSide(color: colors.subtleBorder, width: _borderWidth),
        ),
        boxShadow: AppShadows.stickyFooter,
      ),
      child: SafeArea(
        top: false,
        child: ConstrainedBox(
          constraints: const BoxConstraints(minHeight: _minHeight),
          child: Padding(
            padding: _padding,
            child: Row(
              children: [
                for (final tab in OwnerNavigationTab.values)
                  Expanded(
                    child: _OwnerNavigationItem(
                      tab: tab,
                      isSelected: tab == currentTab,
                      onTap: () {
                        if (tab != currentTab) onTabSelected(tab);
                      },
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _OwnerNavigationItem extends StatelessWidget {
  const _OwnerNavigationItem({required this.tab, required this.isSelected, required this.onTap});

  final OwnerNavigationTab tab;
  final bool isSelected;
  final VoidCallback onTap;

  static const _iconSize = 19.0;
  static const _iconSlotHeight = 26.0;
  static const _labelGap = SizedBox(height: 3);
  static const _radius = BorderRadius.all(Radius.circular(10));
  static const _textHeight = 1.5;

  @override
  Widget build(BuildContext context) {
    final colors = context.customColors;
    final color = isSelected ? colors.oceanAccent : colors.hint;
    final label = tab.labelKey.tr();

    return Semantics(
      button: true,
      selected: isSelected,
      label: label,
      excludeSemantics: true,
      child: InkWell(
        onTap: onTap,
        borderRadius: _radius,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: _iconSlotHeight,
              child: Center(
                child: SvgPicture.asset(
                  tab.icon,
                  width: _iconSize,
                  height: _iconSize,
                  colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
                ),
              ),
            ),
            _labelGap,
            Text(
              label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: AppTextStyles.xxxxxsMedium.copyWith(
                color: color,
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
