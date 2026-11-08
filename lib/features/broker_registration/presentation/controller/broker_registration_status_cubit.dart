import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/model/broker_registration_receipt.dart';
import '../../data/model/broker_review_status.dart';

part 'broker_registration_status_state.dart';

class BrokerRegistrationStatusCubit extends Cubit<BrokerRegistrationStatusState> {
  BrokerRegistrationStatusCubit({
    required BrokerRegistrationReceipt receipt,
    DateTime Function()? now,
  }) : _now = now ?? DateTime.now,
       super(
         BrokerRegistrationStatusState(
           receipt: receipt,
           status: BrokerReviewStatus.pendingApproval,
           lastUpdated: receipt.submittedAt,
         ),
       );

  final DateTime Function() _now;

  void previewStatus(BrokerReviewStatus status) {
    if (status == state.status) return;
    emit(state.copyWith(status: status, lastUpdated: _now()));
  }
}
