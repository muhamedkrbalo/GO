import 'package:equatable/equatable.dart';

import 'owner_package.dart';

class PackageChange extends Equatable {
  const PackageChange({required this.current, required this.target});

  final OwnerPackage current;
  final OwnerPackage target;

  double get additionalAmountDue {
    final difference = target.price - current.price;
    return difference > 0 ? difference : 0;
  }

  @override
  List<Object?> get props => [current, target];
}
