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

  static const _minWidth = 106.0;
  static const _maxWidth = 150.0;
  static const _borderWidth = 1.6;
  static const _height = 48.0;
  static const _dividerHeight = 26.0;
  static const _radius = BorderRadiusDirectional.horizontal(start: Radius.circular(12.4));

  @override
  Widget build(BuildContext context) {
    final colors = context.customColors;
    final cubit = context.read<RegisterCubit>();
    final style = AppTextStyles.xsSemiBold.copyWith(color: colors.accentText);

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(width: _borderWidth),
        ClipRRect(
          borderRadius: _radius,
          child: Material(
            color: colors.surfaceWarm,
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
                  padding: const EdgeInsetsDirectional.only(
                    start: AppSpacing.l15,
                    end: AppSpacing.s8,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Flexible(
                        child: BlocSelector<RegisterCubit, RegisterState, Country>(
                          selector: (state) => state.country,
                          builder: (context, country) => Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Flexible(
                                child: Text(
                                  _countryName(context, country),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: style,
                                ),
                              ),
                              AppSpacing.gapH5,
                              Text(
                                '(+${country.phoneCode})',
                                textDirection: TextDirection.ltr,
                                style: style,
                              ),
                            ],
                          ),
                        ),
                      ),
                      AppSpacing.gapH5,
                      SvgPicture.asset(
                        AppImages.assetsSvgChevronDown,
                        colorFilter: ColorFilter.mode(colors.accentText, BlendMode.srcIn),
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
        AppSpacing.gapH16,
      ],
    );
  }

  String _countryName(BuildContext context, Country country) {
    return CountryLocalizations.of(context)?.countryName(countryCode: country.countryCode) ??
        country.name;
  }
}
