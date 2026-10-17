import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../model/splash_model.dart';
import '../../../../core/network/api_consumer.dart';




abstract interface class SplashRepository {

  Future<Either<Failure, SplashModel>> postSplash({
    required String userId,
  });
}


class SplashRepositoryImpl implements SplashRepository {
  final ApiConsumer apiConsumer;
  const SplashRepositoryImpl (this.apiConsumer);

  @override
  Future<Either<Failure, SplashModel>> postSplash({required String userId}) {
    // TODO: implement postAuth
    throw UnimplementedError();
  }
}

