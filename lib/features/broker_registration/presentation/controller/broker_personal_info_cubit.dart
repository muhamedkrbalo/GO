import 'package:country_picker/country_picker.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'broker_personal_info_state.dart';

class BrokerPersonalInfoCubit extends Cubit<BrokerPersonalInfoState> {
  BrokerPersonalInfoCubit()
    : super(BrokerPersonalInfoState(phoneCountry: Country.parse(_defaultPhoneCountryCode)));

  static const _defaultPhoneCountryCode = 'EG';

  void fullNameChanged(String fullName) => emit(state.copyWith(fullName: fullName));

  void selectNationality(Country nationality) => emit(state.copyWith(nationality: nationality));

  void selectPhoneCountry(Country country) => emit(state.copyWith(phoneCountry: country));

  void mobileNumberChanged(String mobileNumber) => emit(state.copyWith(mobileNumber: mobileNumber));

  void emailChanged(String email) => emit(state.copyWith(email: email));
}
