part of 'broker_registration_status_cubit.dart';

class BrokerRegistrationStatusState extends Equatable {
  const BrokerRegistrationStatusState({
    required this.receipt,
    required this.status,
    required this.lastUpdated,
  });

  final BrokerRegistrationReceipt receipt;
  final BrokerReviewStatus status;
  final DateTime lastUpdated;

  bool get isApproved => status == BrokerReviewStatus.approved;

  List<BrokerReviewStatus> get previewOptions =>
      BrokerReviewStatus.values.where((option) => option != status).toList(growable: false);

  BrokerRegistrationStatusState copyWith({BrokerReviewStatus? status, DateTime? lastUpdated}) {
    return BrokerRegistrationStatusState(
      receipt: receipt,
      status: status ?? this.status,
      lastUpdated: lastUpdated ?? this.lastUpdated,
    );
  }

  @override
  List<Object?> get props => [receipt, status, lastUpdated];
}
