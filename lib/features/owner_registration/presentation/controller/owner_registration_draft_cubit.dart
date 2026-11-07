import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/model/owner_document.dart';
import '../../data/model/owner_type.dart';
import '../../data/model/owner_unit.dart';
import 'company_info_cubit.dart';
import 'individual_info_cubit.dart';
import 'owner_address_cubit.dart';
import 'ownership_details_cubit.dart';

part 'owner_registration_draft_state.dart';

class OwnerRegistrationDraftCubit extends Cubit<OwnerRegistrationDraft> {
  OwnerRegistrationDraftCubit() : super(const OwnerRegistrationDraft());

  void startRegistration(OwnerType ownerType) {
    if (state.ownerType == ownerType) return;
    emit(OwnerRegistrationDraft(ownerType: ownerType));
  }

  void saveIndividual(IndividualInfoState individual) {
    emit(state.copyWith(individual: individual));
  }

  void saveCompany(CompanyInfoState company) {
    emit(state.copyWith(company: company));
  }

  void saveAddress(OwnerAddressState address) {
    emit(state.copyWith(address: address));
  }

  void saveUnits(List<OwnerUnit> units) {
    final unitIds = {for (final unit in units) unit.id};
    emit(
      state.copyWith(
        units: List.unmodifiable(units),
        ownership: {
          for (final entry in state.ownership.entries)
            if (unitIds.contains(entry.key)) entry.key: entry.value,
        },
        documents: {
          for (final entry in state.documents.entries)
            if (entry.key.unitId == null || unitIds.contains(entry.key.unitId))
              entry.key: entry.value,
        },
      ),
    );
  }

  void saveOwnership(Map<String, UnitOwnership> ownership) {
    emit(state.copyWith(ownership: Map.unmodifiable(ownership)));
  }

  void saveDocuments(Map<DocumentSlot, UploadedDocument> documents) {
    emit(state.copyWith(documents: Map.unmodifiable(documents)));
  }

  void clear() => emit(const OwnerRegistrationDraft());
}
