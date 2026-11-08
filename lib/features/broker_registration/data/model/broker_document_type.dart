import '../../../../core/locale/app_locale_key.dart';

enum BrokerDocumentType {
  identityFront(AppLocaleKey.identityDocumentFront, isRequired: true),
  identityBack(AppLocaleKey.identityDocumentBack, isRequired: false);

  const BrokerDocumentType(this.titleKey, {required this.isRequired});

  final String titleKey;
  final bool isRequired;
}
