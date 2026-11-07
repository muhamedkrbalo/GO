import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../../core/locale/app_locale_key.dart';
import '../../controller/owner_address_cubit.dart';
import 'review_info_rows.dart';

class OwnerAddressReview extends StatelessWidget {
  const OwnerAddressReview({super.key, required this.address});

  final OwnerAddressState? address;

  @override
  Widget build(BuildContext context) {
    final address = this.address;
    final country = address?.country;

    return ReviewInfoRows(
      items: [
        ReviewInfoItem(
          label: AppLocaleKey.country.tr(),
          rawValue: country == null ? null : country.getTranslatedName(context) ?? country.name,
        ),
        ReviewInfoItem(label: AppLocaleKey.governorateState.tr(), rawValue: address?.governorate),
        ReviewInfoItem(label: AppLocaleKey.city.tr(), rawValue: address?.city),
        ReviewInfoItem(label: AppLocaleKey.district.tr(), rawValue: address?.district),
        ReviewInfoItem(label: AppLocaleKey.addressLine1.tr(), rawValue: address?.addressLine1),
        ReviewInfoItem(label: AppLocaleKey.addressType.tr(), rawValue: address?.type.labelKey.tr()),
        ReviewInfoItem(
          label: AppLocaleKey.primaryAddress.tr(),
          rawValue: address == null
              ? null
              : address.isPrimary
              ? AppLocaleKey.yes.tr()
              : AppLocaleKey.no.tr(),
        ),
      ],
    );
  }
}
