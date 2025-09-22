import 'package:dio/dio.dart';
import 'package:flowery_tracking_app/core/errors/api_results.dart';
import 'package:flowery_tracking_app/core/errors/failures.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group("safeApiCall", () {
    test("returns ApiSuccessResult when apiCall succeeds", () async {
      Future<String> mockApiCall() async => "Hello";

      final result = await safeApiCall(mockApiCall);

      expect(result, isA<ApiSuccessResult<String>>());
      expect((result as ApiSuccessResult).data, "Hello");
    });

    test(
      "returns ApiErrorResult with ServerFailure when DioException is thrown",
      () async {
        Future<String> mockApiCall() async {
          throw DioException(requestOptions: RequestOptions(path: "/test"));
        }

        final result = await safeApiCall(mockApiCall);

        expect(result, isA<ApiErrorResult<String>>());
        expect((result as ApiErrorResult).failure, isA<ServerFailure>());
      },
    );

    test(
      "returns ApiErrorResult with Failure when generic exception is thrown",
      () async {
        Future<String> mockApiCall() async {
          throw Exception("Unexpected error");
        }

        final result = await safeApiCall(mockApiCall);

        expect(result, isA<ApiErrorResult<String>>());
        expect(
          (result as ApiErrorResult).failure.errorMessage,
          contains("Unexpected error"),
        );
      },
    );
  });
}
