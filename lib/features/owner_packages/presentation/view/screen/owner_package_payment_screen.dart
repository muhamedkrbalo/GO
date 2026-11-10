import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../../core/custom_widgets/accent_notice/accent_notice.dart';
import '../../../../../core/custom_widgets/custom_app_bar/custom_app_bar.dart';
import '../../../../../core/locale/app_locale_key.dart';
import '../../../../../core/theme/app_sizes.dart';
import '../../../../../core/theme/extensions/theme_extensions.dart';
import '../../../data/model/owner_package.dart';
import '../widget/owner_packages_intro.dart';
import '../widget/package_payment_bottom_bar.dart';
import '../widget/package_selection_summary_card.dart';
import '../widget/payment_method_selector.dart';

class OwnerPackagePaymentScreen extends StatelessWidget {
  const OwnerPackagePaymentScreen({super.key, required this.package});

  final OwnerPackage package;

  static const _contentPadding = EdgeInsetsDirectional.fromSTEB(21, 27, 21, 34);
  static const _noticeGap = SizedBox(height: 14);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.customColors.canvas,
      appBar: CustomAppBar(title: AppLocaleKey.paymentDetails.tr()),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: _contentPadding,
              children: [
                OwnerPackagesIntro(
                  eyebrow: AppLocaleKey.subscriptionPayment.tr(),
                  title: AppLocaleKey.completeYourPayment.tr(),
                  subtitle: AppLocaleKey.paymentDetailsDescription.tr(),
                ),
                AppSpacing.gapV20,
                PackageSelectionSummaryCard(package: package, isCompact: true, showDuration: false),
                AppSpacing.gapV16,
                const PaymentMethodSelector(),
                _noticeGap,
                AccentNotice(message: AppLocaleKey.paymentPendingNotice.tr()),
              ],
            ),
          ),
          const PackagePaymentBottomBar(),
        ],
      ),
    );
  }
}
