import 'package:flowery_tracking_app/features/main_profile/domain/entities/driver_dto_entity.dart';
import 'package:flowery_tracking_app/features/main_profile/domain/entities/vehicle_dto_entity.dart';

class ProfileState {
  final bool isLoading;
  final bool isSuccess;
  final bool isError;
  final String? showMessage;
  final DriverDtoEntity? driverDtoEntity;
  final VehicleDtoEntity? vehicleDtoEntity;
  final bool isSuccessLogout;
  final String? errorMsgLogout;

  ProfileState({
    this.isSuccessLogout = false,
    this.errorMsgLogout,
    this.isLoading = false,
    this.isSuccess = false,
    this.isError = false,
    this.showMessage,
    this.driverDtoEntity,
    this.vehicleDtoEntity,
  });

  ProfileState copyWith({
    bool? isLoading,
    bool? isSuccess,
    bool? isError,
    String? showMessage,
    DriverDtoEntity? driverDtoEntity,
    VehicleDtoEntity? vehicleDtoEntity,
    bool? isSuccessLogout,
    String? errorMsgLogout,
  }) {
    return ProfileState(
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      isError: isError ?? this.isError,
      showMessage: showMessage ?? this.showMessage,
      driverDtoEntity: driverDtoEntity ?? this.driverDtoEntity,
      vehicleDtoEntity: vehicleDtoEntity ?? this.vehicleDtoEntity,
      isSuccessLogout: isSuccessLogout ?? this.isSuccessLogout,
      errorMsgLogout: errorMsgLogout ?? this.errorMsgLogout,
    );
  }
}
