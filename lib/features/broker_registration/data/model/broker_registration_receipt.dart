import 'package:equatable/equatable.dart';

class BrokerRegistrationReceipt extends Equatable {
  const BrokerRegistrationReceipt({required this.referenceNumber, required this.submittedAt});

  factory BrokerRegistrationReceipt.issue({required DateTime submittedAt}) {
    return BrokerRegistrationReceipt(
      referenceNumber: '$_referencePrefix${submittedAt.millisecondsSinceEpoch}',
      submittedAt: submittedAt,
    );
  }

  static const _referencePrefix = 'GO-BROKER-';

  final String referenceNumber;
  final DateTime submittedAt;

  @override
  List<Object?> get props => [referenceNumber, submittedAt];
}
