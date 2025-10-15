import 'package:flutter_test/flutter_test.dart';
import 'package:flowery_tracking_app/features/auth/change_password/data/mapper/mapper_request_to_dto.dart';
import 'package:flowery_tracking_app/features/auth/change_password/data/model/request/change_password_request_dto.dart';
import 'package:flowery_tracking_app/features/auth/change_password/domain/entities/change_password_request_entity.dart';

void main() {
  group('ChangePasswordRequestEntityMapper', () {
    test(
      'should map ChangePasswordRequestEntity to ChangePasswordRequestDto correctly',
      () {
        final entity = ChangePasswordRequestEntity(
          oldPassword: 'old123',
          newPassword: 'new456',
        );

        final dto = entity.toDtoChangePassword();

        expect(dto, isA<ChangePasswordRequestDto>());
        expect(dto.password, equals('old123'));
        expect(dto.newPassword, equals('new456'));
      },
    );
  });
}
