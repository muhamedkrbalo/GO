import 'owner_package.dart';

const sampleOwnerPackages = [
  OwnerPackage(
    id: 'owner-essential',
    name: 'Owner Essential',
    price: 1200,
    durationMonths: 12,
    features: ['Owner workspace', 'Unit management', 'Business user access'],
    unitsLimit: 5,
    businessUsersLimit: 2,
  ),
  OwnerPackage(
    id: 'owner-growth',
    name: 'Owner Growth',
    price: 2400,
    durationMonths: 12,
    features: ['Owner workspace', 'Expanded unit management', 'Additional business users'],
    unitsLimit: 15,
    businessUsersLimit: 5,
  ),
];
