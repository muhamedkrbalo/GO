import 'package:dio/dio.dart';

import '../network/status_code.dart';

abstract class Failure {
  final String errMessage;

  const Failure(this.errMessage);
}

class NetworkFailure extends Failure {
  const NetworkFailure([super.errMessage = 'No Internet Connection']);
}

class ServerFailure extends Failure {
  ServerFailure(super.errMessage);

  factory ServerFailure.fromDioError(DioException dioError) {
    switch (dioError.type) {
      case DioExceptionType.connectionTimeout:
        return ServerFailure('Connection timeout with ApiServer');

      case DioExceptionType.sendTimeout:
        return ServerFailure('Send timeout with ApiServer');

      case DioExceptionType.receiveTimeout:
        return ServerFailure('Receive timeout with ApiServer');

      case DioExceptionType.badResponse:
        return ServerFailure.fromResponse(dioError.response!.statusCode, dioError.response!.data);
      case DioExceptionType.cancel:
        return ServerFailure('Request to ApiServer was canceld');
      case DioExceptionType.connectionError:
        return ServerFailure('No Internet Connection');

      case DioExceptionType.unknown:
        return ServerFailure('Unexpected Error, Please try again!');
      default:
        return ServerFailure('Opps There was an Error, Please try again');
    }
  }

  factory ServerFailure.fromResponse(int? statusCode, dynamic response) {
     if (statusCode == StatusCode.badRequest ||
        statusCode == StatusCode.unauthorized ||
        statusCode == StatusCode.forbidden ||
        statusCode == StatusCode.unprocessable) {
      if (response['errors'] is Map<String, dynamic>) {
        Map<String, dynamic> error = response['errors'];
        return ServerFailure(error.values.first[0]);
      } else if (response['message'] is String) {
        return ServerFailure(response['message']);
      } else if (response['message'] is Map<String, dynamic>) {
        Map<String, dynamic> error = response['message'];
        return ServerFailure(error.values.first[0]);
      } else {
        return ServerFailure('Opps There was an Error, Please try again');
      }
    } else if (statusCode == StatusCode.notFound) {
      return ServerFailure('Your request not found, Please try later!');
    } else if (statusCode == StatusCode.internalServerError) {
      return ServerFailure('Internal Server error, Please try later');
    } else {
      return ServerFailure('Opps There was an Error, Please try again');
    }
  }
}
