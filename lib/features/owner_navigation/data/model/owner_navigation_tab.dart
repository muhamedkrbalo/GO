import '../../../../core/images/app_images.dart';
import '../../../../core/locale/app_locale_key.dart';

enum OwnerNavigationTab {
  home(AppImages.assetsSvgNavHome, AppLocaleKey.home),
  units(AppImages.assetsSvgNavUnits, AppLocaleKey.units),
  subscription(AppImages.assetsSvgNavSubscription, AppLocaleKey.subscription),
  more(AppImages.assetsSvgNavMore, AppLocaleKey.more);

  const OwnerNavigationTab(this.icon, this.labelKey);

  final String icon;
  final String labelKey;
}
