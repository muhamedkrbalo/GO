import 'dart:ui' as ui;

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/locale/app_locale_key.dart';
import '../../../../../core/theme/app_text_styles.dart';
import '../../../../../core/theme/extensions/theme_extensions.dart';
import '../../controller/broker_registration_draft_cubit.dart';

class BusinessContactCard extends StatelessWidget {
  const BusinessContactCard({super.key});

  static const _radius = BorderRadius.all(Radius.circular(13));
  static const _footerPadding = EdgeInsetsDirectional.symmetric(horizontal: 14, vertical: 11);
  static const _footerTextHeight = 1.4;

  @override
  Widget build(BuildContext context) {
    final colors = context.customColors;

    return BlocSelector<BrokerRegistrationDraftCubit, BrokerRegistrationDraft, (String?, String?)>(
      selector: (draft) => (draft.businessMobile, draft.businessEmail),
      builder: (context, contacts) {
        final (mobile, email) = contacts;

        return DecoratedBox(
          position: DecorationPosition.foreground,
          decoration: BoxDecoration(
            borderRadius: _radius,
            border: Border.all(color: colors.subtleBorder),
          ),
          child: ClipRRect(
            borderRadius: _radius,
            child: ColoredBox(
              color: colors.surface,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _ContactRow(
                    label: AppLocaleKey.businessMobile.tr(),
                    value: mobile,
                    textDirection: ui.TextDirection.ltr,
                  ),
                  _ContactRow(label: AppLocaleKey.businessEmail.tr(), value: email),
                  ColoredBox(
                    color: colors.canvas,
                    child: Padding(
                      padding: _footerPadding,
                      child: Text(
                        AppLocaleKey.existingContactsUsedNote.tr(),
                        style: AppTextStyles.xxxxxsMedium.copyWith(
                          color: colors.textMuted,
                          fontWeight: FontWeight.w400,
                          height: _footerTextHeight,
                        ),
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

class _ContactRow extends StatelessWidget {
  const _ContactRow({required this.label, required this.value, this.textDirection});

  final String label;
  final String? value;
  final ui.TextDirection? textDirection;

  static const _padding = EdgeInsetsDirectional.all(14);
  static const _gap = SizedBox(height: 4);
  static const _labelHeight = 1.5;
  static const _valueHeight = 1.5;

  @override
  Widget build(BuildContext context) {
    final colors = context.customColors;
    final isProvided = value != null;

    return DecoratedBox(
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: colors.subtleBorder)),
      ),
      child: Padding(
        padding: _padding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: AppTextStyles.xxxxxsMedium.copyWith(
                color: colors.hint,
                fontWeight: FontWeight.w400,
                height: _labelHeight,
              ),
            ),
            _gap,
            Text(
              value ?? AppLocaleKey.notProvided.tr(),
              textDirection: isProvided ? textDirection : null,
              style: AppTextStyles.xxsBold.copyWith(
                color: isProvided ? colors.textPrimary : colors.hint,
                height: _valueHeight,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
