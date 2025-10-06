import 'package:flowery_tracking_app/core/errors/api_results.dart';
import 'package:flowery_tracking_app/features/edit_profile/domain/entities/request/edit_vehicle_request_entity.dart';
import 'package:flowery_tracking_app/features/edit_profile/domain/entities/response/edit_profile_response_entity.dart';
import 'package:flowery_tracking_app/features/edit_profile/domain/repositories/edit_profile_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class UpdateVehiclesUseCase {
  final EditProfileRepo _profileRepo;
  UpdateVehiclesUseCase({required EditProfileRepo profileRepo})
    : _profileRepo = profileRepo;
  Future<ApiResult<EditProfileResponseEntity>> invoke(
    EditVehicleRequestEntity editVehicleRequestEntity,
  ) {
    return _profileRepo.updateVehicle(editVehicleRequestEntity);
  }
}
