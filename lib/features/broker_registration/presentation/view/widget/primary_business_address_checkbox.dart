import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/locale/app_locale_key.dart';
import '../../../../../core/theme/app_text_styles.dart';
import '../../../../../core/theme/extensions/theme_extensions.dart';
import '../../controller/broker_business_address_cubit.dart';

class PrimaryBusinessAddressCheckbox extends StatelessWidget {
  const PrimaryBusinessAddressCheckbox({super.key});

  static const _minHeight = 50.0;
  static const _boxSize = 19.0;
  static const _gap = 11.0;
  static const _textHeight = 1.5;
  static const _boxShape = RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(2)),
  );

  @override
  Widget build(BuildContext context) {
    final colors = context.customColors;

    return BlocSelector<BrokerBusinessAddressCubit, BrokerBusinessAddressState, bool>(
      selector: (state) => state.isPrimary,
      builder: (context, isPrimary) {
        final cubit = context.read<BrokerBusinessAddressCubit>();

        return MergeSemantics(
          child: InkWell(
            onTap: () => cubit.togglePrimary(!isPrimary),
            child: ConstrainedBox(
              constraints: const BoxConstraints(minHeight: _minHeight),
              child: Row(
                children: [
                  SizedBox.square(
                    dimension: _boxSize,
                    child: Checkbox(
                      value: isPrimary,
                      onChanged: (value) => cubit.togglePrimary(value ?? false),
                      activeColor: colors.oceanAccent,
                      checkColor: colors.onPrimary,
                      side: BorderSide(color: colors.hint),
                      shape: _boxShape,
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      visualDensity: VisualDensity.compact,
                    ),
                  ),
                  const SizedBox(width: _gap),
                  Expanded(
                    child: Text(
                      AppLocaleKey.setAsPrimaryBusinessAddress.tr(),
                      style: AppTextStyles.xxsBold.copyWith(
                        color: colors.formLabel,
                        height: _textHeight,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
