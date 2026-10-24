import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/images/app_images.dart';
import '../../../../../core/locale/app_locale_key.dart';
import '../../../../../core/theme/app_text_styles.dart';
import '../../../../../core/theme/extensions/theme_extensions.dart';

class AuthStepHeader extends StatelessWidget {
  const AuthStepHeader({super.key, required this.step, required this.stepCount});

  final int step;
  final int stepCount;

  static const _minHeight = 72.0;
  static const _padding = EdgeInsetsDirectional.fromSTEB(24, 14, 24, 8);
  static const _backgroundOpacity = 0.96;
  static const _backSlotWidth = 34.0;
  static const _backTapSize = 44.0;
  static const _backOffset = -10.0;
  static const _backIconSize = 21.0;
  static const _stepLetterSpacing = 1.4;
  static const _stepHeight = 1.5;

  @override
  Widget build(BuildContext context) {
    final colors = context.customColors;

    return Container(
      constraints: const BoxConstraints(minHeight: _minHeight),
      padding: _padding,
      color: colors.canvas.withValues(alpha: _backgroundOpacity),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: _backSlotWidth,
            height: _backTapSize,
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                PositionedDirectional(
                  start: _backOffset,
                  top: 0,
                  child: Semantics(
                    button: true,
                    label: MaterialLocalizations.of(context).backButtonTooltip,
                    child: InkResponse(
                      onTap: context.pop,
                      radius: _backTapSize / 2,
                      child: SizedBox.square(
                        dimension: _backTapSize,
                        child: Center(
                          child: Transform.flip(
                            flipX: true,
                            child: SvgPicture.asset(
                              AppImages.assetsSvgArrowForward,
                              width: _backIconSize,
                              height: _backIconSize,
                              matchTextDirection: true,
                              colorFilter: ColorFilter.mode(colors.accentText, BlendMode.srcIn),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Text(
            AppLocaleKey.stepXOfY.tr(args: ['$step', '$stepCount']).toUpperCase(),
            style: AppTextStyles.xxxsBold.copyWith(
              color: colors.stepLabel,
              letterSpacing: _stepLetterSpacing,
              height: _stepHeight,
            ),
          ),
        ],
      ),
    );
  }
}
