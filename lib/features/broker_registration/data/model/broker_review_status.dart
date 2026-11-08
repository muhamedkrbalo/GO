import '../../../../core/locale/app_locale_key.dart';

enum BrokerReviewStatus {
  pendingApproval(
    AppLocaleKey.pendingApproval,
    AppLocaleKey.brokerQueuedForReviewMessage,
    AppLocaleKey.previewPending,
  ),
  correctionRequired(
    AppLocaleKey.correctionRequired,
    AppLocaleKey.brokerCorrectionMessage,
    AppLocaleKey.previewCorrection,
  ),
  approved(AppLocaleKey.approved, AppLocaleKey.brokerApprovedMessage, AppLocaleKey.previewApproved);

  const BrokerReviewStatus(this.labelKey, this.messageKey, this.previewKey);

  final String labelKey;
  final String messageKey;
  final String previewKey;
}
