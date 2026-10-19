import 'package:country_picker/country_picker.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/model/gender.dart';
import '../../data/model/id_type.dart';

part 'individual_info_state.dart';

class IndividualInfoCubit extends Cubit<IndividualInfoState> {
  IndividualInfoCubit() : super(const IndividualInfoState());

  void selectIdType(IdType idType) => emit(state.copyWith(idType: idType));

  void selectNationality(Country nationality) => emit(state.copyWith(nationality: nationality));

  void selectDateOfBirth(DateTime dateOfBirth) => emit(state.copyWith(dateOfBirth: dateOfBirth));

  void selectGender(Gender gender) => emit(state.copyWith(gender: gender));
}
