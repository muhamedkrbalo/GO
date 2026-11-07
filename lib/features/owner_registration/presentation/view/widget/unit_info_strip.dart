import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/locale/app_locale_key.dart';
import '../../../data/model/owner_unit.dart';
import '../../controller/ownership_details_cubit.dart';
import 'registration_info_strip.dart';

class UnitInfoStrip extends StatelessWidget {
  const UnitInfoStrip({super.key});

  static const _wideFlex = 4;
  static const _narrowFlex = 3;

  @override
  Widget build(BuildContext context) {
    return BlocSelector<OwnershipDetailsCubit, OwnershipDetailsState, OwnerUnit>(
      selector: (state) => state.activeUnit,
      builder: (context, unit) {
        final building = unit.building;
        return RegistrationInfoStrip(
          items: [
            InfoStripItem(label: AppLocaleKey.village.tr(), value: unit.village, flex: _wideFlex),
            if (building != null)
              InfoStripItem(label: AppLocaleKey.building.tr(), value: building, flex: _wideFlex),
            InfoStripItem(label: AppLocaleKey.unit.tr(), value: unit.name, flex: _narrowFlex),
          ],
        );
      },
    );
  }
}
