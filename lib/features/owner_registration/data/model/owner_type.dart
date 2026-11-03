import '../../../../core/images/app_images.dart';
import '../../../../core/locale/app_locale_key.dart';

enum OwnerType {
  individual(
    icon: AppImages.assetsSvgPerson,
    titleKey: AppLocaleKey.individualOwnerOption,
    descriptionKey: AppLocaleKey.individualDescription,
  ),
  company(
    icon: AppImages.assetsSvgBuilding,
    titleKey: AppLocaleKey.companyOwnerOption,
    descriptionKey: AppLocaleKey.companyDescription,
  );

  const OwnerType({required this.icon, required this.titleKey, required this.descriptionKey});

  final String icon;
  final String titleKey;
  final String descriptionKey;
}
