import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/enum/cubit_state/cubit_status.dart';
import '../../data/repository/splash_repository.dart';

part 'splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  SplashCubit(this._repository) : super(const SplashState());

  // ignore: unused_field — used once splash calls the API.
  final SplashRepository _repository;
}
