import 'package:equatable/equatable.dart';

import '../../../../core/locale/app_locale_key.dart';

enum DocumentType {
  identity(AppLocaleKey.nationalIdOrPassport, isRequired: true),
  supporting(AppLocaleKey.additionalSupportingDocument, isRequired: false),
  ownershipContract(AppLocaleKey.ownershipContract, isRequired: true);

  const DocumentType(this.titleKey, {required this.isRequired});

  final String titleKey;
  final bool isRequired;
}

class DocumentSlot extends Equatable {
  const DocumentSlot(this.type, {this.unitId});

  final DocumentType type;
  final String? unitId;

  @override
  List<Object?> get props => [type, unitId];
}

class UploadedDocument extends Equatable {
  const UploadedDocument({required this.name, required this.sizeInBytes, this.path});

  final String name;
  final int sizeInBytes;
  final String? path;

  String get sizeLabel {
    const kb = 1024;
    if (sizeInBytes < kb * kb) return '${(sizeInBytes / kb).ceil()} KB';
    return '${(sizeInBytes / (kb * kb)).toStringAsFixed(1)} MB';
  }

  @override
  List<Object?> get props => [name, sizeInBytes, path];
}
