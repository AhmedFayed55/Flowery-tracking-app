import 'package:flowery_tracking_app/core/errors/api_results.dart';
import 'package:flowery_tracking_app/features/main_profile/domain/entities/profile_response_entity.dart';
import 'package:flowery_tracking_app/features/main_profile/domain/repositories/profile_repository_contract.dart';
import 'package:injectable/injectable.dart';

@injectable
class ProfileUseCase {
  ProfileRepositoryContract profileRepositoryContract;

  ProfileUseCase({required this.profileRepositoryContract});

  Future<ApiResult<ProfileResponseEntity>> call() async {
    var result = await profileRepositoryContract.getProfile();
    return result;
  }
}
