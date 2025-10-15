import 'package:flowery_tracking_app/core/errors/api_results.dart';
import 'package:flowery_tracking_app/features/auth/change_password/domain/entities/change_password_request_entity.dart';
import 'package:flowery_tracking_app/features/auth/change_password/domain/repo/change_password_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class ChangePasswordUseCase {
  ChangePasswordRepo changePasswordRepo;
  ChangePasswordUseCase({required this.changePasswordRepo});

  Future<ApiResult<void>> call(
    ChangePasswordRequestEntity changePasswordRequestEntity,
  ) {
    return changePasswordRepo.changePassword(changePasswordRequestEntity);
  }
}
