import 'package:flutter_hr_erb/features/broker_registration/data/model/broker_type.dart';
import 'package:flutter_hr_erb/features/broker_registration/presentation/controller/broker_type_cubit.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late BrokerTypeCubit cubit;

  setUp(() => cubit = BrokerTypeCubit());

  tearDown(() => cubit.close());

  test('starts with no broker type selected', () {
    expect(cubit.state, isNull);
  });

  test('selectType emits the chosen broker type', () {
    cubit.selectType(BrokerType.company);

    expect(cubit.state, BrokerType.company);
  });

  test('selecting another type replaces the previous selection', () async {
    final emitted = <BrokerType?>[];
    final subscription = cubit.stream.listen(emitted.add);

    cubit
      ..selectType(BrokerType.individual)
      ..selectType(BrokerType.company);
    await Future<void>.delayed(Duration.zero);

    expect(emitted, [BrokerType.individual, BrokerType.company]);
    await subscription.cancel();
  });
}
