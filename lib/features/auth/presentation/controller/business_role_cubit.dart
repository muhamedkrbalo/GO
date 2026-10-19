import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/model/business_role.dart';

class BusinessRoleCubit extends Cubit<BusinessRole?> {
  BusinessRoleCubit() : super(null);

  void selectRole(BusinessRole role) => emit(role);
}
