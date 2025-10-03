import 'package:flowery_tracking_app/core/errors/api_results.dart';
import 'package:flowery_tracking_app/features/auth/change_password/domain/entities/change_password_request_entity.dart';

abstract class ChangePasswordRepo {
  Future<ApiResult<void>> changePassword(
    ChangePasswordRequestEntity changePasswordRequestEntity,
  );
}
