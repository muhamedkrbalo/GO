import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../../core/locale/app_locale_key.dart';
import '../../../data/model/owner_package.dart';
import 'egp_amount.dart';
import 'package_info_row.dart';

class CurrentPackageBanner extends StatelessWidget {
  const CurrentPackageBanner({super.key, required this.package});

  final OwnerPackage package;

  static const _radius = BorderRadius.all(Radius.circular(9));
  static const _padding = EdgeInsetsDirectional.all(12);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: _radius,
      child: PackageInfoRow(
        label: AppLocaleKey.currentPackage.tr(),
        value: '${package.name} · ${formatEgpAmount(package.price)}',
        isHighlighted: true,
        padding: _padding,
      ),
    );
  }
}
