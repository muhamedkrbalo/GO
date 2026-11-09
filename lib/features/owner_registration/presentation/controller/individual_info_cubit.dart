import 'package:country_picker/country_picker.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/enum/id_type.dart';

part 'individual_info_state.dart';

class IndividualInfoCubit extends Cubit<IndividualInfoState> {
  IndividualInfoCubit()
    : super(IndividualInfoState(phoneCountry: Country.parse(_defaultPhoneCountryCode)));

  static const _defaultPhoneCountryCode = 'EG';

  void fullNameChanged(String fullName) => emit(state.copyWith(fullName: fullName));

  void selectIdType(IdType idType) => emit(state.copyWith(idType: idType));

  void idNumberChanged(String idNumber) => emit(state.copyWith(idNumber: idNumber));

  void selectNationality(Country nationality) => emit(state.copyWith(nationality: nationality));

  void selectPhoneCountry(Country country) => emit(state.copyWith(phoneCountry: country));

  void mobileNumberChanged(String mobileNumber) => emit(state.copyWith(mobileNumber: mobileNumber));

  void emailChanged(String email) => emit(state.copyWith(email: email));
}
