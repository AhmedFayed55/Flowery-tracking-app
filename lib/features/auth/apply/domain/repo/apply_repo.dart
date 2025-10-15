import 'package:flowery_tracking_app/core/errors/api_results.dart';
import 'package:flowery_tracking_app/features/auth/apply/domain/entites/driver_entity.dart';
import 'package:flowery_tracking_app/features/auth/apply/domain/entites/request_apply_entity.dart';
import 'package:flowery_tracking_app/features/auth/apply/domain/entites/vehicel_entity.dart';

abstract class ApplyRepo {
  Future<ApiResult<DriverEntity>> apply(RequestApplyEntity requestEntity);
  Future<ApiResult<List<VehicelEntity>>> vehicles();
}
