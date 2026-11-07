import 'package:country_picker/country_picker.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/model/legal_form.dart';

part 'company_info_state.dart';

class CompanyInfoCubit extends Cubit<CompanyInfoState> {
  CompanyInfoCubit()
    : super(CompanyInfoState(phoneCountry: Country.parse(_defaultPhoneCountryCode)));

  static const _defaultPhoneCountryCode = 'EG';

  void legalNameChanged(String legalName) => emit(state.copyWith(legalName: legalName));

  void registrationNumberChanged(String registrationNumber) =>
      emit(state.copyWith(registrationNumber: registrationNumber));

  void selectLegalForm(LegalForm legalForm) => emit(state.copyWith(legalForm: legalForm));

  void selectRegistrationCountry(Country country) =>
      emit(state.copyWith(registrationCountry: country));

  void selectPhoneCountry(Country country) => emit(state.copyWith(phoneCountry: country));

  void mobileNumberChanged(String mobileNumber) => emit(state.copyWith(mobileNumber: mobileNumber));

  void emailChanged(String email) => emit(state.copyWith(email: email));
}
