import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/custom_widgets/custom_form_field/custom_form_field.dart';
import '../../../../../core/locale/app_locale_key.dart';
import '../../../../../core/theme/app_text_styles.dart';
import '../../../../../core/theme/extensions/theme_extensions.dart';
import '../../../data/model/payment_method.dart';
import '../../controller/package_payment_cubit.dart';
import 'package_details_section_card.dart';
import 'payment_proof_upload.dart';

class PaymentInstructionsCard extends StatelessWidget {
  const PaymentInstructionsCard({super.key});

  static const _topGap = EdgeInsetsDirectional.only(top: 15);
  static const _radius = BorderRadius.all(Radius.circular(11));
  static const _titleGap = 6.0;
  static const _warningGap = SizedBox(height: 6);
  static const _sectionGap = SizedBox(height: 13);
  static const _fieldTitleGap = 6.0;
  static const _fieldRadius = 9.0;
  static const _fieldBorderWidth = 1.6;
  static const _fieldPadding = EdgeInsetsDirectional.symmetric(horizontal: 12, vertical: 15);
  static const _textHeight = 1.5;

  @override
  Widget build(BuildContext context) {
    return BlocSelector<PackagePaymentCubit, PackagePaymentState, PaymentMethod?>(
      selector: (state) => state.method,
      builder: (context, method) {
        if (method == null) return const SizedBox.shrink();
        final colors = context.customColors;
        final methodName = method.labelKey.tr();
        final bodyStyle = AppTextStyles.xxxxxsMedium.copyWith(
          fontWeight: FontWeight.w400,
          height: _textHeight,
        );

        return Padding(
          padding: _topGap,
          child: PackageDetailsSectionCard(
            title: AppLocaleKey.paymentMethodInstructions.tr(args: [methodName]),
            isTitleBold: true,
            titleGap: _titleGap,
            borderRadius: _radius,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  AppLocaleKey.paymentInstructionsPrototype.tr(args: [methodName]),
                  style: bodyStyle.copyWith(color: colors.textMuted),
                ),
                _warningGap,
                Text(
                  AppLocaleKey.paymentPrototypeWarning.tr(),
                  style: bodyStyle.copyWith(color: colors.stepLabel),
                ),
                _sectionGap,
                CustomFormField(
                  title: AppLocaleKey.paymentReference.tr(),
                  hintText: AppLocaleKey.paymentReferenceHint.tr(),
                  isRequired: true,
                  onChanged: context.read<PackagePaymentCubit>().updateReference,
                  radius: _fieldRadius,
                  borderColor: colors.subtleBorder,
                  borderWidth: _fieldBorderWidth,
                  titleGap: _fieldTitleGap,
                  contentPadding: _fieldPadding,
                  titleStyle: AppTextStyles.xxxxxsMedium.copyWith(
                    color: colors.formLabel,
                    fontWeight: FontWeight.w700,
                    height: _textHeight,
                  ),
                  textStyle: AppTextStyles.xxxsMedium.copyWith(color: colors.textSecondary),
                  hintStyle: AppTextStyles.xxxxxsMedium.copyWith(
                    color: colors.hint,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                _sectionGap,
                const PaymentProofUpload(),
              ],
            ),
          ),
        );
      },
    );
  }
}
