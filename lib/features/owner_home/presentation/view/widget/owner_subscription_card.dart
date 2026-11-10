import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/custom_widgets/status_pill/review_status_pill.dart';
import '../../../../../core/images/app_images.dart';
import '../../../../../core/locale/app_locale_key.dart';
import '../../../../../core/routes/routes_name.dart';
import '../../../../../core/theme/app_text_styles.dart';
import '../../../../../core/theme/extensions/theme_extensions.dart';
import 'owner_home_card_link.dart';
import 'owner_home_section_card.dart';

class OwnerSubscriptionCard extends StatelessWidget {
  const OwnerSubscriptionCard({super.key, required this.hasActiveSubscription});

  final bool hasActiveSubscription;

  static const _tileSize = 38.0;
  static const _tileIconSize = 18.0;
  static const _tileRadius = BorderRadius.all(Radius.circular(10));
  static const _gap = SizedBox(width: 10);
  static const _labelGap = SizedBox(height: 3);
  static const _descriptionGap = SizedBox(height: 11);
  static const _textHeight = 1.5;

  @override
  Widget build(BuildContext context) {
    final colors = context.customColors;
    final (pillLabel, pillBackground, pillForeground) = hasActiveSubscription
        ? (AppLocaleKey.active, colors.successSurface, colors.success)
        : (AppLocaleKey.attention, colors.goldSurface, colors.goldLink);

    return OwnerHomeSectionCard(
      borderColor: colors.infoBorder,
      gradient: LinearGradient(
        begin: AlignmentDirectional.topStart,
        end: AlignmentDirectional.bottomEnd,
        colors: [colors.surface, colors.iconTileSurface],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              DecoratedBox(
                decoration: BoxDecoration(color: colors.textPrimary, borderRadius: _tileRadius),
                child: SizedBox.square(
                  dimension: _tileSize,
                  child: Center(
                    child: SvgPicture.asset(
                      AppImages.assetsSvgNavSubscription,
                      width: _tileIconSize,
                      height: _tileIconSize,
                      colorFilter: ColorFilter.mode(colors.onPrimary, BlendMode.srcIn),
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
                      AppLocaleKey.subscription.tr(),
                      style: AppTextStyles.xxxxxsMedium.copyWith(
                        color: colors.textMuted,
                        fontWeight: FontWeight.w400,
                        height: _textHeight,
                      ),
                    ),
                    _labelGap,
                    Text(
                      (hasActiveSubscription
                              ? AppLocaleKey.activeSubscriptionTitle
                              : AppLocaleKey.noActiveSubscription)
                          .tr(),
                      style: AppTextStyles.xxsBold.copyWith(
                        color: colors.textPrimary,
                        height: _textHeight,
                      ),
                    ),
                  ],
                ),
              ),
              _gap,
              ReviewStatusPill(
                label: pillLabel.tr(),
                background: pillBackground,
                foreground: pillForeground,
              ),
            ],
          ),
          _descriptionGap,
          Text(
            AppLocaleKey.subscriptionOptionsDescription.tr(),
            style: AppTextStyles.xxxxxsMedium.copyWith(
              color: colors.textMuted,
              fontWeight: FontWeight.w400,
              height: _textHeight,
            ),
          ),
          OwnerHomeCardLink(
            label: AppLocaleKey.viewSubscriptionOptions.tr(),
            onTap: () => context.pushNamed(RouteNames.ownerPackages),
          ),
        ],
      ),
    );
  }
}
