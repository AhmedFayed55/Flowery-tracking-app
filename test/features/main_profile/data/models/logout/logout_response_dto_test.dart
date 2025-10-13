import 'package:flowery_tracking_app/features/main_profile/data/models/logout/logout_response_dto.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('when call toEntity with null values should return null values', () {
    LogoutResponseDto dto = LogoutResponseDto(error: null, message: null);

    var entity = dto.toEntity();

    expect(entity.error, null);
    expect(entity.message, null);
  });

  test('when call toEntity with non-null values should return correct values', () {
    LogoutResponseDto dto = LogoutResponseDto(error: "error", message: "success");

    var entity = dto.toEntity();

    expect(entity.error, dto.error);
    expect(entity.message, dto.message);
  });

}