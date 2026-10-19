import '../../../../core/images/app_images.dart';
import '../../../../core/locale/app_locale_key.dart';

enum BusinessRole {
  owner(
    icon: AppImages.assetsSvgOwner,
    titleKey: AppLocaleKey.owner,
    descriptionKey: AppLocaleKey.ownerDescription,
  ),
  broker(
    icon: AppImages.assetsSvgBroker,
    titleKey: AppLocaleKey.broker,
    descriptionKey: AppLocaleKey.brokerDescription,
  ),
  serviceProvider(
    icon: AppImages.assetsSvgServiceProvider,
    titleKey: AppLocaleKey.serviceProvider,
    descriptionKey: AppLocaleKey.serviceProviderDescription,
  );

  const BusinessRole({
    required this.icon,
    required this.titleKey,
    required this.descriptionKey,
  });

  final String icon;
  final String titleKey;
  final String descriptionKey;
}
