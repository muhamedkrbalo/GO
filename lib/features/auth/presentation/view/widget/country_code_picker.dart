import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../../core/images/app_images.dart';
import '../../../../../core/theme/app_sizes.dart';
import '../../../../../core/theme/app_text_styles.dart';
import '../../../../../core/theme/extensions/theme_extensions.dart';
import '../../../../../core/utils/country_code_methods.dart';
import '../../controller/register_cubit.dart';

class CountryCodePicker extends StatelessWidget {
  const CountryCodePicker({super.key});

  static const _minWidth = 75.0;
  static const _maxWidth = 110.0;
  static const _chevronSlot = 20.0;
  static const _borderWidth = 1.6;
  static const _height = 48.0;
  static const _dividerHeight = 24.0;
  static const _startPadding = 18.0;
  static const _inputGap = 15.0;
  static const _radius = BorderRadiusDirectional.horizontal(start: Radius.circular(9));

  @override
  Widget build(BuildContext context) {
    final colors = context.customColors;
    final cubit = context.read<RegisterCubit>();
    final style = AppTextStyles.sSemiBold.copyWith(color: colors.textSecondary);

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(width: _borderWidth),
        ClipRRect(
          borderRadius: _radius,
          child: Material(
            color: colors.textFormFill,
            child: InkWell(
              onTap: () =>
                  CountryCodeMethods.pickCountry(context: context, onSelect: cubit.selectCountry),
              child: ConstrainedBox(
                constraints: const BoxConstraints(
                  minWidth: _minWidth,
                  maxWidth: _maxWidth,
                  minHeight: _height,
                  maxHeight: _height,
                ),
                child: Padding(
                  padding: const EdgeInsetsDirectional.only(start: _startPadding),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Flexible(
                        child: BlocSelector<RegisterCubit, RegisterState, Country>(
                          selector: (state) => state.country,
                          builder: (context, country) => Text(
                            '+${country.phoneCode}',
                            textDirection: TextDirection.ltr,
                            maxLines: 1,
                            style: style,
                          ),
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
          child: VerticalDivider(width: 1, thickness: 1, color: colors.border),
        ),
        const SizedBox(width: _inputGap),
      ],
    );
  }
}
