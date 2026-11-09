import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/models/uploaded_document.dart';
import '../../data/model/broker_document_type.dart';

part 'broker_documents_state.dart';

class BrokerDocumentsCubit extends Cubit<BrokerDocumentsState> {
  BrokerDocumentsCubit({Map<BrokerDocumentType, UploadedDocument> documents = const {}})
    : super(BrokerDocumentsState(documents: Map.unmodifiable(documents)));

  void attach(BrokerDocumentType type, UploadedDocument document) {
    if (state.documentOf(type) == document) return;
    emit(BrokerDocumentsState(documents: Map.unmodifiable({...state.documents, type: document})));
  }

  void remove(BrokerDocumentType type) {
    if (!state.documents.containsKey(type)) return;
    emit(BrokerDocumentsState(documents: Map.unmodifiable({...state.documents}..remove(type))));
  }
}
