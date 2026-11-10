import '../../../../core/locale/app_locale_key.dart';

enum PaymentMethod {
  bankTransfer(AppLocaleKey.bankTransfer),
  instaPay(AppLocaleKey.instaPay),
  fawry(AppLocaleKey.fawry);

  const PaymentMethod(this.labelKey);

  final String labelKey;
}
