import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flowery_tracking_app/core/errors/firebase_result.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group("safeFirebaseCall", () {
    test("returns FirebaseSuccessResult when firebaseCall succeeds", () async {
      Future<String> mockFirebaseCall() async => "Data loaded";

      final result = await safeFirebaseCall(mockFirebaseCall);

      expect(result, isA<FirebaseSuccessResult<String>>());
      expect((result as FirebaseSuccessResult).data, "Data loaded");
    });

    test(
      "returns FirebaseErrorResult with Failure when FirebaseException is thrown",
      () async {
        Future<String> mockFirebaseCall() async {
          throw FirebaseException(
            plugin: 'cloud_firestore',
            message: "Permission denied",
          );
        }

        final result = await safeFirebaseCall(mockFirebaseCall);

        expect(result, isA<FirebaseErrorResult<String>>());
      },
    );

    test(
      "returns FirebaseErrorResult with Failure when generic exception is thrown",
      () async {
        Future<String> mockFirebaseCall() async {
          throw Exception("Unexpected Firestore error");
        }

        final result = await safeFirebaseCall(mockFirebaseCall);

        expect(result, isA<FirebaseErrorResult<String>>());
        expect(
          (result as FirebaseErrorResult).failure.errorMessage,
          contains("Unexpected Firestore error"),
        );
      },
    );
  });
}
