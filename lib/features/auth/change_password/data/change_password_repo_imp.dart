import 'package:flowery_tracking_app/core/errors/api_results.dart';
import 'package:flowery_tracking_app/features/auth/change_password/data/data_source/change_password_ds.dart';
import 'package:flowery_tracking_app/features/auth/change_password/data/mapper/mapper_request_to_dto.dart';
import 'package:flowery_tracking_app/features/auth/change_password/domain/entities/change_password_request_entity.dart';
import 'package:flowery_tracking_app/features/auth/change_password/domain/repo/change_password_repo.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: ChangePasswordRepo)
class ChangePasswordRepoImp implements ChangePasswordRepo {
  final ChangePasswordDataSource changePasswordDataSource;

  ChangePasswordRepoImp({required this.changePasswordDataSource});
  @override
  Future<ApiResult<void>> changePassword(
    ChangePasswordRequestEntity changePasswordRequestEntity,
  ) async {
    return safeApiCall(
      () async => await changePasswordDataSource.changePassword(
        mapperRequestToDto(changePasswordRequestEntity),
      ),
    );
  }
}
