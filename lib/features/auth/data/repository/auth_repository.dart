import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/network/api_consumer.dart';
import '../../../../core/network/end_points.dart';
import '../../../../core/network/handle_dio_request.dart';
import '../model/verify_code_args.dart';

abstract interface class AuthRepository {
  Future<Either<Failure, Unit>> sendVerificationCode(VerifyCodeArgs args);

  Future<Either<Failure, Unit>> verifyCode(VerifyCodeArgs args, String code);
}

class AuthRepositoryImpl implements AuthRepository {
  const AuthRepositoryImpl(this._apiConsumer);

  final ApiConsumer _apiConsumer;

  @override
  Future<Either<Failure, Unit>> sendVerificationCode(VerifyCodeArgs args) {
    return handleDioRequest(
      request: () async {
        await _apiConsumer.post(EndPoints.sendVerificationCode, body: args.toJson());
        return unit;
      },
    );
  }

  @override
  Future<Either<Failure, Unit>> verifyCode(VerifyCodeArgs args, String code) {
    return handleDioRequest(
      request: () async {
        await _apiConsumer.post(EndPoints.verifyCode, body: {...args.toJson(), 'code': code});
        return unit;
      },
    );
  }
}
