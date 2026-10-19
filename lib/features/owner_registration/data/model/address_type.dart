import '../../../../core/locale/app_locale_key.dart';

enum AddressType {
  home(AppLocaleKey.homeAddress),
  business(AppLocaleKey.businessAddress),
  mailing(AppLocaleKey.mailingAddress);

  const AddressType(this.labelKey);

  final String labelKey;
}
