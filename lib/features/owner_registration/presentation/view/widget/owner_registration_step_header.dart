import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../../core/custom_widgets/registration_step_header/registration_step_header.dart';
import '../../../../../core/locale/app_locale_key.dart';

class OwnerRegistrationStepHeader extends StatelessWidget {
  const OwnerRegistrationStepHeader({
    super.key,
    required this.stepLabel,
    required this.progress,
    this.stepTitle,
    this.stepHint,
    this.onBack,
    this.progressColors,
  });

  final String stepLabel;
  final double progress;
  final String? stepTitle;
  final String? stepHint;
  final VoidCallback? onBack;
  final List<Color>? progressColors;

  @override
  Widget build(BuildContext context) {
    return RegistrationStepHeader(
      title: AppLocaleKey.ownerRegistration.tr(),
      stepLabel: stepLabel,
      progress: progress,
      stepTitle: stepTitle,
      stepHint: stepHint,
      onBack: onBack,
      progressColors: progressColors,
    );
  }
}
