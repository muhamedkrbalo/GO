import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hr_erb/core/theme/app_sizes.dart';
import '../extension/context_extension.dart';
import '../locale/app_locale_key.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_hr_erb/core/theme/app_text_styles.dart';
import 'package:flutter_hr_erb/core/theme/extensions/theme_extensions.dart';
import 'package:flutter_hr_erb/core/theme/app_colors.dart';

class CountryCodeMethods {
  static Country getByCode(String code) {
    return CountryParser.parsePhoneCode(code);
  }

  static void pickCountry({
    required void Function(Country) onSelect,
    required BuildContext context,
    bool showPhoneCode = true,
  }) {
    showCountryPicker(
      context: context,
      showPhoneCode: showPhoneCode,
      favorite: [
        'AE',
        // 'SA',
        // 'QA',
        // 'BH',
        // 'KW',
        // 'OM',
        // 'YE',
        // 'LB',
        // 'SY',
        // 'PS',
        // 'JO',
        // 'IQ',
        // 'EG',
        // 'SD',
        // 'SO',
        // 'DJ',
        // 'KM',
        // 'LY',
        // 'DZ',
        // 'TN',
        // 'MA',
        // 'MR',
      ],
      countryListTheme: CountryListThemeData(
        flagSize: 25,
        backgroundColor: context.customColors.surface,
        textStyle: AppTextStyles.sRegular.copyWith(color: context.customColors.textPrimary),
        bottomSheetHeight: context.height() * 0.8,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(15)),
        inputDecoration: InputDecoration(
          hintText: AppLocaleKey.search.tr(),
          hintStyle: AppTextStyles.sRegular.copyWith(color: context.customColors.hint),
          fillColor: context.customColors.textFormFill,
          filled: true,
          border: OutlineInputBorder(
            borderRadius: AppRadius.brL,
            borderSide: BorderSide(color: context.customColors.textFormBorder),
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: AppRadius.brL,
            borderSide: BorderSide(color: context.customColors.textFormBorder),
          ),
          focusedBorder: const OutlineInputBorder(
            borderRadius: AppRadius.brL,
            borderSide: BorderSide(color: AppColors.primary),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: AppRadius.brL,
            borderSide: BorderSide(color: context.customColors.textFormBorder),
          ),
          contentPadding: AppPadding.v5h20,
        ),
      ),
      onSelect: onSelect,
    );
  }
}
