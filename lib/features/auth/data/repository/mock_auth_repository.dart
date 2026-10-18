import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../model/verify_code_args.dart';
import 'auth_repository.dart';

class MockAuthRepository implements AuthRepository {
  const MockAuthRepository();

  static const validCode = '123456';
  static const _latency = Duration(milliseconds: 800);

  @override
  Future<Either<Failure, Unit>> sendVerificationCode(VerifyCodeArgs args) async {
    await Future<void>.delayed(_latency);
    return const Right(unit);
  }

  @override
  Future<Either<Failure, Unit>> verifyCode(VerifyCodeArgs args, String code) async {
    await Future<void>.delayed(_latency);
    return code == validCode ? const Right(unit) : Left(ServerFailure(''));
  }
}
