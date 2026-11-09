import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/enum/address_type.dart';
import '../../../../../core/locale/app_locale_key.dart';
import '../../../../../core/theme/app_sizes.dart';
import '../../../../../core/theme/app_text_styles.dart';
import '../../../../../core/theme/extensions/theme_extensions.dart';
import '../../controller/owner_address_cubit.dart';
import 'address_type_selector.dart';
import 'primary_address_toggle.dart';

class AddressTypeCard extends StatelessWidget {
  const AddressTypeCard({super.key});

  static const _padding = EdgeInsetsDirectional.fromSTEB(16, 16, 16, 20);
  static const _radius = BorderRadius.all(Radius.circular(14));
  static const _selectorToToggleGap = 6.0;
  static const _titleHeight = 1.5;

  @override
  Widget build(BuildContext context) {
    final colors = context.customColors;
    final cubit = context.read<OwnerAddressCubit>();

    return DecoratedBox(
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: _radius,
        border: Border.all(color: colors.subtleBorder),
      ),
      child: Padding(
        padding: _padding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              AppLocaleKey.addressType.tr(),
              style: AppTextStyles.xsBold.copyWith(color: colors.textPrimary, height: _titleHeight),
            ),
            AppSpacing.gapV12,
            BlocSelector<OwnerAddressCubit, OwnerAddressState, AddressType>(
              selector: (state) => state.type,
              builder: (context, type) =>
                  AddressTypeSelector(selected: type, onSelect: cubit.selectType),
            ),
            const SizedBox(height: _selectorToToggleGap),
            BlocSelector<OwnerAddressCubit, OwnerAddressState, bool>(
              selector: (state) => state.isPrimary,
              builder: (context, isPrimary) =>
                  PrimaryAddressToggle(value: isPrimary, onChanged: cubit.togglePrimary),
            ),
          ],
        ),
      ),
    );
  }
}
