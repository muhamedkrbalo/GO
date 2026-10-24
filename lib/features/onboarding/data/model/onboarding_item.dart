import '../../../../core/images/app_images.dart';
import '../../../../core/locale/app_locale_key.dart';

/// One onboarding slide. Text fields are [AppLocaleKey]s, translated at build time.
class OnboardingItem {
  const OnboardingItem({
    required this.image,
    required this.eyebrowKey,
    required this.titleKey,
    required this.descriptionKey,
  });

  final String image;
  final String eyebrowKey;
  final String titleKey;
  final String descriptionKey;

  static const items = [
    OnboardingItem(
      image: AppImages.assetsImagesOnboardingDiscover,
      eyebrowKey: AppLocaleKey.onboardingEyebrow1,
      titleKey: AppLocaleKey.onboardingTitle1,
      descriptionKey: AppLocaleKey.onboardingDescription1,
    ),
    OnboardingItem(
      image: AppImages.assetsImagesOnboardingConnect,
      eyebrowKey: AppLocaleKey.onboardingEyebrow2,
      titleKey: AppLocaleKey.onboardingTitle2,
      descriptionKey: AppLocaleKey.onboardingDescription2,
    ),
    OnboardingItem(
      image: AppImages.assetsImagesOnboardingJourney,
      eyebrowKey: AppLocaleKey.onboardingEyebrow3,
      titleKey: AppLocaleKey.onboardingTitle3,
      descriptionKey: AppLocaleKey.onboardingDescription3,
    ),
  ];
}
