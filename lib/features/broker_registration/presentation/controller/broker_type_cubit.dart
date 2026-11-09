import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/model/broker_type.dart';

class BrokerTypeCubit extends Cubit<BrokerType?> {
  BrokerTypeCubit() : super(null);

  void selectType(BrokerType type) => emit(type);
}
