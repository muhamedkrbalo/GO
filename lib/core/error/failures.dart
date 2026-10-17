import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';

import '../locale/app_locale_key.dart';
import '../network/status_code.dart';

abstract class Failure {
  final String errMessage;

  const Failure(this.errMessage);
}

class NetworkFailure extends Failure {
  NetworkFailure([String? errMessage]) : super(errMessage ?? AppLocaleKey.noInternet.tr());
}

class ServerFailure extends Failure {
  ServerFailure(super.errMessage);

  factory ServerFailure.fromDioError(DioException dioError) {
    switch (dioError.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.transformTimeout:
        return ServerFailure(AppLocaleKey.connectionTimeout.tr());
      case DioExceptionType.badResponse:
        return ServerFailure.fromResponse(dioError.response?.statusCode, dioError.response?.data);
      case DioExceptionType.cancel:
        return ServerFailure(AppLocaleKey.requestCancelled.tr());
      case DioExceptionType.connectionError:
        return ServerFailure(AppLocaleKey.noInternet.tr());
      case DioExceptionType.badCertificate:
      case DioExceptionType.unknown:
        return ServerFailure(AppLocaleKey.errorOccurred.tr());
    }
  }

  factory ServerFailure.fromResponse(int? statusCode, dynamic response) {
    if (statusCode == StatusCode.badRequest ||
        statusCode == StatusCode.unauthorized ||
        statusCode == StatusCode.forbidden ||
        statusCode == StatusCode.unprocessable) {
      final message = _extractMessage(response);
      if (message != null) return ServerFailure(message);
    } else if (statusCode == StatusCode.notFound) {
      return ServerFailure(AppLocaleKey.resourceNotFound.tr());
    } else if (statusCode != null && statusCode >= StatusCode.internalServerError) {
      return ServerFailure(AppLocaleKey.serverError.tr());
    }
    return ServerFailure(AppLocaleKey.errorOccurred.tr());
  }

  /// Reads the API error message, tolerating bodies that are not JSON maps
  /// (e.g. an HTML error page from a proxy).
  static String? _extractMessage(dynamic response) {
    if (response is! Map) return null;
    return _firstString(response['errors']) ?? _firstString(response['message']);
  }

  /// Returns [value] if it is a string, or the first string found in a
  /// `{field: [messages]}` / `{field: message}` map.
  static String? _firstString(dynamic value) {
    if (value is String && value.isNotEmpty) return value;
    if (value is Map && value.isNotEmpty) {
      final first = value.values.first;
      if (first is String) return first;
      if (first is List && first.isNotEmpty && first.first is String) return first.first as String;
    }
    return null;
  }
}
