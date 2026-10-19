part of 'owner_address_cubit.dart';

class AddressEntry extends Equatable {
  const AddressEntry({required this.id, this.type, this.country});

  final int id;
  final AddressType? type;
  final Country? country;

  AddressEntry copyWith({AddressType? type, Country? country}) {
    return AddressEntry(id: id, type: type ?? this.type, country: country ?? this.country);
  }

  @override
  List<Object?> get props => [id, type, country?.countryCode];
}

class OwnerAddressState extends Equatable {
  const OwnerAddressState({this.addresses = const [AddressEntry(id: 0)], this.nextId = 1});

  final List<AddressEntry> addresses;
  final int nextId;

  List<int> get ids => [for (final address in addresses) address.id];

  AddressEntry? addressById(int id) {
    for (final address in addresses) {
      if (address.id == id) return address;
    }
    return null;
  }

  OwnerAddressState copyWith({List<AddressEntry>? addresses, int? nextId}) {
    return OwnerAddressState(addresses: addresses ?? this.addresses, nextId: nextId ?? this.nextId);
  }

  @override
  List<Object?> get props => [addresses, nextId];
}
