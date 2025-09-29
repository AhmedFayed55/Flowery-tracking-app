import 'package:flowery_tracking_app/core/errors/api_results.dart';
import 'package:flowery_tracking_app/features/auth/apply/domain/entites/driver_entity.dart';
import 'package:flowery_tracking_app/features/auth/apply/domain/entites/request_apply_entity.dart';
import 'package:flowery_tracking_app/features/auth/apply/domain/repo/apply_repo.dart';
import 'package:injectable/injectable.dart';
@injectable
class ApplyUseCase {
  final ApplyRepo _applyRepo;
  ApplyUseCase(this._applyRepo);
  Future<ApiResult<DriverEntity>> call(RequestApplyEntity requestEntity) {
    return _applyRepo.apply(requestEntity);
  }
}
