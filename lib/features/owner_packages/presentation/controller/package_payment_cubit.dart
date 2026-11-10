import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/model/payment_method.dart';

class PackagePaymentCubit extends Cubit<PaymentMethod?> {
  PackagePaymentCubit() : super(null);

  void selectMethod(PaymentMethod method) {
    if (method == state) return;
    emit(method);
  }
}
