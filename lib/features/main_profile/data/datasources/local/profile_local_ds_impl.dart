import 'package:flowery_tracking_app/core/errors/api_results.dart';
import 'package:flowery_tracking_app/features/main_profile/data/datasources/local/profile_local_ds.dart';
import 'package:flowery_tracking_app/features/main_profile/domain/entities/profile_response_entity.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: ProfileLocalDataSource)
class ProfileLocalDataSourceImpl extends ProfileLocalDataSource {
  @override
  Future<ApiResult<ProfileResponseEntity>> getProfile() {
    // TODO: implement getProfile
    throw UnimplementedError();
  }

}
