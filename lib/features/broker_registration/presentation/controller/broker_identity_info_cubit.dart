import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/enum/id_type.dart';

part 'broker_identity_info_state.dart';

class BrokerIdentityInfoCubit extends Cubit<BrokerIdentityInfoState> {
  BrokerIdentityInfoCubit() : super(const BrokerIdentityInfoState());

  void selectIdType(IdType idType) {
    if (idType == state.idType) return;
    emit(BrokerIdentityInfoState(idType: idType));
  }

  void idNumberChanged(String idNumber) => emit(state.copyWith(idNumber: idNumber));
}
