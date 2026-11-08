import 'package:flutter_hr_erb/core/enum/id_type.dart';
import 'package:flutter_hr_erb/features/broker_registration/presentation/controller/broker_identity_info_cubit.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late BrokerIdentityInfoCubit cubit;

  setUp(() => cubit = BrokerIdentityInfoCubit());

  tearDown(() => cubit.close());

  test('starts empty and cannot continue', () {
    expect(cubit.state.idType, isNull);
    expect(cubit.state.idNumber, isEmpty);
    expect(cubit.state.canContinue, isFalse);
  });

  test('canContinue is true once type and number are provided', () {
    cubit
      ..selectIdType(IdType.nationalId)
      ..idNumberChanged('29801011234567');

    expect(cubit.state.canContinue, isTrue);
  });

  test('a number without a type cannot continue', () {
    cubit.idNumberChanged('29801011234567');

    expect(cubit.state.canContinue, isFalse);
  });

  test('whitespace-only number does not count as filled', () {
    cubit
      ..selectIdType(IdType.passport)
      ..idNumberChanged('   ');

    expect(cubit.state.canContinue, isFalse);
  });

  test('changing the type clears the previously entered number', () {
    cubit
      ..selectIdType(IdType.nationalId)
      ..idNumberChanged('29801011234567')
      ..selectIdType(IdType.passport);

    expect(cubit.state.idType, IdType.passport);
    expect(cubit.state.idNumber, isEmpty);
  });

  test('reselecting the same type keeps the number', () {
    cubit
      ..selectIdType(IdType.passport)
      ..idNumberChanged('A1234567')
      ..selectIdType(IdType.passport);

    expect(cubit.state.idNumber, 'A1234567');
  });
}
