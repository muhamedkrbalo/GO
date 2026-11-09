import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/models/uploaded_document.dart';
import '../../../data/model/broker_document_type.dart';
import '../../controller/broker_documents_cubit.dart';
import 'broker_upload_card.dart';

class BrokerDocumentsList extends StatelessWidget {
  const BrokerDocumentsList({super.key});

  static const _cardGap = SizedBox(height: 12);

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<BrokerDocumentsCubit>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        for (final type in BrokerDocumentType.values) ...[
          if (type.index > 0) _cardGap,
          BlocSelector<BrokerDocumentsCubit, BrokerDocumentsState, UploadedDocument?>(
            selector: (state) => state.documentOf(type),
            builder: (context, document) => BrokerUploadCard(
              title: type.titleKey.tr(),
              isRequired: type.isRequired,
              document: document,
              onAttach: (uploaded) => cubit.attach(type, uploaded),
              onRemove: () => cubit.remove(type),
            ),
          ),
        ],
      ],
    );
  }
}
