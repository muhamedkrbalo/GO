import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/custom_widgets/custom_form_field/country_code_prefix.dart';
import '../../controller/register_cubit.dart';

class CountryCodePicker extends StatelessWidget {
  const CountryCodePicker({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<RegisterCubit, RegisterState, Country>(
      selector: (state) => state.country,
      builder: (context, country) => CountryCodePrefix(
        country: country,
        onSelect: context.read<RegisterCubit>().selectCountry,
      ),
    );
  }
}
