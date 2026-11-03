import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../images/app_images.dart';
import '../../theme/app_sizes.dart';
import '../../theme/app_text_styles.dart';
import '../../theme/extensions/theme_extensions.dart';
import '../../utils/country_code_methods.dart';

class CountryCodePrefix extends StatelessWidget {
  const CountryCodePrefix({
    super.key,
    required this.country,
    required this.onSelect,
    this.height = 48,
    this.borderWidth = 1.6,
    this.dividerColor,
  });

  final Country country;
  final ValueChanged<Country> onSelect;
  final double height;
  final double borderWidth;
  final Color? dividerColor;

  static const _minWidth = 75.0;
  static const _maxWidth = 110.0;
  static const _chevronSlot = 20.0;
  static const _dividerHeight = 24.0;
  static const _startPadding = 18.0;
  static const _inputGap = 15.0;
  static const _radius = BorderRadiusDirectional.horizontal(start: Radius.circular(9));

  @override
  Widget build(BuildContext context) {
    final colors = context.customColors;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(width: borderWidth),
        ClipRRect(
          borderRadius: _radius,
          child: Material(
            color: colors.textFormFill,
            child: InkWell(
              onTap: () => CountryCodeMethods.pickCountry(context: context, onSelect: onSelect),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minWidth: _minWidth,
                  maxWidth: _maxWidth,
                  minHeight: height,
                  maxHeight: height,
                ),
                child: Padding(
                  padding: const EdgeInsetsDirectional.only(start: _startPadding),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Flexible(
                        child: Text(
                          '+${country.phoneCode}',
                          textDirection: TextDirection.ltr,
                          maxLines: 1,
                          style: AppTextStyles.sSemiBold.copyWith(color: colors.textSecondary),
                        ),
                      ),
                      AppSpacing.gapH5,
                      SizedBox(
                        width: _chevronSlot,
                        child: Center(
                          child: SvgPicture.asset(
                            AppImages.assetsSvgChevronDown,
                            colorFilter: ColorFilter.mode(colors.textSecondary, BlendMode.srcIn),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
        SizedBox(
          height: _dividerHeight,
          child: VerticalDivider(width: 1, thickness: 1, color: dividerColor ?? colors.border),
        ),
        const SizedBox(width: _inputGap),
      ],
    );
  }
}
