import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/custom_widgets/registration_form/registration_notice.dart';
import '../../../../../core/locale/app_locale_key.dart';
import '../../../../../core/routes/routes_name.dart';
import '../../../../../core/theme/app_sizes.dart';
import '../../../../../core/theme/extensions/theme_extensions.dart';
import '../../../data/model/registration_receipt.dart';
import '../widget/next_steps_card.dart';
import '../widget/submission_confirmation_bottom_bar.dart';
import '../widget/submission_confirmation_header.dart';
import '../widget/submission_details_card.dart';
import '../widget/submission_hero.dart';

class SubmissionConfirmationScreen extends StatelessWidget {
  const SubmissionConfirmationScreen({super.key, required this.receipt});

  final RegistrationReceipt receipt;

  static const _contentPadding = EdgeInsetsDirectional.fromSTEB(24, 25, 24, 30);
  static const _nextStepsGap = SizedBox(height: 22);
  static const _ringSize = 290.0;
  static const _ringOffsetEnd = -144.0;
  static const _ringOffsetTop = -132.0;
  static const _ringOpacity = 0.14;

  @override
  Widget build(BuildContext context) {
    final colors = context.customColors;

    return Scaffold(
      backgroundColor: colors.canvas,
      bottomNavigationBar: SubmissionConfirmationBottomBar(
        onViewStatus: () => context.pushNamed(RouteNames.registrationStatus, extra: receipt),
      ),
      body: Stack(
        children: [
          PositionedDirectional(
            end: _ringOffsetEnd,
            top: _ringOffsetTop,
            child: IgnorePointer(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: colors.cyanAccent.withValues(alpha: _ringOpacity)),
                ),
                child: const SizedBox.square(dimension: _ringSize),
              ),
            ),
          ),
          Column(
            children: [
              const SubmissionConfirmationHeader(),
              Expanded(
                child: ListView(
                  padding: _contentPadding,
                  children: [
                    const SubmissionHero(),
                    AppSpacing.gapV24,
                    SubmissionDetailsCard(receipt: receipt),
                    _nextStepsGap,
                    const NextStepsCard(),
                    AppSpacing.gapV16,
                    RegistrationNotice(message: AppLocaleKey.submissionDisclaimer.tr()),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
