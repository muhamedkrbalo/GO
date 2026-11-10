import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/images/app_images.dart';
import '../../../../../core/locale/app_locale_key.dart';
import '../../../../../core/routes/routes_name.dart';
import '../../../../../core/theme/app_shadows.dart';
import '../../../../../core/theme/app_sizes.dart';
import '../../../../../core/theme/app_text_styles.dart';
import '../../../../../core/theme/extensions/theme_extensions.dart';
import 'owner_home_section_heading.dart';

class OwnerQuickActions extends StatelessWidget {
  const OwnerQuickActions({super.key, required this.hasRequiredCorrections});

  final bool hasRequiredCorrections;

  static const _gap = 9.0;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        OwnerHomeSectionHeading(
          eyebrow: AppLocaleKey.shortcuts.tr(),
          title: AppLocaleKey.quickActions.tr(),
        ),
        AppSpacing.gapV12,
        IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: _QuickActionTile(
                  icon: AppImages.assetsSvgNavUnits,
                  label: AppLocaleKey.viewMyUnits.tr(),
                  onTap: () => context.goNamed(RouteNames.ownerUnits),
                ),
              ),
              const SizedBox(width: _gap),
              Expanded(
                child: _QuickActionTile(
                  icon: AppImages.assetsSvgAlertTriangle,
                  label: AppLocaleKey.completeRequiredCorrections.tr(),
                  isEnabled: hasRequiredCorrections,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: _gap),
        IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: _QuickActionTile(
                  icon: AppImages.assetsSvgNavSubscription,
                  label: AppLocaleKey.manageSubscription.tr(),
                  onTap: () => context.goNamed(RouteNames.ownerSubscription),
                ),
              ),
              const SizedBox(width: _gap),
              Expanded(
                child: _QuickActionTile(
                  icon: AppImages.assetsSvgDocument,
                  label: AppLocaleKey.viewApplicationDetails.tr(),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _QuickActionTile extends StatelessWidget {
  const _QuickActionTile({
    required this.icon,
    required this.label,
    this.onTap,
    this.isEnabled = true,
  });

  final String icon;
  final String label;
  final VoidCallback? onTap;
  final bool isEnabled;

  static const _minHeight = 78.0;
  static const _padding = EdgeInsetsDirectional.fromSTEB(12, 19, 12, 12);
  static const _radius = BorderRadius.all(Radius.circular(12));
  static const _borderWidth = 1.5;
  static const _iconSize = 18.0;
  static const _labelGap = SizedBox(height: 8);
  static const _labelHeight = 1.35;

  @override
  Widget build(BuildContext context) {
    final colors = context.customColors;
    final iconColor = isEnabled ? colors.oceanAccent : colors.hint;
    final labelColor = isEnabled ? colors.textPrimary : colors.hint;

    return Semantics(
      button: true,
      enabled: isEnabled && onTap != null,
      label: label,
      excludeSemantics: true,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: isEnabled ? colors.surface : colors.canvas,
          borderRadius: _radius,
          border: Border.all(color: colors.subtleBorder, width: _borderWidth),
          boxShadow: AppShadows.roleCard,
        ),
        child: Material(
          type: MaterialType.transparency,
          child: InkWell(
            onTap: isEnabled ? onTap : null,
            borderRadius: _radius,
            child: ConstrainedBox(
              constraints: const BoxConstraints(minHeight: _minHeight),
              child: Padding(
                padding: _padding,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SvgPicture.asset(
                      icon,
                      width: _iconSize,
                      height: _iconSize,
                      colorFilter: ColorFilter.mode(iconColor, BlendMode.srcIn),
                    ),
                    _labelGap,
                    Text(
                      label,
                      style: AppTextStyles.xxxxxsMedium.copyWith(
                        color: labelColor,
                        fontWeight: FontWeight.w800,
                        height: _labelHeight,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
