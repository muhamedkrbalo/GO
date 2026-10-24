import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/locale/app_locale_key.dart';
import '../../../data/model/owner_unit.dart';
import '../../controller/ownership_details_cubit.dart';
import 'expandable_unit_card.dart';
import 'ownership_unit_fields.dart';
import 'status_pill.dart';

class OwnershipUnitCard extends StatelessWidget {
  const OwnershipUnitCard({super.key, required this.unit, this.initiallyExpanded = false});

  final OwnerUnit unit;
  final bool initiallyExpanded;

  @override
  Widget build(BuildContext context) {
    return ExpandableUnitCard(
      unit: unit,
      initiallyExpanded: initiallyExpanded,
      status: BlocSelector<OwnershipDetailsCubit, OwnershipDetailsState, bool>(
        selector: (state) => state.detailsOf(unit.id).isComplete,
        builder: (context, isComplete) => StatusPill(
          label: isComplete ? AppLocaleKey.detailsComplete.tr() : AppLocaleKey.detailsRequired.tr(),
          tone: isComplete ? StatusPillTone.success : StatusPillTone.warning,
        ),
      ),
      child: OwnershipUnitFields(unitId: unit.id),
    );
  }
}
