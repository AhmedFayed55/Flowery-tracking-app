import 'package:flowery_tracking_app/core/errors/api_results.dart';
import 'package:flowery_tracking_app/features/edit_profile/domain/entities/response/vehicle_response_entity.dart';
import 'package:flowery_tracking_app/features/edit_profile/domain/repositories/edit_profile_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class AllVehiclesUseCase {
  final EditProfileRepo _editProfileRepo;
  AllVehiclesUseCase(this._editProfileRepo);
  Future<ApiResult<VehiclesResponseEntity>> call() async {
    return _editProfileRepo.getVehicles();
  }
}
