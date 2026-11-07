import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../../core/custom_widgets/custom_form_field/country_code_prefix.dart';
import '../../../../../core/theme/extensions/theme_extensions.dart';
import 'registration_text_field.dart';

class RegistrationPhoneField extends StatelessWidget {
  const RegistrationPhoneField({
    super.key,
    required this.controller,
    required this.title,
    required this.hintText,
    required this.country,
    required this.onCountrySelect,
    this.helperText,
    this.validator,
    this.onChanged,
  });

  final TextEditingController controller;
  final String title;
  final String hintText;
  final Country country;
  final ValueChanged<Country> onCountrySelect;
  final String? helperText;
  final String? Function(String?)? validator;
  final ValueChanged<String>? onChanged;

  static const _prefixHeight = 50.0;
  static const _prefixBorderWidth = 1.0;

  @override
  Widget build(BuildContext context) {
    return RegistrationTextField(
      controller: controller,
      title: title,
      hintText: hintText,
      helperText: helperText,
      keyboardType: TextInputType.phone,
      onChanged: onChanged,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      validator: validator,
      prefixIcon: CountryCodePrefix(
        country: country,
        onSelect: onCountrySelect,
        height: _prefixHeight,
        borderWidth: _prefixBorderWidth,
        dividerColor: context.customColors.subtleBorder,
      ),
    );
  }
}
