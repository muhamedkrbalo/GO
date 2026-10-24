import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/locale/app_locale_key.dart';
import '../../../data/model/owner_unit.dart';
import '../../controller/owner_documents_cubit.dart';
import 'document_upload_card.dart';
import 'expandable_unit_card.dart';
import 'status_pill.dart';

class UnitDocumentsCard extends StatelessWidget {
  const UnitDocumentsCard({super.key, required this.unit, this.initiallyExpanded = false});

  final OwnerUnit unit;
  final bool initiallyExpanded;

  static const _bodyPadding = EdgeInsets.all(12.8);

  @override
  Widget build(BuildContext context) {
    return ExpandableUnitCard(
      unit: unit,
      initiallyExpanded: initiallyExpanded,
      bodyPadding: _bodyPadding,
      status: BlocSelector<OwnerDocumentsCubit, OwnerDocumentsState, bool>(
        selector: (state) => state.isUnitComplete(unit.id),
        builder: (context, isComplete) => StatusPill(
          label: isComplete
              ? AppLocaleKey.readyForReview.tr()
              : AppLocaleKey.documentsRequired.tr(),
          tone: isComplete ? StatusPillTone.success : StatusPillTone.warning,
        ),
      ),
      child: DocumentUploadCard(slot: OwnerDocumentsState.contractSlotOf(unit.id)),
    );
  }
}
