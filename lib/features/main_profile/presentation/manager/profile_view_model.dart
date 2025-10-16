import 'package:flowery_tracking_app/core/errors/api_results.dart';
import 'package:flowery_tracking_app/features/main_profile/domain/entities/driver_dto_entity.dart';
import 'package:flowery_tracking_app/features/main_profile/domain/entities/logout_response_entity.dart';
import 'package:flowery_tracking_app/features/main_profile/domain/entities/vehicle_dto_entity.dart';
import 'package:flowery_tracking_app/features/main_profile/domain/usecases/logout_usecase.dart';
import 'package:flowery_tracking_app/features/main_profile/domain/usecases/profile_usecase.dart';
import 'package:flowery_tracking_app/features/main_profile/presentation/manager/profile_event.dart';
import 'package:flowery_tracking_app/features/main_profile/presentation/manager/profile_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class ProfileCubit extends Cubit<ProfileState> {
  final ProfileUseCase profileUseCase;
  final LogoutUseCase logoutUseCase;

  ProfileCubit(this.logoutUseCase, {required this.profileUseCase})
    : super(ProfileState());

  Future<void> doIntent(ProfileEvent event) async {
    switch (event) {
      case GetProfileEvent():
        await _getProfile();
        break;
      case LogoutEvent():
        _logout();
    }
  }

  Future<void> _logout() async {
    emit(state.copyWith(isSuccessLogout: false, errorMsgLogout: null));

    var result = await logoutUseCase.invoke();

    switch (result) {
      case ApiSuccessResult<LogoutResponseEntity>():
        emit(state.copyWith(isSuccessLogout: true));
        break;
      case ApiErrorResult<LogoutResponseEntity>():
        emit(state.copyWith(errorMsgLogout: result.failure.errorMessage));
    }
  }

  Future<void> _getProfile() async {
    emit(state.copyWith(isLoading: true));
    var driverResult = await profileUseCase.getProfile();
    switch (driverResult) {
      case ApiSuccessResult<DriverDtoEntity>():
        final result = driverResult.data;
        emit(
          state.copyWith(
            isLoading: false,
            isSuccess: true,
            driverDtoEntity: result,
          ),
        );
        final vehicleType = driverResult.data.vehicleType;
        if (vehicleType == null || vehicleType.isEmpty) {
          emit(state.copyWith(isLoading: false,isSuccess: true, isError: true,showMessage: "vehicle not found"));
          return;
        }
        var vehicleResult = await profileUseCase.getVehicle(vehicleType);
        switch (vehicleResult) {
          case ApiSuccessResult<VehicleDtoEntity>():
            emit(
              state.copyWith(
                isLoading: false,
                isSuccess: true,
                vehicleDtoEntity: vehicleResult.data,
              ),
            );
            break;
          case ApiErrorResult<VehicleDtoEntity>():
            emit(state.copyWith(isLoading: false, isError: true,isSuccess: false));
        }
        break;
      case ApiErrorResult<DriverDtoEntity>():
        emit(state.copyWith(isLoading: false, isError: true,showMessage: driverResult.failure.errorMessage));
    }
  }
}
