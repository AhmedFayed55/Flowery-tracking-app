import 'package:flowery_tracking_app/core/errors/api_results.dart';
import 'package:flowery_tracking_app/features/main_profile/domain/entities/driver_dto_entity.dart';
import 'package:flowery_tracking_app/features/main_profile/domain/usecases/profile_usecase.dart';
import 'package:flowery_tracking_app/features/main_profile/presentation/manager/profile_event.dart';
import 'package:flowery_tracking_app/features/main_profile/presentation/manager/profile_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class ProfileCubit extends Cubit<ProfileState> {
  final ProfileUseCase profileUseCase;

  ProfileCubit({required this.profileUseCase}) : super(ProfileState());

  Future<void> doIntent(ProfileEvent event) async {
    switch (event) {
      case GetProfileEvent():
        await _getProfile();
        break;
    }
  }

  Future<void> _getProfile() async {
    emit(state.copyWith(isLoading: true));
    var result = await profileUseCase.call();
    switch (result) {
      case ApiSuccessResult<DriverDtoEntity>():
        emit(state.copyWith(isLoading: false, isSuccess: true,driverDtoEntity: result.data));
        break;
      case ApiErrorResult<DriverDtoEntity>():
        emit(
          state.copyWith(
            isLoading: false,
            isError: true,
          ),
        );
    }
  }
}
