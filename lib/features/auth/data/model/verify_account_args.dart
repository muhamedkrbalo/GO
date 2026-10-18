import 'package:equatable/equatable.dart';

import '../../../../core/extension/string_extension.dart';
import 'verification_method.dart';

class VerifyAccountArgs extends Equatable {
  const VerifyAccountArgs({required this.phoneCode, required this.phone, required this.email});

  final String phoneCode;
  final String phone;
  final String email;

  String maskedDestination(VerificationMethod method) => switch (method) {
    VerificationMethod.sms => '+$phoneCode ${phone.maskPhone()}',
    VerificationMethod.email => email.maskEmail(),
  };

  @override
  List<Object> get props => [phoneCode, phone, email];
}
