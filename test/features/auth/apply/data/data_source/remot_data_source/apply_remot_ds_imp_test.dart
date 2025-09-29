import 'dart:io';

import 'package:flowery_tracking_app/features/auth/apply/data/model/responce/driver_model_dto.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart'; 
import 'package:mockito/mockito.dart';
import 'package:dio/dio.dart';

import 'package:flowery_tracking_app/core/network/api_services.dart';
import 'package:flowery_tracking_app/features/auth/apply/data/data_source/gemeni_api_service.dart';
import 'package:flowery_tracking_app/features/auth/apply/data/data_source/remot_data_source/apply_remot_ds_imp.dart';
import 'package:flowery_tracking_app/features/auth/apply/data/model/request/apply_request_dto.dart';
import 'package:flowery_tracking_app/features/auth/apply/data/model/responce/apply_responce_dto.dart';
import 'package:flowery_tracking_app/features/auth/apply/data/model/responce/vehicel_responce_dto.dart';
import 'apply_remot_ds_imp_test.mocks.dart';

@GenerateMocks([ApiServices, GeminiApiService, ApplyRequestDto])
void main() {
  late ApplyRemotDataSourceImp dataSource;
  late MockApiServices mockApiServices;
  late MockGeminiApiService mockGeminiApiService;
  late MockApplyRequestDto mockApplyRequestDto;

  setUp(() {
    mockApiServices = MockApiServices();
    mockGeminiApiService = MockGeminiApiService();
    mockApplyRequestDto = MockApplyRequestDto();
    dataSource = ApplyRemotDataSourceImp(mockApiServices, mockGeminiApiService);
  });

  group('ApplyRemotDataSourceImp', () {
    test('applyDriver calls apiServices.apply with correct FormData', () async {
      // Arrange
      final fakeResponse = ApplyResponceDto(
        message: '',
        driver: DriverModelDto(
          country: '',
          firstName: '',
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
          role: '',
          id: '',
          createdAt: '',
        ),
        token: '',
      );

      when(mockApplyRequestDto.toPartMap()).thenReturn({'key': 'value'});
      when(mockApplyRequestDto.vehicleLicensePart)
          .thenAnswer((_) async => MultipartFile.fromBytes([0]));
      when(mockApplyRequestDto.nIDImgPart)
          .thenAnswer((_) async => MultipartFile.fromBytes([0]));
      when(mockApiServices.apply(any)).thenAnswer((_) async => fakeResponse);

      // Act
      final result = await dataSource.applyDriver(mockApplyRequestDto);

      // Assert
      expect(result, fakeResponse);
      verify(mockApiServices.apply(any)).called(1);
    });

    test('getvehicles calls apiServices.getAllVehicles', () async {
      // Arrange
      final fakeResponse = VehiclesResponseDto(message: '', vehicles: []);
      when(mockApiServices.getAllVehicles())
          .thenAnswer((_) async => fakeResponse);

      // Act
      final result = await dataSource.getvehicles();

      // Assert
      expect(result, fakeResponse);
      verify(mockApiServices.getAllVehicles()).called(1);
    });

    test('verifyID calls geminiApiService.sendImage', () async {
      // Arrange
      final fakeFile = File('id.png');
      final fakeResult = <String, dynamic>{'result': 'ok'};

      when(mockGeminiApiService.sendImage(
        image: anyNamed('image'),
        instructions: anyNamed('instructions'),
      )).thenAnswer((_) async => fakeResult);

      // Act
      final result = await dataSource.verifyID(fakeFile);

      // Assert
      expect(result, fakeResult);
      verify(mockGeminiApiService.sendImage(
        image: fakeFile,
        instructions: anyNamed('instructions'),
      )).called(1);
    });

    test('verifyLicense calls geminiApiService.sendImage', () async {
      // Arrange
      final fakeFile = File('license.png');
      final fakeResult = <String, dynamic>{'result': 'ok'};

      when(mockGeminiApiService.sendImage(
        image: anyNamed('image'),
        instructions: anyNamed('instructions'),
      )).thenAnswer((_) async => fakeResult);

      // Act
      final result = await dataSource.verifyLicense(fakeFile);

      // Assert
      expect(result, fakeResult);
      verify(mockGeminiApiService.sendImage(
        image: fakeFile,
        instructions: anyNamed('instructions'),
      )).called(1);
    });
  });
}
