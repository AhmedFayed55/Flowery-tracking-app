import 'package:flowery_tracking_app/features/main_profile/domain/entities/driver_dto_entity.dart';

class ProfileState {
  final bool isLoading;
  final bool isSuccess;
  final bool isError;
  final DriverDtoEntity? driverDtoEntity;

  ProfileState({
    this.isLoading = false,
    this.isSuccess = false,
    this.isError = false,
    this.driverDtoEntity,
  });

  ProfileState copyWith({
    bool? isLoading,
    bool? isSuccess,
    bool? isError,
    DriverDtoEntity? driverDtoEntity,
  }) {
    return ProfileState(
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      isError: isError ?? this.isError,
      driverDtoEntity: driverDtoEntity ?? this.driverDtoEntity,
    );
  }
}
