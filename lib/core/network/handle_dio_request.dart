import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import '../error/failures.dart';
import '../locale/app_locale_key.dart';

Future<Either<Failure, T>> handleDioRequest<T>({required Future<T> Function() request}) async {
  try {
    final response = await request();
    return Right(response);
  } on DioException catch (e) {
    if (e.type == DioExceptionType.connectionError) {
      return Left(NetworkFailure());
    }
    return Left(ServerFailure.fromDioError(e));
  } catch (e, stackTrace) {
    // Usually a parsing bug (e.g. fromJson); log it instead of showing it to the user.
    debugPrint('handleDioRequest: $e\n$stackTrace');
    return Left(ServerFailure(AppLocaleKey.errorOccurred.tr()));
  }
}
