import 'package:country_picker/country_picker.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/enum/id_type.dart';
import '../../../../core/models/uploaded_document.dart';

part 'broker_representative_state.dart';

class BrokerRepresentativeCubit extends Cubit<BrokerRepresentativeState> {
  BrokerRepresentativeCubit({BrokerRepresentativeState? initialState})
    : super(
        initialState ??
            BrokerRepresentativeState(phoneCountry: Country.parse(_defaultPhoneCountryCode)),
      );

  static const _defaultPhoneCountryCode = 'EG';

  void fullNameChanged(String fullName) => emit(state.copyWith(fullName: fullName));

  void selectIdType(IdType idType) {
    if (idType == state.idType) return;
    emit(state.copyWith(idType: idType, idNumber: ''));
  }

  void idNumberChanged(String idNumber) => emit(state.copyWith(idNumber: idNumber));

  void selectPhoneCountry(Country country) => emit(state.copyWith(phoneCountry: country));

  void mobileNumberChanged(String mobileNumber) => emit(state.copyWith(mobileNumber: mobileNumber));

  void emailChanged(String email) => emit(state.copyWith(email: email));

  void attachProof(UploadedDocument document) {
    if (document == state.proofOfAuthorization) return;
    emit(state.copyWith(proofOfAuthorization: document));
  }

  void removeProof() {
    if (state.proofOfAuthorization == null) return;
    emit(state.withoutProof());
  }
}
