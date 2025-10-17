import 'package:flowery_tracking_app/features/auth/change_password/data/model/request/change_password_request_dto.dart';
import 'package:flowery_tracking_app/features/auth/change_password/data/model/response/change_password_response_dto.dart';

abstract class ChangePasswordDataSource {
  Future<ChangePasswordResponseDto> changePassword(
    ChangePasswordRequestDto changePasswordRequestDto,
  );
}
