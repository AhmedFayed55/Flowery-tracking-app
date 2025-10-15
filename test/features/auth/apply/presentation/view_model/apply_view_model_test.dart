import 'dart:io';
import 'package:bloc_test/bloc_test.dart';
import 'package:flowery_tracking_app/features/auth/apply/domain/usecase/all_vehicles_use_case.dart';
import 'package:flowery_tracking_app/features/auth/apply/domain/usecase/apply_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:flowery_tracking_app/core/errors/api_results.dart';
import 'package:flowery_tracking_app/core/errors/failures.dart';
import 'package:flowery_tracking_app/features/auth/apply/domain/entites/driver_entity.dart';
import 'package:flowery_tracking_app/features/auth/apply/domain/entites/request_apply_entity.dart';
import 'package:flowery_tracking_app/features/auth/apply/domain/entites/vehicel_entity.dart';
import 'package:flowery_tracking_app/features/auth/apply/presentation/view_model/apply_event.dart';
import 'package:flowery_tracking_app/features/auth/apply/presentation/view_model/apply_state.dart';
import 'package:flowery_tracking_app/features/auth/apply/presentation/view_model/apply_view_model.dart';
import 'apply_view_model_test.mocks.dart';

@GenerateMocks([ApplyUseCase, AllVehiclesUseCase])
void main() {
  late MockApplyUseCase mockApplyUseCase;
  late MockAllVehiclesUseCase mockAllVehiclesUseCase;
  late ApplyViewModel viewModel;
  setUpAll(() {
    provideDummy<ApiResult<List<VehicelEntity>>>(ApiSuccessResult(data: []));

    provideDummy<ApiResult<DriverEntity>>(
      ApiSuccessResult(
        data: DriverEntity(
          id: '',
          firstName: '',
          lastName: '',
          country: '',
          vehicleType: '',
          vehicleNumber: '',
          vehicleLicense: '',
          nID: '',
          nIDImg: '',
          email: '',
          gender: '',
          phone: '',
          photo: '',
        ),
      ),
    );
  });

  setUp(() {
    mockApplyUseCase = MockApplyUseCase();
    mockAllVehiclesUseCase = MockAllVehiclesUseCase();
    viewModel = ApplyViewModel(mockApplyUseCase, mockAllVehiclesUseCase);
  });

  group('ApplyViewModel - GetVehiclesEvent', () {
    final fakeVehicles = [
      VehicelEntity(id: '1', type: 'Sedan', image: ''),
      VehicelEntity(id: '2', type: 'MiniBus', image: ''),
    ];

    blocTest<ApplyViewModel, ApplyState>(
      'emits state with vehicles when success',
      build: () {
        when(
          mockAllVehiclesUseCase(),
        ).thenAnswer((_) async => ApiSuccessResult(data: fakeVehicles));
        return viewModel;
      },
      act: (vm) => vm.doIntent(GetVehiclesEvent()),
      expect: () => [
        predicate<ApplyState>(
          (s) => s.vehicelEntity == fakeVehicles && s.errorMessage.isEmpty,
        ),
      ],
    );

    blocTest<ApplyViewModel, ApplyState>(
      'emits state with errorMessage when failure',
      build: () {
        when(mockAllVehiclesUseCase()).thenAnswer(
          (_) async =>
              ApiErrorResult(failure: Failure(errorMessage: 'server error')),
        );
        return viewModel;
      },
      act: (vm) => vm.doIntent(GetVehiclesEvent()),
      expect: () => [
        predicate<ApplyState>((s) => s.errorMessage == 'server error'),
      ],
    );
  });

  group('ApplyViewModel - ApplyDriverEvent', () {
    final request = RequestApplyEntity(
      country: '',
      firstName: '',
      lastName: '',
      vehicleType: '',
      vehicleNumber: '',
      nID: '',
      email: '',
      gender: '',
      phone: '',
      password: '',
      rePassword: '',
      vehicleLicense: File('path'),
      nIDImg: File('path'),
    );

    final driver = DriverEntity(
      id: '1',
      firstName: "Yahya",
      country: '',
      lastName: '',
      vehicleType: '',
      vehicleNumber: '',
      vehicleLicense: '',
      nID: '',
      nIDImg: '',
      email: '',
      gender: '',
      phone: '',
      photo: '',
    );

    blocTest<ApplyViewModel, ApplyState>(
      'emits driver when apply success',
      build: () {
        when(
          mockApplyUseCase(request),
        ).thenAnswer((_) async => ApiSuccessResult(data: driver));
        return viewModel;
      },
      act: (vm) => vm.doIntent(ApplyDriverEvent(request)),
      expect: () => [
        predicate<ApplyState>(
          (s) => s.isLoading == true && s.errorMessage.isEmpty,
        ),
        predicate<ApplyState>(
          (s) => s.isLoading == false && s.driver == driver,
        ),
      ],
    );

    blocTest<ApplyViewModel, ApplyState>(
      'emits error when apply fails',
      build: () {
        when(mockApplyUseCase(request)).thenAnswer(
          (_) async =>
              ApiErrorResult(failure: Failure(errorMessage: 'invalid data')),
        );
        return viewModel;
      },
      act: (vm) => vm.doIntent(ApplyDriverEvent(request)),
      expect: () => [
        predicate<ApplyState>(
          (s) => s.isLoading == true && s.errorMessage.isEmpty,
        ),
        predicate<ApplyState>(
          (s) => s.isLoading == false && s.errorMessage == 'invalid data',
        ),
      ],
    );
  });
}
