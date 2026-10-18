import '../../../../core/images/app_images.dart';
import '../../../../core/locale/app_locale_key.dart';

/// One onboarding slide. Text fields are [AppLocaleKey]s, translated at build time.
class OnboardingItem {
  const OnboardingItem({
    required this.illustration,
    required this.titleKey,
    required this.descriptionKey,
  });

  final String illustration;
  final String titleKey;
  final String descriptionKey;

  static const items = [
    OnboardingItem(
      illustration: AppImages.assetsSvgOnboarding1,
      titleKey: AppLocaleKey.onboardingTitle1,
      descriptionKey: AppLocaleKey.onboardingDescription1,
    ),
    OnboardingItem(
      illustration: AppImages.assetsSvgOnboarding2,
      titleKey: AppLocaleKey.onboardingTitle2,
      descriptionKey: AppLocaleKey.onboardingDescription2,
    ),
    OnboardingItem(
      illustration: AppImages.assetsSvgOnboarding3,
      titleKey: AppLocaleKey.onboardingTitle3,
      descriptionKey: AppLocaleKey.onboardingDescription3,
    ),
  ];
}
