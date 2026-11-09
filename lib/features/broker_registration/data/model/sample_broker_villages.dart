import 'broker_village.dart';

const sampleBrokerVillages = [
  BrokerVillage(
    id: 'green-valley',
    name: 'Green Valley',
    area: 'New Cairo',
    governorate: 'Cairo',
    status: BrokerVillageStatus.available,
  ),
  BrokerVillage(
    id: 'palm-village',
    name: 'Palm Village',
    area: '6th of October',
    governorate: 'Giza',
    status: BrokerVillageStatus.available,
  ),
  BrokerVillage(
    id: 'garden-village',
    name: 'Garden Village',
    area: 'Sheikh Zayed',
    governorate: 'Giza',
    status: BrokerVillageStatus.available,
  ),
  BrokerVillage(
    id: 'marina-village',
    name: 'Marina Village',
    area: 'North Coast',
    governorate: 'Matrouh',
    status: BrokerVillageStatus.unavailable,
  ),
  BrokerVillage(
    id: 'sunset-residence',
    name: 'Sunset Residence',
    area: 'New Cairo',
    governorate: 'Cairo',
    status: BrokerVillageStatus.alreadyAssigned,
  ),
];
