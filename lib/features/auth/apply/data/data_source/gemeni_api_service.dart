import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flowery_tracking_app/core/network/api_constants.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class GeminiApiService {
  final Dio _dio;

  GeminiApiService(this._dio) {
    _dio.options.baseUrl =
        ApiConstants.gemeniBaseUrl;
    _dio.options.headers['X-goog-api-key'] = dotenv.env['GEMINI_API_KEY']!;
  }

  Future<Map<String, dynamic>> sendImage({
    required File image,
    required String instructions,
  }) async {
    final formData = FormData.fromMap({
      "input_image": await MultipartFile.fromFile(
        image.path,
        filename: image.uri.pathSegments.last,
      ),
      "instructions": instructions,
    });

    final response = await _dio.post(
      "generateContent",
      data: formData,
    );

    return response.data;
  }
}
