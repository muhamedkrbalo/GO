
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import '../network/api_consumer.dart';
import '../network/app_interceptors.dart';
import '../network/connection_checker.dart';
import '../network/connectivity/connectivity_cubit.dart';
import '../network/dio_consumer.dart';
import '../network/token_refresh_service.dart';
import '../cache/secure_storage/secure_storage_service.dart';
import 'location_service.dart';
part 'service_locator.dart';
