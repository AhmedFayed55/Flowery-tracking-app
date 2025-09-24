import 'package:flowery_tracking_app/core/errors/api_results.dart';
import 'package:flowery_tracking_app/features/auth/apply/domain/entites/vehicel_entity.dart';
import 'package:flowery_tracking_app/features/auth/apply/domain/repo/apply_repo.dart';

class AllVehiclesUseCase {
  final ApplyRepo _applyRepo;
  AllVehiclesUseCase(this._applyRepo);
  Future<ApiResult<List<VehicelEntity>>> call() async {
    return _applyRepo.vehicles();
  }
}
