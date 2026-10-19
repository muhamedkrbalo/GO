import '../../../../core/images/app_images.dart';
import '../../../../core/locale/app_locale_key.dart';

enum OwnerType {
  individual(
    icon: AppImages.assetsSvgIndividual,
    titleKey: AppLocaleKey.individual,
    descriptionKey: AppLocaleKey.individualDescription,
  ),
  company(
    icon: AppImages.assetsSvgCompany,
    titleKey: AppLocaleKey.company,
    descriptionKey: AppLocaleKey.companyDescription,
  );

  const OwnerType({required this.icon, required this.titleKey, required this.descriptionKey});

  final String icon;
  final String titleKey;
  final String descriptionKey;
}
