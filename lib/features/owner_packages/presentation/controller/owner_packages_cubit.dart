import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/model/owner_package.dart';

part 'owner_packages_state.dart';

class OwnerPackagesCubit extends Cubit<OwnerPackagesState> {
  OwnerPackagesCubit(List<OwnerPackage> packages) : super(OwnerPackagesState(packages: packages));

  void selectPackage(String packageId) {
    if (packageId == state.selectedId) return;
    if (!state.packages.any((package) => package.id == packageId)) return;
    emit(state.copyWith(selectedId: packageId));
  }
}
