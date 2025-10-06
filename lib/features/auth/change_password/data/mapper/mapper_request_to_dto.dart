import 'package:flowery_tracking_app/features/auth/change_password/data/model/request/change_password_request_dto.dart';
import 'package:flowery_tracking_app/features/auth/change_password/domain/entities/change_password_request_entity.dart';

// ChangePasswordRequestDto mapperRequestToDto(
//   ChangePasswordRequestEntity changePasswordRequestEntity,
// ) {
//   return ChangePasswordRequestDto(
//     password: changePasswordRequestEntity.oldPassword,
//     newPassword: changePasswordRequestEntity.newPassword,
//   );
// }

extension ChangePasswordRequestEntityMapper on ChangePasswordRequestEntity {
  ChangePasswordRequestDto toDtoChangePassword() {
    return ChangePasswordRequestDto(
      password: oldPassword,
      newPassword: newPassword,
    );
  }
}
