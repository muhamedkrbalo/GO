import 'package:equatable/equatable.dart';

import 'verification_method.dart';
import 'verify_account_args.dart';

class VerifyCodeArgs extends Equatable {
  const VerifyCodeArgs({required this.method, required this.account});

  final VerificationMethod method;
  final VerifyAccountArgs account;

  String get destination => account.destination(method);

  String get maskedDestination => account.maskedDestination(method);

  Map<String, dynamic> toJson() => {'method': method.name, 'destination': destination};

  @override
  List<Object> get props => [method, account];
}
