import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/locale/app_locale_key.dart';
import '../../../../../core/theme/extensions/theme_extensions.dart';
import '../../controller/owner_documents_cubit.dart';
import 'registration_info_strip.dart';

class DocumentsSummaryStrip extends StatelessWidget {
  const DocumentsSummaryStrip({super.key});

  static const _radius = 12.0;
  static const _minHeight = 66.0;

  @override
  Widget build(BuildContext context) {
    return BlocSelector<OwnerDocumentsCubit, OwnerDocumentsState, (int, int, int, int, bool)>(
      selector: (state) => (
        state.ownerUploadedCount,
        state.ownerTotal,
        state.unitUploadedCount,
        state.unitTotal,
        state.isComplete,
      ),
      builder: (context, summary) {
        final (ownerUploaded, ownerTotal, unitUploaded, unitTotal, isComplete) = summary;
        return RegistrationInfoStrip(
          radius: _radius,
          minHeight: _minHeight,
          valueColor: context.customColors.textPrimary,
          items: [
            InfoStripItem(
              label: AppLocaleKey.ownerDocuments.tr(),
              value: AppLocaleKey.uploadedCount.tr(args: ['$ownerUploaded', '$ownerTotal']),
            ),
            InfoStripItem(
              label: AppLocaleKey.unitDocuments.tr(),
              value: AppLocaleKey.uploadedCount.tr(args: ['$unitUploaded', '$unitTotal']),
            ),
            InfoStripItem(
              label: AppLocaleKey.overallStatus.tr(),
              value: isComplete
                  ? AppLocaleKey.readyForReview.tr()
                  : AppLocaleKey.documentsRequired.tr(),
            ),
          ],
        );
      },
    );
  }
}
