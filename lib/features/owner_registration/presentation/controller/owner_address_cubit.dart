import 'package:country_picker/country_picker.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/model/address_type.dart';

part 'owner_address_state.dart';

class OwnerAddressCubit extends Cubit<OwnerAddressState> {
  OwnerAddressCubit() : super(const OwnerAddressState());

  void addAddress() {
    emit(
      state.copyWith(
        addresses: [
          ...state.addresses,
          AddressEntry(id: state.nextId),
        ],
        nextId: state.nextId + 1,
      ),
    );
  }

  void removeAddress(int id) {
    if (state.addresses.length == 1) return;
    emit(state.copyWith(addresses: [...state.addresses.where((address) => address.id != id)]));
  }

  void selectType(int id, AddressType type) =>
      _update(id, (address) => address.copyWith(type: type));

  void selectCountry(int id, Country country) {
    _update(id, (address) => address.copyWith(country: country));
  }

  void _update(int id, AddressEntry Function(AddressEntry address) change) {
    emit(
      state.copyWith(
        addresses: [
          for (final address in state.addresses) address.id == id ? change(address) : address,
        ],
      ),
    );
  }
}
