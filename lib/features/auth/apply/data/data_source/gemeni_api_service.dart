// import 'dart:convert';
// import 'dart:io';
// import 'package:dio/dio.dart';
// import 'package:flowery_tracking_app/core/network/api_constants.dart';

// class GeminiApiService {
//   final Dio _dio;
//   static const String apiKey = "AIzaSyCY4vXcKoksoMn9IpzyPjHLZSYzBkqnM84";

//   GeminiApiService(this._dio) {
//     _dio.options.baseUrl = ApiConstants.gemeniBaseUrl; // تأكد إنه يحتوي https://generativelanguage.googleapis.com/v1beta/
//     _dio.options.headers['X-goog-api-key'] = apiKey;
//     _dio.options.headers['Content-Type'] = 'application/json';
//   }

//   Future<Map<String, dynamic>> sendImage({
//     required File image,
//     required String instructions,
//   }) async {
//     final imageBytes = await image.readAsBytes();
//     final base64Image = base64Encode(imageBytes);

//     // Array of prompts: نص + صورة
//     final body = {
//       "prompt": [
//         {
//           "type": "TEXT",
//           "content": instructions,
//         },
//         {
//           "type": "IMAGE",
//           "content": base64Image,
//         }
//       ],
//       "temperature": 0.0,
//     };

//     final response = await _dio.post(
//       "models/text-bison-001:generate",
//       data: jsonEncode(body),
//     );

//     return response.data;
//   }
// }
