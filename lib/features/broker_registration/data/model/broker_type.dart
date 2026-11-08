import '../../../../core/images/app_images.dart';
import '../../../../core/locale/app_locale_key.dart';

enum BrokerType {
  individual(
    icon: AppImages.assetsSvgPerson,
    titleKey: AppLocaleKey.individualBroker,
    descriptionKey: AppLocaleKey.individualBrokerDescription,
  ),
  company(
    icon: AppImages.assetsSvgBuilding,
    titleKey: AppLocaleKey.companyBroker,
    descriptionKey: AppLocaleKey.companyBrokerDescription,
  );

  const BrokerType({required this.icon, required this.titleKey, required this.descriptionKey});

  final String icon;
  final String titleKey;
  final String descriptionKey;
}
