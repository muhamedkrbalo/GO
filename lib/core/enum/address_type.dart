import '../locale/app_locale_key.dart';

enum AddressType {
  residential(AppLocaleKey.residentialAddress),
  business(AppLocaleKey.businessAddress),
  other(AppLocaleKey.otherAddress);

  const AddressType(this.labelKey);

  final String labelKey;
}
