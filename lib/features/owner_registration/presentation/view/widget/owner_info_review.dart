import 'package:country_picker/country_picker.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../../core/custom_widgets/registration_form/review_info_rows.dart';
import '../../../../../core/locale/app_locale_key.dart';
import '../../../data/model/owner_type.dart';
import '../../controller/company_info_cubit.dart';
import '../../controller/individual_info_cubit.dart';
import '../../controller/owner_registration_draft_cubit.dart';

class OwnerInfoReview extends StatelessWidget {
  const OwnerInfoReview({super.key, required this.draft});

  final OwnerRegistrationDraft draft;

  String? _countryName(BuildContext context, Country? country) {
    if (country == null) return null;
    return country.getTranslatedName(context) ?? country.name;
  }

  String? _phone(Country country, String number) {
    if (number.trim().isEmpty) return null;
    return '+${country.phoneCode} $number';
  }

  List<ReviewInfoItem> _individualItems(BuildContext context, IndividualInfoState? info) {
    final idType = info?.idType;
    final idNumber = info?.idNumber ?? '';
    return [
      ReviewInfoItem(label: AppLocaleKey.entityType.tr(), rawValue: AppLocaleKey.individual.tr()),
      ReviewInfoItem(label: AppLocaleKey.fullLegalName.tr(), rawValue: info?.fullName),
      ReviewInfoItem(
        label: AppLocaleKey.identity.tr(),
        rawValue: idType == null || idNumber.trim().isEmpty
            ? null
            : '${idType.labelKey.tr()} · $idNumber',
      ),
      ReviewInfoItem(
        label: AppLocaleKey.nationality.tr(),
        rawValue: _countryName(context, info?.nationality),
      ),
      ReviewInfoItem(
        label: AppLocaleKey.contactMobile.tr(),
        rawValue: info == null ? null : _phone(info.phoneCountry, info.mobileNumber),
        isLtr: true,
      ),
      ReviewInfoItem(label: AppLocaleKey.contactEmail.tr(), rawValue: info?.email, isLtr: true),
    ];
  }

  List<ReviewInfoItem> _companyItems(BuildContext context, CompanyInfoState? info) {
    return [
      ReviewInfoItem(label: AppLocaleKey.entityType.tr(), rawValue: AppLocaleKey.company.tr()),
      ReviewInfoItem(label: AppLocaleKey.legalCompanyName.tr(), rawValue: info?.legalName),
      ReviewInfoItem(
        label: AppLocaleKey.commercialRegistrationNumber.tr(),
        rawValue: info?.registrationNumber,
        isLtr: true,
      ),
      ReviewInfoItem(label: AppLocaleKey.legalForm.tr(), rawValue: info?.legalForm?.labelKey.tr()),
      ReviewInfoItem(
        label: AppLocaleKey.countryOfRegistration.tr(),
        rawValue: _countryName(context, info?.registrationCountry),
      ),
      ReviewInfoItem(
        label: AppLocaleKey.contactMobile.tr(),
        rawValue: info == null ? null : _phone(info.phoneCountry, info.mobileNumber),
        isLtr: true,
      ),
      ReviewInfoItem(label: AppLocaleKey.contactEmail.tr(), rawValue: info?.email, isLtr: true),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return ReviewInfoRows(
      items: switch (draft.ownerType) {
        OwnerType.company => _companyItems(context, draft.company),
        OwnerType.individual || null => _individualItems(context, draft.individual),
      },
    );
  }
}
