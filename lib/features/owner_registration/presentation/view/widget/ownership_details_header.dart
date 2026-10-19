import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/locale/app_locale_key.dart';
import '../../../../../core/theme/app_text_styles.dart';
import '../../../../../core/theme/extensions/theme_extensions.dart';
import '../../controller/ownership_details_cubit.dart';

class OwnershipDetailsHeader extends StatelessWidget {
  const OwnershipDetailsHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = context.customColors;

    return Row(
      children: [
        Expanded(
          child: Text(
            AppLocaleKey.ownershipDetails.tr(),
            style: AppTextStyles.xsBold.copyWith(color: colors.textSecondary, height: 1.5),
          ),
        ),
        BlocSelector<OwnershipDetailsCubit, OwnershipDetailsState, (int, int)>(
          selector: (state) => (state.completedCount, state.units.length),
          builder: (context, progress) => Text(
            AppLocaleKey.completeCount.tr(args: ['${progress.$1}', '${progress.$2}']),
            style: AppTextStyles.xxxsSemiBold.copyWith(color: colors.textMuted),
          ),
        ),
      ],
    );
  }
}
