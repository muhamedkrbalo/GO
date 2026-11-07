import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/custom_widgets/buttons/header_back_button.dart';
import '../../../../../core/locale/app_locale_key.dart';
import '../../../../../core/theme/app_sizes.dart';
import '../../../../../core/theme/app_text_styles.dart';
import '../../../../../core/theme/extensions/theme_extensions.dart';
import '../../controller/registration_status_cubit.dart';

class RegistrationStatusHeader extends StatelessWidget {
  const RegistrationStatusHeader({super.key});

  static const _height = 72.0;
  static const _padding = EdgeInsetsDirectional.only(start: 22, end: 20);
  static const _backgroundOpacity = 0.96;
  static const _textHeight = 1.5;

  @override
  Widget build(BuildContext context) {
    final colors = context.customColors;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: colors.surface.withValues(alpha: _backgroundOpacity),
        border: Border(bottom: BorderSide(color: colors.subtleBorder)),
      ),
      child: SafeArea(
        bottom: false,
        child: SizedBox(
          height: _height,
          child: Padding(
            padding: _padding,
            child: NavigationToolbar(
              leading: const HeaderBackButton(),
              middle: Text(
                AppLocaleKey.myOwnerRegistration.tr(),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: AppTextStyles.sBold.copyWith(color: colors.textPrimary, height: _textHeight),
              ),
              trailing: BlocSelector<RegistrationStatusCubit, RegistrationStatusState, int>(
                selector: (state) => state.updateCount,
                builder: (context, count) => _UpdatesIndicator(count: count),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _UpdatesIndicator extends StatelessWidget {
  const _UpdatesIndicator({required this.count});

  final int count;

  static const _size = 32.0;
  static const _ringSize = 10.0;
  static const _ringWidth = 1.5;
  static const _badgeMinSize = 17.0;
  static const _badgeOffset = -4.0;
  static const _badgeStart = 17.0;
  static const _badgeBorderWidth = 2.0;
  static const _badgePadding = EdgeInsetsDirectional.symmetric(horizontal: 4);
  static const _textHeight = 1.3;

  @override
  Widget build(BuildContext context) {
    final colors = context.customColors;

    return Semantics(
      label: AppLocaleKey.notifications.tr(),
      value: '$count',
      child: SizedBox.square(
        dimension: _size,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            DecoratedBox(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: colors.subtleBorder),
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [colors.surface, colors.canvas],
                ),
              ),
              child: Center(
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: colors.oceanAccent, width: _ringWidth),
                  ),
                  child: const SizedBox.square(dimension: _ringSize),
                ),
              ),
            ),
            if (count > 0)
              PositionedDirectional(
                start: _badgeStart,
                top: _badgeOffset,
                child: Container(
                  constraints: const BoxConstraints(
                    minWidth: _badgeMinSize,
                    minHeight: _badgeMinSize,
                  ),
                  padding: _badgePadding,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: colors.error,
                    borderRadius: AppRadius.brCircle,
                    border: Border.all(color: colors.surface, width: _badgeBorderWidth),
                  ),
                  child: Text(
                    '$count',
                    style: AppTextStyles.xxxxxsMedium.copyWith(
                      color: colors.onPrimary,
                      fontWeight: FontWeight.w800,
                      height: _textHeight,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
