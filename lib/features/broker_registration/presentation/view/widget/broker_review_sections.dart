import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/custom_widgets/registration_form/review_info_rows.dart';
import '../../../../../core/locale/app_locale_key.dart';
import '../../../../../core/routes/routes_name.dart';
import '../../../../../core/theme/app_sizes.dart';
import '../../../data/model/broker_document_type.dart';
import '../../controller/broker_registration_draft_cubit.dart';
import 'broker_summary_section.dart';

class BrokerReviewSections extends StatelessWidget {
  const BrokerReviewSections({super.key});

  static void _returnTo(BuildContext context, String routeName) {
    Navigator.of(context).popUntil((route) => route.settings.name == routeName || route.isFirst);
  }

  @override
  Widget build(BuildContext context) {
    final draft = context.watch<BrokerRegistrationDraftCubit>().state;
    final personal = draft.personalInfo;
    final identity = draft.identityInfo;
    final address = draft.businessAddress;
    final nationality = personal?.nationality;
    final country = address?.country;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        BrokerSummarySection(
          title: AppLocaleKey.entityInformation.tr(),
          onEdit: () => _returnTo(context, RouteNames.brokerPersonalInfo),
          items: [
            ReviewInfoItem(
              label: AppLocaleKey.entityType.tr(),
              rawValue: draft.brokerType?.titleKey.tr(),
            ),
            ReviewInfoItem(label: AppLocaleKey.legalName.tr(), rawValue: personal?.fullName),
            ReviewInfoItem(
              label: AppLocaleKey.nationality.tr(),
              rawValue: nationality?.getTranslatedName(context) ?? nationality?.name,
            ),
            ReviewInfoItem(
              label: AppLocaleKey.mobile.tr(),
              rawValue: draft.businessMobile,
              isLtr: true,
            ),
            ReviewInfoItem(
              label: AppLocaleKey.email.tr(),
              rawValue: draft.businessEmail,
              isLtr: true,
            ),
          ],
        ),
        AppSpacing.gapV10,
        BrokerSummarySection(
          title: AppLocaleKey.identityInformation.tr(),
          onEdit: () => _returnTo(context, RouteNames.brokerIdentityInfo),
          items: [
            ReviewInfoItem(
              label: AppLocaleKey.idType.tr(),
              rawValue: identity?.idType?.labelKey.tr(),
            ),
            ReviewInfoItem(
              label: AppLocaleKey.idNumber.tr(),
              rawValue: identity?.idNumber,
              isLtr: true,
            ),
          ],
        ),
        AppSpacing.gapV10,
        BrokerSummarySection(
          title: AppLocaleKey.businessAddressTitle.tr(),
          onEdit: () => _returnTo(context, RouteNames.brokerBusinessAddress),
          items: [
            ReviewInfoItem(
              label: AppLocaleKey.country.tr(),
              rawValue: country?.getTranslatedName(context) ?? country?.name,
            ),
            ReviewInfoItem(
              label: AppLocaleKey.governorateState.tr(),
              rawValue: address?.governorate,
            ),
            ReviewInfoItem(label: AppLocaleKey.city.tr(), rawValue: address?.city),
            ReviewInfoItem(label: AppLocaleKey.addressLine1.tr(), rawValue: address?.addressLine1),
          ],
        ),
        AppSpacing.gapV10,
        BrokerSummarySection(
          title: AppLocaleKey.businessContactInformation.tr(),
          onEdit: () => _returnTo(context, RouteNames.brokerPersonalInfo),
          items: [
            ReviewInfoItem(
              label: AppLocaleKey.mobile.tr(),
              rawValue: draft.businessMobile,
              isLtr: true,
            ),
            ReviewInfoItem(
              label: AppLocaleKey.email.tr(),
              rawValue: draft.businessEmail,
              isLtr: true,
            ),
          ],
        ),
        AppSpacing.gapV10,
        BrokerSummarySection(
          title: AppLocaleKey.uploadedDocuments.tr(),
          onEdit: () => _returnTo(context, RouteNames.brokerDocuments),
          items: [
            for (final type in BrokerDocumentType.values)
              ReviewInfoItem(label: type.titleKey.tr(), rawValue: draft.documents[type]?.name),
          ],
        ),
      ],
    );
  }
}
