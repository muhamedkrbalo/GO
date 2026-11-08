import 'package:equatable/equatable.dart';

import '../../../../core/locale/app_locale_key.dart';

export '../../../../core/models/uploaded_document.dart';

enum DocumentScope { owner, unit }

enum DocumentType {
  identity(AppLocaleKey.nationalIdOrIdentityDocument, scope: DocumentScope.owner, isRequired: true),
  additionalIdentity(
    AppLocaleKey.additionalIdentityDocument,
    scope: DocumentScope.owner,
    isRequired: false,
  ),
  ownershipContract(AppLocaleKey.ownershipContract, scope: DocumentScope.unit, isRequired: true),
  purchaseContract(AppLocaleKey.purchaseContract, scope: DocumentScope.unit, isRequired: false),
  allocationDocument(AppLocaleKey.allocationDocument, scope: DocumentScope.unit, isRequired: false),
  ownershipCertificate(
    AppLocaleKey.ownershipCertificate,
    scope: DocumentScope.unit,
    isRequired: false,
  ),
  powerOfAttorney(AppLocaleKey.powerOfAttorney, scope: DocumentScope.unit, isRequired: false);

  const DocumentType(this.titleKey, {required this.scope, required this.isRequired});

  final String titleKey;
  final DocumentScope scope;
  final bool isRequired;

  static const ownerTypes = [identity, additionalIdentity];

  static const unitTypes = [
    ownershipContract,
    purchaseContract,
    allocationDocument,
    ownershipCertificate,
    powerOfAttorney,
  ];
}

class DocumentSlot extends Equatable {
  const DocumentSlot(this.type, {this.unitId});

  final DocumentType type;
  final String? unitId;

  @override
  List<Object?> get props => [type, unitId];
}
