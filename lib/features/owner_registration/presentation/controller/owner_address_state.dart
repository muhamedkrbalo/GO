part of 'owner_address_cubit.dart';

class OwnerAddressState extends Equatable {
  const OwnerAddressState({
    this.country,
    this.governorate = '',
    this.city = '',
    this.addressLine1 = '',
    this.type = AddressType.residential,
    this.isPrimary = true,
  });

  final Country? country;
  final String governorate;
  final String city;
  final String addressLine1;
  final AddressType type;
  final bool isPrimary;

  bool get canEnterGovernorate => country != null;

  bool get canEnterCity => canEnterGovernorate && governorate.trim().isNotEmpty;

  bool get canContinue => country != null && addressLine1.trim().isNotEmpty;

  OwnerAddressState copyWith({
    Country? country,
    String? governorate,
    String? city,
    String? addressLine1,
    AddressType? type,
    bool? isPrimary,
  }) {
    return OwnerAddressState(
      country: country ?? this.country,
      governorate: governorate ?? this.governorate,
      city: city ?? this.city,
      addressLine1: addressLine1 ?? this.addressLine1,
      type: type ?? this.type,
      isPrimary: isPrimary ?? this.isPrimary,
    );
  }

  @override
  List<Object?> get props => [
    country?.countryCode,
    governorate,
    city,
    addressLine1,
    type,
    isPrimary,
  ];
}
