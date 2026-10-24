import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/model/owner_type.dart';

class OwnerTypeCubit extends Cubit<OwnerType?> {
  OwnerTypeCubit() : super(null);

  void selectType(OwnerType type) => emit(type);
}
