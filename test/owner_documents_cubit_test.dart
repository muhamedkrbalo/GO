import 'package:flutter_hr_erb/features/owner_registration/data/model/owner_document.dart';
import 'package:flutter_hr_erb/features/owner_registration/data/model/sample_units.dart';
import 'package:flutter_hr_erb/features/owner_registration/presentation/controller/owner_documents_cubit.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final units = [sampleUnits[0], sampleUnits[5]];
  const file = UploadedDocument(name: 'id.pdf', sizeInBytes: 2048);
  late OwnerDocumentsCubit cubit;

  setUp(() => cubit = OwnerDocumentsCubit(units));

  tearDown(() => cubit.close());

  test('starts incomplete with no documents', () {
    expect(cubit.state.documents, isEmpty);
    expect(cubit.state.isComplete, isFalse);
  });

  test('the optional supporting document is not needed to complete', () {
    cubit.attach(OwnerDocumentsState.identitySlot, file);
    for (final unit in units) {
      cubit.attach(OwnerDocumentsState.contractSlotOf(unit.id), file);
    }
    expect(cubit.state.documentOf(OwnerDocumentsState.supportingSlot), isNull);
    expect(cubit.state.isComplete, isTrue);
  });

  test('every unit needs its own ownership contract', () {
    cubit
      ..attach(OwnerDocumentsState.identitySlot, file)
      ..attach(OwnerDocumentsState.contractSlotOf(units[0].id), file);
    expect(cubit.state.isUnitComplete(units[0].id), isTrue);
    expect(cubit.state.isUnitComplete(units[1].id), isFalse);
    expect(cubit.state.isComplete, isFalse);
  });

  test('removing a document makes its slot empty again', () {
    cubit
      ..attach(OwnerDocumentsState.identitySlot, file)
      ..remove(OwnerDocumentsState.identitySlot);
    expect(cubit.state.documentOf(OwnerDocumentsState.identitySlot), isNull);
  });

  test('size label switches from KB to MB', () {
    expect(const UploadedDocument(name: 'a', sizeInBytes: 340 * 1024).sizeLabel, '340 KB');
    expect(const UploadedDocument(name: 'b', sizeInBytes: 1572864).sizeLabel, '1.5 MB');
  });
}
