import '../../../../core/locale/app_locale_key.dart';

enum OwnershipType {
  sole(AppLocaleKey.soleOwnership),
  joint(AppLocaleKey.jointOwnership),
  inherited(AppLocaleKey.inheritedOwnership);

  const OwnershipType(this.labelKey);

  final String labelKey;
}
