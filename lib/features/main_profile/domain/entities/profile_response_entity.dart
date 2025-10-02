import 'package:flowery_tracking_app/features/main_profile/domain/entities/driver_dto_entity.dart';

class ProfileResponseEntity {
  final String? message;

  final DriverDtoEntity? driverDtoEntity;

  ProfileResponseEntity({this.message, this.driverDtoEntity});
}
