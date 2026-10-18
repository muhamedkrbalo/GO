import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/cache/hive/hive_methods.dart';
import '../../data/model/onboarding_item.dart';

/// Holds the current onboarding page index.
class OnboardingCubit extends Cubit<int> {
  OnboardingCubit() : super(0);

  int get pageCount => OnboardingItem.items.length;

  bool get isLastPage => state == pageCount - 1;

  void pageChanged(int index) => emit(index);

  void complete() => HiveMethods.updateFirstTime();
}
