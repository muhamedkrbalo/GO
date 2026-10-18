import '../../../../core/images/app_images.dart';
import '../../../../core/locale/app_locale_key.dart';

enum VerificationMethod {
  sms(
    icon: AppImages.assetsSvgSms,
    titleKey: AppLocaleKey.textMessageSms,
    descriptionKey: AppLocaleKey.receiveCodeOnMobile,
  ),
  email(
    icon: AppImages.assetsSvgMail,
    titleKey: AppLocaleKey.email,
    descriptionKey: AppLocaleKey.receiveCodeInInbox,
  );

  const VerificationMethod({
    required this.icon,
    required this.titleKey,
    required this.descriptionKey,
  });

  final String icon;
  final String titleKey;
  final String descriptionKey;
}
