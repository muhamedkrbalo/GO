import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/locale/app_locale_key.dart';
import '../../../../../core/routes/routes_name.dart';
import '../../../../../core/theme/app_shadows.dart';
import '../../../../../core/theme/app_text_styles.dart';
import '../../../../../core/theme/extensions/theme_extensions.dart';

class RegistrationStickyFooter extends StatelessWidget {
  const RegistrationStickyFooter({
    super.key,
    required this.child,
    this.topPadding = 12,
    this.showSaveAndExit = true,
  });

  final Widget child;
  final double topPadding;
  final bool showSaveAndExit;

  static const _horizontalPadding = 20.0;
  static const _bottomPadding = 4.0;
  static const _bottomPaddingWithoutExit = 12.0;
  static const _backgroundOpacity = 0.97;
  static const _exitMinSize = Size(0, 44);
  static const _textHeight = 1.5;

  @override
  Widget build(BuildContext context) {
    final colors = context.customColors;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: colors.surface.withValues(alpha: _backgroundOpacity),
        border: Border(top: BorderSide(color: colors.subtleBorder)),
        boxShadow: AppShadows.stickyFooter,
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: EdgeInsetsDirectional.fromSTEB(
            _horizontalPadding,
            topPadding,
            _horizontalPadding,
            showSaveAndExit ? _bottomPadding : _bottomPaddingWithoutExit,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              child,
              if (showSaveAndExit)
                Align(
                  alignment: AlignmentDirectional.centerStart,
                  child: TextButton(
                    onPressed: () => context.goNamed(RouteNames.welcome),
                    style: TextButton.styleFrom(
                      minimumSize: _exitMinSize,
                      padding: EdgeInsets.zero,
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      foregroundColor: colors.textPrimary,
                      textStyle: AppTextStyles.xsBold.copyWith(height: _textHeight),
                    ),
                    child: Text(AppLocaleKey.saveAndExit.tr()),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
