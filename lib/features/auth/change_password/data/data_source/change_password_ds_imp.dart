import 'package:flowery_tracking_app/core/network/api_services.dart';
import 'package:flowery_tracking_app/features/auth/change_password/data/data_source/change_password_ds.dart';
import 'package:flowery_tracking_app/features/auth/change_password/data/model/request/change_password_request_dto.dart';
import 'package:flowery_tracking_app/features/auth/change_password/data/model/response/change_password_response_dto.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: ChangePasswordDataSource)
class ChangePasswordDataSourceImp implements ChangePasswordDataSource {
  final ApiServices _apiServices;
  ChangePasswordDataSourceImp(this._apiServices);
  @override
  Future<ChangePasswordResponseDto> changePassword(
    ChangePasswordRequestDto changePasswordRequestDto,
  ) {
    return _apiServices.changePassword(changePasswordRequestDto);
  }
}
