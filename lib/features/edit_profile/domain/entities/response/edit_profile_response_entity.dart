import 'package:flowery_tracking_app/features/edit_profile/domain/entities/driver_entity.dart';

class EditProfileResponseEntity {
  final String message;
  final DriverEntity driver;

  EditProfileResponseEntity({required this.message, required this.driver});
}
