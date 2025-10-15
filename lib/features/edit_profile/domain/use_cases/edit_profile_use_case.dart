import 'package:flowery_tracking_app/core/errors/api_results.dart';
import 'package:flowery_tracking_app/features/edit_profile/domain/entities/request/edit_profile_request_entity.dart';
import 'package:flowery_tracking_app/features/edit_profile/domain/entities/response/edit_profile_response_entity.dart';
import 'package:flowery_tracking_app/features/edit_profile/domain/repositories/edit_profile_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class EditProfileUseCase {
  final EditProfileRepo _profileRepo;
  EditProfileUseCase({required EditProfileRepo profileRepo})
    : _profileRepo = profileRepo;
  Future<ApiResult<EditProfileResponseEntity>> invoke(
    EditProfileRequestEntity editProfileRequestEntity,
  ) {
    return _profileRepo.editProfile(editProfileRequestEntity);
  }
}
