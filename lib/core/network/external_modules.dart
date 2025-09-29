import 'package:dio/dio.dart';
import 'package:flowery_tracking_app/features/auth/apply/data/data_source/gemeni_api_service.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../di/di.dart';
import '../services/token_interceptor.dart';
import 'api_constants.dart';

@module
abstract class ExternalModules {
  @lazySingleton
  Dio provideDio() {
    Dio dio = Dio();
    dio.options.baseUrl = ApiConstants.baseUrl;
    dio.options.headers = {'Content-Type': 'application/json'};
    dio.interceptors.add(getIt.get<PrettyDioLogger>());
    dio.interceptors.add(getIt.get<TokenInterceptor>());
    return dio;
  }

  @lazySingleton
  PrettyDioLogger providePrettyDioLogger() {
    return PrettyDioLogger(
      requestHeader: true,
      requestBody: true,
      responseBody: true,
      responseHeader: false,
      error: true,
      compact: true,
    );
  }

  @preResolve
  Future<SharedPreferences> get provideSharedPreferences async {
    return await SharedPreferences.getInstance();
  }

  @lazySingleton
  FlutterSecureStorage flutterSecureStorage() {
    return const FlutterSecureStorage();
  }

  @lazySingleton
  InternetConnectionChecker provideInternetConnectionChecker() =>
      InternetConnectionChecker.instance;

  @lazySingleton
  @Named("gemini")
  Dio provideGeminiDio() {
    final dio = Dio();
    dio.options.baseUrl = ApiConstants.gemeniBaseUrl;
    dio.options.headers = {
      'Content-Type': 'application/json',
      'X-goog-api-key': "AIzaSyB_Z6BcAjtJeVEzlZfMyuT4XReq3mAf_vQ",
    };
    dio.interceptors.add(getIt.get<PrettyDioLogger>());
    return dio;
  }

  @lazySingleton
  GeminiApiService provideGeminiApiService(@Named("gemini") Dio dio) {
    return GeminiApiService(dio);
  }
}
