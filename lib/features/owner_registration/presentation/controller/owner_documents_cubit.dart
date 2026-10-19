import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/model/owner_document.dart';
import '../../data/model/owner_unit.dart';

part 'owner_documents_state.dart';

class OwnerDocumentsCubit extends Cubit<OwnerDocumentsState> {
  OwnerDocumentsCubit(List<OwnerUnit> units) : super(OwnerDocumentsState(units: units));

  void attach(DocumentSlot slot, UploadedDocument document) {
    emit(OwnerDocumentsState(units: state.units, documents: {...state.documents, slot: document}));
  }

  void remove(DocumentSlot slot) {
    if (!state.documents.containsKey(slot)) return;
    emit(OwnerDocumentsState(units: state.units, documents: {...state.documents}..remove(slot)));
  }
}
