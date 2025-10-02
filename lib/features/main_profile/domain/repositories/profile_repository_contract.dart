import 'package:flowery_tracking_app/core/errors/api_results.dart';
import 'package:flowery_tracking_app/features/main_profile/domain/entities/profile_response_entity.dart';

abstract class ProfileRepositoryContract {
  Future<ApiResult<ProfileResponseEntity>> getProfile();
}
