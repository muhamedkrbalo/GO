import 'package:flutter_hr_erb/features/owner_registration/data/model/owner_document.dart';
import 'package:flutter_hr_erb/features/owner_registration/data/model/sample_units.dart';
import 'package:flutter_hr_erb/features/owner_registration/presentation/controller/owner_documents_cubit.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final units = [sampleUnits[0], sampleUnits[5]];
  const file = UploadedDocument(name: 'id.pdf', sizeInBytes: 2048);
  const identity = DocumentSlot(DocumentType.identity);
  const additionalIdentity = DocumentSlot(DocumentType.additionalIdentity);
  late OwnerDocumentsCubit cubit;

  DocumentSlot unitSlot(DocumentType type, int index) =>
      DocumentSlot(type, unitId: units[index].id);

  setUp(() => cubit = OwnerDocumentsCubit(units));

  tearDown(() => cubit.close());

  test('starts incomplete with every count at zero', () {
    expect(cubit.state.documents, isEmpty);
    expect(cubit.state.ownerUploadedCount, 0);
    expect(cubit.state.ownerTotal, 2);
    expect(cubit.state.unitUploadedCount, 0);
    expect(cubit.state.unitTotal, units.length * DocumentType.unitTypes.length);
    expect(cubit.state.isComplete, isFalse);
  });

  test('only required documents are needed to complete', () {
    cubit.attach(identity, file);
    for (var index = 0; index < units.length; index++) {
      cubit.attach(unitSlot(DocumentType.ownershipContract, index), file);
    }

    expect(cubit.state.documentOf(additionalIdentity), isNull);
    expect(cubit.state.isComplete, isTrue);
  });

  test('every unit needs its own ownership contract', () {
    cubit
      ..attach(identity, file)
      ..attach(unitSlot(DocumentType.ownershipContract, 0), file);

    expect(cubit.state.isUnitComplete(units[0].id), isTrue);
    expect(cubit.state.isUnitComplete(units[1].id), isFalse);
    expect(cubit.state.isComplete, isFalse);
  });

  test('optional uploads count toward progress without affecting completion', () {
    cubit
      ..attach(additionalIdentity, file)
      ..attach(unitSlot(DocumentType.purchaseContract, 0), file)
      ..attach(unitSlot(DocumentType.powerOfAttorney, 0), file);

    expect(cubit.state.ownerUploadedCount, 1);
    expect(cubit.state.uploadedCountOf(units[0].id), 2);
    expect(cubit.state.uploadedCountOf(units[1].id), 0);
    expect(cubit.state.unitUploadedCount, 2);
    expect(cubit.state.isOwnerComplete, isFalse);
    expect(cubit.state.isUnitComplete(units[0].id), isFalse);
  });

  test('documents for units that are not part of the registration are ignored', () {
    cubit.attach(const DocumentSlot(DocumentType.ownershipContract, unitId: 'unknown'), file);

    expect(cubit.state.documents, isEmpty);
  });

  test('removing a document makes its slot empty again', () {
    cubit
      ..attach(identity, file)
      ..remove(identity);

    expect(cubit.state.documentOf(identity), isNull);
    expect(cubit.state.ownerUploadedCount, 0);
  });

  test('size label switches from KB to MB', () {
    expect(const UploadedDocument(name: 'a', sizeInBytes: 340 * 1024).sizeLabel, '340 KB');
    expect(const UploadedDocument(name: 'b', sizeInBytes: 1572864).sizeLabel, '1.5 MB');
  });
}
