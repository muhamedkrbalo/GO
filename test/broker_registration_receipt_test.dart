import 'package:flutter_hr_erb/features/broker_registration/data/model/broker_registration_receipt.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('issue builds a GO-BROKER reference from the submission time', () {
    final submittedAt = DateTime.fromMillisecondsSinceEpoch(1793538407100);

    final receipt = BrokerRegistrationReceipt.issue(submittedAt: submittedAt);

    expect(receipt.referenceNumber, 'GO-BROKER-1793538407100');
    expect(receipt.submittedAt, submittedAt);
  });

  test('receipts issued at different times have different references', () {
    final first = BrokerRegistrationReceipt.issue(submittedAt: DateTime(2026, 11, 1, 10));
    final second = BrokerRegistrationReceipt.issue(submittedAt: DateTime(2026, 11, 1, 11));

    expect(first.referenceNumber, isNot(second.referenceNumber));
  });
}
