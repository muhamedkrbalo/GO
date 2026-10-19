import '../../../../core/locale/app_locale_key.dart';

enum IdType {
  nationalId(AppLocaleKey.nationalId),
  passport(AppLocaleKey.passport);

  const IdType(this.labelKey);

  final String labelKey;
}
