import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/model/broker_type.dart';
import 'broker_business_address_cubit.dart';
import 'broker_identity_info_cubit.dart';
import 'broker_personal_info_cubit.dart';

part 'broker_registration_draft_state.dart';

class BrokerRegistrationDraftCubit extends Cubit<BrokerRegistrationDraft> {
  BrokerRegistrationDraftCubit() : super(const BrokerRegistrationDraft());

  void startRegistration(BrokerType brokerType) {
    if (state.brokerType == brokerType) return;
    emit(BrokerRegistrationDraft(brokerType: brokerType));
  }

  void savePersonalInfo(BrokerPersonalInfoState personalInfo) {
    emit(state.copyWith(personalInfo: personalInfo));
  }

  void saveIdentityInfo(BrokerIdentityInfoState identityInfo) {
    emit(state.copyWith(identityInfo: identityInfo));
  }

  void saveBusinessAddress(BrokerBusinessAddressState businessAddress) {
    emit(state.copyWith(businessAddress: businessAddress));
  }

  void clear() => emit(const BrokerRegistrationDraft());
}
