import 'package:flowery_tracking_app/core/errors/api_results.dart';
import 'package:flowery_tracking_app/features/edit_profile/domain/entities/response/get_logged_driver_response_entity.dart';
import 'package:flowery_tracking_app/features/edit_profile/domain/repositories/edit_profile_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetLoggedDriverUseCase {
  final EditProfileRepo _profileRepo;

  GetLoggedDriverUseCase(this._profileRepo);

  Future<ApiResult<GetLoggedDriverResponseEntity>> call() async {
    return await _profileRepo.getLoggedUserData();
  }
}
