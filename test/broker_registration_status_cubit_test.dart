import 'package:flutter_hr_erb/features/broker_registration/data/model/broker_registration_receipt.dart';
import 'package:flutter_hr_erb/features/broker_registration/data/model/broker_review_status.dart';
import 'package:flutter_hr_erb/features/broker_registration/presentation/controller/broker_registration_status_cubit.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final submittedAt = DateTime(2026, 11, 1, 9);
  final previewedAt = DateTime(2026, 11, 3, 14);
  late BrokerRegistrationStatusCubit cubit;

  setUp(() {
    cubit = BrokerRegistrationStatusCubit(
      receipt: BrokerRegistrationReceipt.issue(submittedAt: submittedAt),
      now: () => previewedAt,
    );
  });

  tearDown(() => cubit.close());

  test('starts pending, last updated at submission time', () {
    expect(cubit.state.status, BrokerReviewStatus.pendingApproval);
    expect(cubit.state.lastUpdated, submittedAt);
    expect(cubit.state.previewOptions, [
      BrokerReviewStatus.correctionRequired,
      BrokerReviewStatus.approved,
    ]);
  });

  test('previewing a status switches it and stamps last updated', () {
    cubit.previewStatus(BrokerReviewStatus.approved);

    expect(cubit.state.status, BrokerReviewStatus.approved);
    expect(cubit.state.lastUpdated, previewedAt);
    expect(cubit.state.previewOptions, [
      BrokerReviewStatus.pendingApproval,
      BrokerReviewStatus.correctionRequired,
    ]);
  });

  test('previewing the current status does nothing', () async {
    final emitted = <BrokerRegistrationStatusState>[];
    final subscription = cubit.stream.listen(emitted.add);

    cubit.previewStatus(BrokerReviewStatus.pendingApproval);
    await Future<void>.delayed(Duration.zero);

    expect(emitted, isEmpty);
    await subscription.cancel();
  });

  test('keeps the receipt across status changes', () {
    final receipt = cubit.state.receipt;

    cubit.previewStatus(BrokerReviewStatus.correctionRequired);

    expect(cubit.state.receipt, receipt);
  });
}
