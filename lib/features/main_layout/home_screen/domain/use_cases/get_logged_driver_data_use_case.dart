import 'package:flowery_tracking_app/core/errors/api_results.dart';
import 'package:flowery_tracking_app/features/main_layout/home_screen/domain/entities/logged_driver_data/driver_data_entity.dart';
import 'package:flowery_tracking_app/features/main_layout/home_screen/domain/repositories/home_tab_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetLoggedDriverDataUseCase{
  final HomeTabRepo _repo;
  GetLoggedDriverDataUseCase(this._repo);

  Future<ApiResult<DriverDataEntity>> invoke() => _repo.getLoggedDriverData();

}