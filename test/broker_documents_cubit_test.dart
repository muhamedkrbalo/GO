import 'package:flutter_hr_erb/core/models/uploaded_document.dart';
import 'package:flutter_hr_erb/features/broker_registration/data/model/broker_document_type.dart';
import 'package:flutter_hr_erb/features/broker_registration/presentation/controller/broker_documents_cubit.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late BrokerDocumentsCubit cubit;

  const front = UploadedDocument(
    name: 'id_front.jpg',
    sizeInBytes: 2048,
    path: '/tmp/id_front.jpg',
  );
  const back = UploadedDocument(name: 'id_back.jpg', sizeInBytes: 4096, path: '/tmp/id_back.jpg');

  setUp(() => cubit = BrokerDocumentsCubit());

  tearDown(() => cubit.close());

  test('starts empty and cannot continue', () {
    expect(cubit.state.documents, isEmpty);
    expect(cubit.state.canContinue, isFalse);
  });

  test('the optional back side alone is not enough to continue', () {
    cubit.attach(BrokerDocumentType.identityBack, back);

    expect(cubit.state.canContinue, isFalse);
  });

  test('attaching the required front side allows continue', () {
    cubit.attach(BrokerDocumentType.identityFront, front);

    expect(cubit.state.documentOf(BrokerDocumentType.identityFront), front);
    expect(cubit.state.canContinue, isTrue);
  });

  test('removing the front side blocks continue again', () {
    cubit
      ..attach(BrokerDocumentType.identityFront, front)
      ..attach(BrokerDocumentType.identityBack, back)
      ..remove(BrokerDocumentType.identityFront);

    expect(cubit.state.documentOf(BrokerDocumentType.identityFront), isNull);
    expect(cubit.state.documentOf(BrokerDocumentType.identityBack), back);
    expect(cubit.state.canContinue, isFalse);
  });

  test('attaching the same file twice emits only once', () async {
    final emitted = <BrokerDocumentsState>[];
    final subscription = cubit.stream.listen(emitted.add);

    cubit
      ..attach(BrokerDocumentType.identityFront, front)
      ..attach(BrokerDocumentType.identityFront, front);
    await Future<void>.delayed(Duration.zero);

    expect(emitted, hasLength(1));
    await subscription.cancel();
  });

  test('removing a missing document does nothing', () async {
    final emitted = <BrokerDocumentsState>[];
    final subscription = cubit.stream.listen(emitted.add);

    cubit.remove(BrokerDocumentType.identityBack);
    await Future<void>.delayed(Duration.zero);

    expect(emitted, isEmpty);
    await subscription.cancel();
  });

  test('restores documents passed from the draft', () {
    final restored = BrokerDocumentsCubit(documents: {BrokerDocumentType.identityFront: front});
    addTearDown(restored.close);

    expect(restored.state.canContinue, isTrue);
  });
}
