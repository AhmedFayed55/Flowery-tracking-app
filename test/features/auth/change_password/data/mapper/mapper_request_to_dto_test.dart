import 'package:flowery_tracking_app/features/auth/change_password/data/mapper/mapper_request_to_dto.dart';
import 'package:flowery_tracking_app/features/auth/change_password/domain/entities/change_password_request_entity.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  ChangePasswordRequestEntity mockChangePasswordRequestEntity =
      ChangePasswordRequestEntity(
        newPassword: 'newPassword',
        oldPassword: 'oldPassword',
      );
  test('verify when call mappertodto is should return dto', () {
    var result = mapperRequestToDto(mockChangePasswordRequestEntity);
    expect(result.newPassword, mockChangePasswordRequestEntity.newPassword);
    expect(result.password, mockChangePasswordRequestEntity.oldPassword);
  });
}
