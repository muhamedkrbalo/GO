part of 'package_payment_cubit.dart';

class PackagePaymentState extends Equatable {
  const PackagePaymentState({this.method, this.reference = '', this.proof});

  final PaymentMethod? method;
  final String reference;
  final UploadedDocument? proof;

  bool get hasMethod => method != null;

  bool get canSubmit => hasMethod && reference.trim().isNotEmpty;

  PackagePaymentState copyWith({
    PaymentMethod? method,
    String? reference,
    UploadedDocument? proof,
    bool clearProof = false,
  }) {
    return PackagePaymentState(
      method: method ?? this.method,
      reference: reference ?? this.reference,
      proof: clearProof ? null : proof ?? this.proof,
    );
  }

  @override
  List<Object?> get props => [method, reference, proof];
}
