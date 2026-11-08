import 'package:flutter/material.dart';

import '../../../data/model/broker_document_type.dart';
import 'broker_document_card.dart';

class BrokerDocumentsList extends StatelessWidget {
  const BrokerDocumentsList({super.key});

  static const _cardGap = SizedBox(height: 12);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        for (final type in BrokerDocumentType.values) ...[
          if (type.index > 0) _cardGap,
          BrokerDocumentCard(type: type),
        ],
      ],
    );
  }
}
