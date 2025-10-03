import 'package:flowery_tracking_app/core/errors/api_results.dart';
import 'package:flowery_tracking_app/core/errors/failures.dart';
import 'package:flowery_tracking_app/features/edit_profile/domain/entities/response/vehicle_entity.dart';
import 'package:flowery_tracking_app/features/edit_profile/domain/entities/response/vehicle_response_entity.dart';
import 'package:flowery_tracking_app/features/edit_profile/domain/use_cases/get_vehicles_use_case.dart';
import 'package:flowery_tracking_app/features/edit_profile/presentation/manger/vehicle_manger/vehicle_event.dart';
import 'package:flowery_tracking_app/features/edit_profile/presentation/manger/vehicle_manger/vehicle_view_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'vehicle_view_model_test.mocks.dart';

@GenerateMocks([AllVehiclesUseCase])
void main() {
  late MockAllVehiclesUseCase mockUseCase;
  late VehicleViewModel vm;

  setUpAll(() {
    provideDummy<ApiResult<VehiclesResponseEntity>>(
      ApiErrorResult(failure: Failure(errorMessage: 'dummy')),
    );
  });

  setUp(() {
    mockUseCase = MockAllVehiclesUseCase();
    vm = VehicleViewModel(mockUseCase);
  });

  test('emits vehicles on success', () async {
    final vehicles = [VehicleEntity(id: 'v1', type: 'Car', image: 'i')];
    when(mockUseCase()).thenAnswer(
      (_) async => ApiSuccessResult(
        data: VehiclesResponseEntity(message: 'ok', vehicles: vehicles),
      ),
    );

    vm.doIntent(GetVehiclesEvent());
    await Future<void>.delayed(Duration.zero);

    expect(vm.state.vehicleEntity, vehicles);
    expect(vm.state.errorMessage, '');
  });

  test('emits errorMessage on failure', () async {
    when(mockUseCase()).thenAnswer(
      (_) async => ApiErrorResult(failure: Failure(errorMessage: 'fail')),
    );

    vm.doIntent(GetVehiclesEvent());
    await Future<void>.delayed(Duration.zero);

    expect(vm.state.errorMessage, 'fail');
    expect(vm.state.vehicleEntity, isNull);
  });
}
