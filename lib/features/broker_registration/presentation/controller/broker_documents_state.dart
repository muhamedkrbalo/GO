part of 'broker_documents_cubit.dart';

class BrokerDocumentsState extends Equatable {
  const BrokerDocumentsState({this.documents = const {}});

  final Map<BrokerDocumentType, UploadedDocument> documents;

  UploadedDocument? documentOf(BrokerDocumentType type) => documents[type];

  bool get canContinue =>
      BrokerDocumentType.values.where((type) => type.isRequired).every(documents.containsKey);

  @override
  List<Object?> get props => [documents];
}
