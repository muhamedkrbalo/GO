import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/network/api_consumer.dart';
import '../model/splash_model.dart';

abstract interface class SplashRepository {
  Future<Either<Failure, SplashModel>> postSplash({
    required String userId,
  });
}

class SplashRepositoryImpl implements SplashRepository {
  const SplashRepositoryImpl(this._apiConsumer);

  // ignore: unused_field — used once postSplash is implemented.
  final ApiConsumer _apiConsumer;

  @override
  Future<Either<Failure, SplashModel>> postSplash({required String userId}) {
    // TODO: implement postSplash, e.g.
    // return handleDioRequest(
    //   request: () async => SplashModel.fromJson(await _apiConsumer.post(EndPoints.x, body: {...})),
    // );
    throw UnimplementedError();
  }
}
