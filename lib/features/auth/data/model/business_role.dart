import '../../../../core/images/app_images.dart';
import '../../../../core/locale/app_locale_key.dart';

enum BusinessRole {
  owner(
    icon: AppImages.assetsSvgHouse,
    titleKey: AppLocaleKey.propertyOwner,
    descriptionKey: AppLocaleKey.ownerDescription,
  ),
  broker(
    icon: AppImages.assetsSvgBriefcase,
    titleKey: AppLocaleKey.broker,
    descriptionKey: AppLocaleKey.brokerDescription,
  );

  const BusinessRole({required this.icon, required this.titleKey, required this.descriptionKey});

  final String icon;
  final String titleKey;
  final String descriptionKey;
}
