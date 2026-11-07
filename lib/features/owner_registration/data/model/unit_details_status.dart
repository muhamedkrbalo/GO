import '../../../../core/locale/app_locale_key.dart';

enum UnitDetailsStatus {
  notStarted(AppLocaleKey.notStarted),
  inProgress(AppLocaleKey.inProgress),
  completed(AppLocaleKey.completed);

  const UnitDetailsStatus(this.labelKey);

  final String labelKey;
}
