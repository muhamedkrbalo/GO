import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/model/verification_method.dart';

class VerifyAccountCubit extends Cubit<VerificationMethod> {
  VerifyAccountCubit() : super(VerificationMethod.sms);

  void selectMethod(VerificationMethod method) => emit(method);
}
