import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../../core/images/app_images.dart';
import '../../../../../core/theme/app_text_styles.dart';
import '../../../../../core/theme/extensions/theme_extensions.dart';

class UnitFilterDropdown extends StatelessWidget {
  const UnitFilterDropdown({
    super.key,
    required this.hint,
    required this.onTap,
    required this.onClear,
    this.value,
  });

  final String hint;
  final String? value;
  final VoidCallback onTap;
  final VoidCallback onClear;

  static const _height = 40.8;
  static const _padding = EdgeInsetsDirectional.only(start: 10.4, end: 4);
  static const _radius = BorderRadius.all(Radius.circular(10.4));
  static const _borderWidth = 1.6;
  static const _iconSize = 13.6;
  static const _clearIconSize = 14.0;
  static const _trailingSize = 24.0;

  @override
  Widget build(BuildContext context) {
    final colors = context.customColors;
    final hasValue = value != null;

    return Material(
      color: colors.surface,
      shape: RoundedRectangleBorder(
        borderRadius: _radius,
        side: BorderSide(
          color: hasValue ? colors.primary : colors.subtleBorder,
          width: _borderWidth,
        ),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: _radius,
        child: SizedBox(
          height: _height,
          child: Padding(
            padding: _padding,
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    value ?? hint,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyles.xxxsRegular.copyWith(
                      color: hasValue ? colors.textSecondary : colors.hint,
                    ),
                  ),
                ),
                SizedBox.square(
                  dimension: _trailingSize,
                  child: hasValue
                      ? InkResponse(
                          onTap: onClear,
                          radius: _trailingSize / 2,
                          child: Icon(
                            Icons.close_rounded,
                            size: _clearIconSize,
                            color: colors.textMuted,
                          ),
                        )
                      : Center(
                          child: SvgPicture.asset(
                            AppImages.assetsSvgSelectArrow,
                            width: _iconSize,
                            height: _iconSize,
                            colorFilter: ColorFilter.mode(colors.textMuted, BlendMode.srcIn),
                          ),
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
