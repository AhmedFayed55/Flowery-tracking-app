import 'package:flowery_tracking_app/features/auth/change_password/domain/entities/change_password_request_entity.dart';

sealed class ChangePassword {}

class ChangePasswordEvent extends ChangePassword {
  ChangePasswordRequestEntity changePasswordRequestEntity;
  ChangePasswordEvent(this.changePasswordRequestEntity);
}
