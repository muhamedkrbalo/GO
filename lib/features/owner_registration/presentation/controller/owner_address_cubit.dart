import 'package:country_picker/country_picker.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/model/address_type.dart';

part 'owner_address_state.dart';

class OwnerAddressCubit extends Cubit<OwnerAddressState> {
  OwnerAddressCubit() : super(const OwnerAddressState());

  void selectCountry(Country country) {
    if (country.countryCode == state.country?.countryCode) return;
    emit(state.copyWith(country: country, governorate: '', city: ''));
  }

  void governorateChanged(String governorate) => emit(state.copyWith(governorate: governorate));

  void cityChanged(String city) => emit(state.copyWith(city: city));

  void districtChanged(String district) => emit(state.copyWith(district: district));

  void addressLine1Changed(String addressLine1) => emit(state.copyWith(addressLine1: addressLine1));

  void selectType(AddressType type) => emit(state.copyWith(type: type));

  void togglePrimary(bool isPrimary) => emit(state.copyWith(isPrimary: isPrimary));
}
