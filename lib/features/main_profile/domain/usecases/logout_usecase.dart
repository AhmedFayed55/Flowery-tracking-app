import 'package:flowery_tracking_app/core/errors/api_results.dart';
import 'package:flowery_tracking_app/features/main_profile/domain/entities/logout_response_entity.dart';
import 'package:flowery_tracking_app/features/main_profile/domain/repositories/profile_repository_contract.dart';
import 'package:injectable/injectable.dart';

@injectable
class LogoutUseCase{
  final ProfileRepositoryContract _repo;
  LogoutUseCase(this._repo);

  Future<ApiResult<LogoutResponseEntity>> invoke() => _repo.logout();

}