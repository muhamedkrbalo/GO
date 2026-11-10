import 'owner_package.dart';

const _sampleTermsSummary = 'Sample annual commercial terms for prototype demonstration.';

const sampleOwnerPackages = [
  OwnerPackage(
    id: 'owner-essential',
    name: 'Owner Essential',
    price: 1200,
    durationMonths: 12,
    features: ['Owner workspace', 'Unit management', 'Business user access'],
    excludedFeatures: ['Advanced portfolio reporting'],
    unitsLimit: 5,
    businessUsersLimit: 2,
    activationFee: 300,
    termsSummary: _sampleTermsSummary,
  ),
  OwnerPackage(
    id: 'owner-growth',
    name: 'Owner Growth',
    price: 2400,
    durationMonths: 12,
    features: ['Owner workspace', 'Expanded unit management', 'Additional business users'],
    unitsLimit: 15,
    businessUsersLimit: 5,
    activationFee: 300,
    termsSummary: _sampleTermsSummary,
  ),
];
