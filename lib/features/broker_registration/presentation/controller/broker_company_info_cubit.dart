import 'package:country_picker/country_picker.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/enum/legal_form.dart';

part 'broker_company_info_state.dart';

class BrokerCompanyInfoCubit extends Cubit<BrokerCompanyInfoState> {
  BrokerCompanyInfoCubit({BrokerCompanyInfoState? initialState})
    : super(
        initialState ??
            BrokerCompanyInfoState(phoneCountry: Country.parse(_defaultPhoneCountryCode)),
      );

  static const _defaultPhoneCountryCode = 'EG';

  void legalNameChanged(String legalName) => emit(state.copyWith(legalName: legalName));

  void tradeNameChanged(String tradeName) => emit(state.copyWith(tradeName: tradeName));

  void registrationNumberChanged(String registrationNumber) =>
      emit(state.copyWith(registrationNumber: registrationNumber));

  void taxNumberChanged(String taxNumber) => emit(state.copyWith(taxNumber: taxNumber));

  void selectLegalForm(LegalForm legalForm) => emit(state.copyWith(legalForm: legalForm));

  void selectRegistrationDate(DateTime date) =>
      emit(state.copyWith(registrationDate: DateTime(date.year, date.month, date.day)));

  void selectRegistrationCountry(Country country) =>
      emit(state.copyWith(registrationCountry: country));

  void selectPhoneCountry(Country country) => emit(state.copyWith(phoneCountry: country));

  void mobileNumberChanged(String mobileNumber) => emit(state.copyWith(mobileNumber: mobileNumber));

  void emailChanged(String email) => emit(state.copyWith(email: email));
}
