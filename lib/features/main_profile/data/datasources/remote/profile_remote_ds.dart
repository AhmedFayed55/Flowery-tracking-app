import 'package:flowery_tracking_app/features/main_profile/data/models/driver_dto.dart';

abstract class ProfileRemoteDataSource {
  Future<DriverDto> getProfile();
}
