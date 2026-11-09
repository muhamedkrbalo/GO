part of 'broker_business_address_cubit.dart';

class BrokerBusinessAddressState extends Equatable {
  const BrokerBusinessAddressState({
    this.country,
    this.governorate = '',
    this.city = '',
    this.district = '',
    this.addressLine1 = '',
    this.addressLine2 = '',
    this.postalCode = '',
    this.type = AddressType.business,
    this.isPrimary = true,
  });

  final Country? country;
  final String governorate;
  final String city;
  final String district;
  final String addressLine1;
  final String addressLine2;
  final String postalCode;
  final AddressType type;
  final bool isPrimary;

  bool get canEnterGovernorate => country != null;

  bool get canEnterCity => canEnterGovernorate && governorate.trim().isNotEmpty;

  bool get canContinue =>
      country != null &&
      governorate.trim().isNotEmpty &&
      city.trim().isNotEmpty &&
      addressLine1.trim().isNotEmpty;

  BrokerBusinessAddressState copyWith({
    Country? country,
    String? governorate,
    String? city,
    String? district,
    String? addressLine1,
    String? addressLine2,
    String? postalCode,
    AddressType? type,
    bool? isPrimary,
  }) {
    return BrokerBusinessAddressState(
      country: country ?? this.country,
      governorate: governorate ?? this.governorate,
      city: city ?? this.city,
      district: district ?? this.district,
      addressLine1: addressLine1 ?? this.addressLine1,
      addressLine2: addressLine2 ?? this.addressLine2,
      postalCode: postalCode ?? this.postalCode,
      type: type ?? this.type,
      isPrimary: isPrimary ?? this.isPrimary,
    );
  }

  @override
  List<Object?> get props => [
    country?.countryCode,
    governorate,
    city,
    district,
    addressLine1,
    addressLine2,
    postalCode,
    type,
    isPrimary,
  ];
}
