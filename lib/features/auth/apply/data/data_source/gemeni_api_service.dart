import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flowery_tracking_app/core/network/api_constants.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class GeminiApiService {
  final Dio _dio;
 // static const String apiKey = "AIzaSyB_Z6BcAjtJeVEzlZfMyuT4XReq3mAf_vQ";

  GeminiApiService(this._dio) {
    _dio.options.baseUrl = ApiConstants.gemeniBaseUrl;
    _dio.options.headers['X-goog-api-key'] = dotenv.env['GEMINI_API_KEY'];
    _dio.options.headers['Content-Type'] = 'application/json';
  }

  Future<Map<String, dynamic>> sendImage({
    required File image,
    required String instructions,
  }) async {
    final imageBytes = await image.readAsBytes();
    final base64Image = base64Encode(imageBytes);

    final body = {
      "contents": [
        {
          "parts": [
            {"text": instructions},
            {
              "inlineData": {"mimeType": "image/jpeg", "data": base64Image},
            },
          ],
        },
      ],
    };

    final response = await _dio.post(
      ApiConstants.checkPhoto,
      data: jsonEncode(body),
    );

    return response.data;
  }
}
