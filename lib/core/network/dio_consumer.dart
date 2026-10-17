import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../config/app_config.dart';
import 'api_consumer.dart';
import 'app_interceptors.dart';

class DioConsumer implements ApiConsumer {
  final Dio client;

  DioConsumer({required this.client, required AppInterceptors interceptors}) {
    assert(AppConfig.baseUrl.isNotEmpty, 'Set AppConfig.baseUrl in lib/core/config/app_config.dart');

    client.options
      ..baseUrl = AppConfig.baseUrl
      ..connectTimeout = AppConfig.connectTimeout
      ..sendTimeout = AppConfig.sendTimeout
      ..receiveTimeout = AppConfig.receiveTimeout
      ..followRedirects = false
      // Content-Type is left to Dio: JSON for maps, multipart (with boundary) for FormData.
      ..headers[Headers.acceptHeader] = Headers.jsonContentType;

    client.interceptors.add(interceptors);
    if (kDebugMode) {
      client.interceptors.add(
        PrettyDioLogger(
          requestHeader: true,
          requestBody: true,
          responseBody: true,
          responseHeader: false,
          compact: false,
          error: true,
          request: true,
        ),
      );
    }
  }

  @override
  Future<Map<String, dynamic>> get(String path, {Map<String, dynamic>? queryParameters}) async {
    final response = await client.get(path, queryParameters: queryParameters);
    return _asJsonObject(response);
  }

  @override
  Future<Map<String, dynamic>> post(
    String path, {
    Map<String, dynamic>? body,
    Map<String, dynamic>? queryParameters,
    bool? isFormData,
  }) async {
    final response = await client.post(
      path,
      data: isFormData == true ? FormData.fromMap(body!) : body,
      queryParameters: queryParameters,
    );
    return _asJsonObject(response);
  }

  @override
  Future<Map<String, dynamic>> put(
    String path, {
    Map<String, dynamic>? body,
    Map<String, dynamic>? queryParameters,
    bool? isFormData,
  }) async {
    final response = await client.put(
      path,
      data: isFormData == true ? FormData.fromMap(body!) : body,
      queryParameters: queryParameters,
    );
    return _asJsonObject(response);
  }

  @override
  Future<Map<String, dynamic>> patch(
    String path, {
    Map<String, dynamic>? body,
    Map<String, dynamic>? queryParameters,
  }) async {
    final response = await client.patch(path, data: body, queryParameters: queryParameters);
    return _asJsonObject(response);
  }

  @override
  Future<Map<String, dynamic>> delete(
    String path, {
    Map<String, dynamic>? body,
    Map<String, dynamic>? queryParameters,
    bool? isFormData,
  }) async {
    final response = await client.delete(
      path,
      data: isFormData == true ? FormData.fromMap(body!) : body,
      queryParameters: queryParameters,
    );
    return _asJsonObject(response);
  }

  /// Empty bodies (e.g. 204 No Content) become `{}`; anything that is not a
  /// JSON object throws, and handleDioRequest reports it as a Failure.
  Map<String, dynamic> _asJsonObject(Response response) {
    final data = response.data;
    if (data == null || (data is String && data.isEmpty)) return <String, dynamic>{};
    if (data is Map<String, dynamic>) return data;
    throw FormatException(
      'Expected a JSON object from ${response.requestOptions.path}, got ${data.runtimeType}',
    );
  }
}
