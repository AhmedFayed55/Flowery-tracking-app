import 'package:flowery_tracking_app/features/edit_profile/domain/entities/response/vehicle_entity.dart';

class VehiclesResponseEntity {
  final String message;
  final List<VehicleEntity> vehicles;

  VehiclesResponseEntity({required this.message, required this.vehicles});
}
