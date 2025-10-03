import 'package:flowery_tracking_app/features/auth/apply/data/model/request/apply_request_dto.dart';
import 'package:flowery_tracking_app/features/auth/apply/data/model/responce/apply_responce_dto.dart';
import 'package:flowery_tracking_app/features/auth/apply/data/model/responce/vehicel_responce_dto.dart';

abstract class ApplyRemotDataSource {
  Future<ApplyResponceDto> applyDriver(ApplyRequestDto applyRequestDto);
  Future<VehiclesResponseDto> getvehicles();
  // Future<Map<String, dynamic>> verifyLicense(File license);
  // Future<Map<String, dynamic>> verifyID(File imageId);
}
