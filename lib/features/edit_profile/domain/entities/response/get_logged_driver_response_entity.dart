import 'package:flowery_tracking_app/features/edit_profile/domain/entities/driver_entity.dart';

class GetLoggedDriverResponseEntity {
  final String message;
  final DriverEntity driver;

  GetLoggedDriverResponseEntity({required this.message, required this.driver});
}
