import 'package:flowery_tracking_app/core/errors/api_results.dart';
import 'package:flowery_tracking_app/features/main_profile/data/datasources/local/profile_local_ds.dart';
import 'package:flowery_tracking_app/features/main_profile/data/datasources/remote/profile_remote_ds.dart';
import 'package:flowery_tracking_app/features/main_profile/domain/entities/profile_response_entity.dart';
import 'package:flowery_tracking_app/features/main_profile/domain/repositories/profile_repository_contract.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: ProfileRepositoryContract)
class ProfileRepositoryImpl extends ProfileRepositoryContract {
  ProfileRemoteDataSource profileRemoteDataSource;
  ProfileLocalDataSource profileLocalDataSource;

  ProfileRepositoryImpl({
    required this.profileRemoteDataSource,
    required this.profileLocalDataSource,
  });

  @override
  Future<ApiResult<ProfileResponseEntity>> getProfile() async {
    var result = await profileRemoteDataSource.getProfile();
    return result;
  }
}
