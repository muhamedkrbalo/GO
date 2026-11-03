import '../../../../core/locale/app_locale_key.dart';

enum LegalForm {
  limitedLiability(AppLocaleKey.limitedLiabilityCompany),
  jointStock(AppLocaleKey.jointStockCompany),
  soleProprietorship(AppLocaleKey.soleProprietorship),
  partnership(AppLocaleKey.partnershipCompany);

  const LegalForm(this.labelKey);

  final String labelKey;
}
