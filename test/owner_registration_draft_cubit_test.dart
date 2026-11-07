import 'package:country_picker/country_picker.dart';
import 'package:flutter_hr_erb/features/owner_registration/data/model/id_type.dart';
import 'package:flutter_hr_erb/features/owner_registration/data/model/owner_document.dart';
import 'package:flutter_hr_erb/features/owner_registration/data/model/owner_type.dart';
import 'package:flutter_hr_erb/features/owner_registration/data/model/ownership_type.dart';
import 'package:flutter_hr_erb/features/owner_registration/data/model/sample_units.dart';
import 'package:flutter_hr_erb/features/owner_registration/presentation/controller/individual_info_cubit.dart';
import 'package:flutter_hr_erb/features/owner_registration/presentation/controller/owner_address_cubit.dart';
import 'package:flutter_hr_erb/features/owner_registration/presentation/controller/owner_documents_cubit.dart';
import 'package:flutter_hr_erb/features/owner_registration/presentation/controller/owner_registration_draft_cubit.dart';
import 'package:flutter_hr_erb/features/owner_registration/presentation/controller/ownership_details_cubit.dart';
import 'package:flutter_hr_erb/features/owner_registration/presentation/controller/registration_review_cubit.dart';
import 'package:flutter_hr_erb/features/owner_registration/presentation/controller/unit_selection_cubit.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final units = [sampleUnits[0], sampleUnits[3]];
  const file = UploadedDocument(name: 'doc.pdf', sizeInBytes: 1024);
  late OwnerRegistrationDraftCubit cubit;

  IndividualInfoState individual() => IndividualInfoState(
    phoneCountry: Country.parse('EG'),
    fullName: 'Nada',
    idType: IdType.nationalId,
    idNumber: '30103030104604',
  );

  OwnerAddressState address() =>
      OwnerAddressState(country: Country.parse('EG'), addressLine1: '24 Ibrahim Khalil');

  Map<DocumentSlot, UploadedDocument> requiredDocuments() => {
    const DocumentSlot(DocumentType.identity): file,
    for (final unit in units) DocumentSlot(DocumentType.ownershipContract, unitId: unit.id): file,
  };

  Map<String, UnitOwnership> completeOwnership() => {
    for (final unit in units) unit.id: const UnitOwnership(type: OwnershipType.sole),
  };

  void fillCompleteDraft() {
    cubit
      ..startRegistration(OwnerType.individual)
      ..saveIndividual(individual())
      ..saveAddress(address())
      ..saveUnits(units)
      ..saveOwnership(completeOwnership())
      ..saveDocuments(requiredDocuments());
  }

  setUp(() => cubit = OwnerRegistrationDraftCubit());

  tearDown(() => cubit.close());

  group('draft', () {
    test('starting with the same owner type keeps the draft, a new type resets it', () {
      cubit
        ..startRegistration(OwnerType.individual)
        ..saveIndividual(individual())
        ..startRegistration(OwnerType.individual);
      expect(cubit.state.individual, isNotNull);

      cubit.startRegistration(OwnerType.company);
      expect(cubit.state.ownerType, OwnerType.company);
      expect(cubit.state.individual, isNull);
    });

    test('saving fewer units drops ownership and documents of removed units only', () {
      fillCompleteDraft();
      cubit.saveUnits([units[0]]);

      expect(cubit.state.ownership.keys, [units[0].id]);
      expect(cubit.state.documents.containsKey(const DocumentSlot(DocumentType.identity)), isTrue);
      expect(cubit.state.documents.keys.where((slot) => slot.unitId == units[1].id), isEmpty);
    });

    test('clear empties everything', () {
      fillCompleteDraft();
      cubit.clear();

      expect(cubit.state, const OwnerRegistrationDraft());
    });
  });

  group('review', () {
    test('a complete draft is ready but needs confirmation to submit', () {
      fillCompleteDraft();
      final review = RegistrationReviewCubit(cubit.state);
      addTearDown(review.close);

      expect(review.state.isOwnerInfoComplete, isTrue);
      expect(review.state.areRequiredDocumentsUploaded, isTrue);
      expect(review.state.allUnitsHaveOwnership, isTrue);
      expect(review.state.canSubmit, isFalse);

      review.setConfirmed(true);
      expect(review.state.canSubmit, isTrue);
    });

    test('a missing contract or ownership type blocks submission even when confirmed', () {
      fillCompleteDraft();
      cubit
        ..saveDocuments({const DocumentSlot(DocumentType.identity): file})
        ..saveOwnership({units[0].id: const UnitOwnership(type: OwnershipType.joint)});
      final review = RegistrationReviewCubit(cubit.state)..setConfirmed(true);
      addTearDown(review.close);

      expect(review.state.areRequiredDocumentsUploaded, isFalse);
      expect(review.state.allUnitsHaveOwnership, isFalse);
      expect(review.state.isUnitInfoComplete(units[0].id), isTrue);
      expect(review.state.canSubmit, isFalse);
    });

    test('missing address means owner information is incomplete', () {
      cubit
        ..startRegistration(OwnerType.individual)
        ..saveIndividual(individual());
      final review = RegistrationReviewCubit(cubit.state);
      addTearDown(review.close);

      expect(review.state.isOwnerInfoComplete, isFalse);
    });
  });

  group('seeding steps from the draft', () {
    test('unit selection keeps only selectable seeded units', () {
      final seeded = UnitSelectionCubit(sampleUnits, selectedIds: {'unit-204', 'villa-08'});
      addTearDown(seeded.close);

      expect(seeded.state.selectedIds, {'unit-204'});
    });

    test('ownership details restores valid units as completed', () {
      final seeded = OwnershipDetailsCubit(
        units,
        details: {
          units[0].id: const UnitOwnership(type: OwnershipType.sole),
          units[1].id: const UnitOwnership(notes: 'draft'),
          'other': const UnitOwnership(type: OwnershipType.joint),
        },
      );
      addTearDown(seeded.close);

      expect(seeded.state.details.keys, [units[0].id, units[1].id]);
      expect(seeded.state.savedIds, {units[0].id});
    });

    test('documents keeps owner slots and slots for the given units only', () {
      final seeded = OwnerDocumentsCubit(
        [units[0]],
        documents: {
          ...requiredDocuments(),
          const DocumentSlot(DocumentType.purchaseContract, unitId: 'other'): file,
        },
      );
      addTearDown(seeded.close);

      expect(seeded.state.ownerUploadedCount, 1);
      expect(seeded.state.isComplete, isTrue);
      expect(seeded.state.documents.length, 2);
    });
  });
}
