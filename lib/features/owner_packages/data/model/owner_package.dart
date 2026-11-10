import 'package:equatable/equatable.dart';

class OwnerPackage extends Equatable {
  const OwnerPackage({
    required this.id,
    required this.name,
    required this.price,
    required this.durationMonths,
    required this.features,
    required this.unitsLimit,
    required this.businessUsersLimit,
    this.excludedFeatures = const [],
    this.activationFee,
    this.termsSummary,
  });

  final String id;
  final String name;
  final double price;
  final int durationMonths;
  final List<String> features;
  final int unitsLimit;
  final int businessUsersLimit;
  final List<String> excludedFeatures;
  final double? activationFee;
  final String? termsSummary;

  @override
  List<Object?> get props => [
    id,
    name,
    price,
    durationMonths,
    features,
    unitsLimit,
    businessUsersLimit,
    excludedFeatures,
    activationFee,
    termsSummary,
  ];
}
