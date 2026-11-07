part of 'owner_registration_draft_cubit.dart';

class OwnerRegistrationDraft extends Equatable {
  const OwnerRegistrationDraft({
    this.ownerType,
    this.individual,
    this.company,
    this.address,
    this.units = const [],
    this.ownership = const {},
    this.documents = const {},
  });

  final OwnerType? ownerType;
  final IndividualInfoState? individual;
  final CompanyInfoState? company;
  final OwnerAddressState? address;
  final List<OwnerUnit> units;
  final Map<String, UnitOwnership> ownership;
  final Map<DocumentSlot, UploadedDocument> documents;

  Set<String> get unitIds => {for (final unit in units) unit.id};

  OwnerRegistrationDraft copyWith({
    IndividualInfoState? individual,
    CompanyInfoState? company,
    OwnerAddressState? address,
    List<OwnerUnit>? units,
    Map<String, UnitOwnership>? ownership,
    Map<DocumentSlot, UploadedDocument>? documents,
  }) {
    return OwnerRegistrationDraft(
      ownerType: ownerType,
      individual: individual ?? this.individual,
      company: company ?? this.company,
      address: address ?? this.address,
      units: units ?? this.units,
      ownership: ownership ?? this.ownership,
      documents: documents ?? this.documents,
    );
  }

  @override
  List<Object?> get props => [ownerType, individual, company, address, units, ownership, documents];
}
