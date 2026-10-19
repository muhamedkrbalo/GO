import '../../../../core/locale/app_locale_key.dart';

enum Gender {
  male(AppLocaleKey.male),
  female(AppLocaleKey.female);

  const Gender(this.labelKey);

  final String labelKey;
}
