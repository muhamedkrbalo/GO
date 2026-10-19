import 'package:country_picker/country_picker.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterState(country: Country.parse(_defaultCountryCode)));

  static const _defaultCountryCode = 'EG';

  void selectCountry(Country country) => emit(state.copyWith(country: country));

 
}
