import 'dart:io';
import 'package:flowery_tracking_app/core/errors/api_results.dart';
import 'package:flowery_tracking_app/core/errors/failures.dart';
import 'package:flowery_tracking_app/features/edit_profile/domain/entities/driver_entity.dart';
import 'package:flowery_tracking_app/features/edit_profile/domain/entities/response/edit_profile_response_entity.dart';
import 'package:flowery_tracking_app/features/edit_profile/domain/entities/response/get_logged_driver_response_entity.dart';
import 'package:flowery_tracking_app/features/edit_profile/domain/entities/response/upload_photo_response_entity.dart';
import 'package:flowery_tracking_app/features/edit_profile/domain/use_cases/edit_profile_use_case.dart';
import 'package:flowery_tracking_app/features/edit_profile/domain/use_cases/get_logged_driver_use_case.dart';
import 'package:flowery_tracking_app/features/edit_profile/domain/use_cases/upload_photo_use_case.dart';
import 'package:flowery_tracking_app/features/edit_profile/presentation/manger/profile_manger/edit_profile_event.dart';
import 'package:flowery_tracking_app/features/edit_profile/presentation/manger/profile_manger/edit_profile_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'edit_profile_view_model_test.mocks.dart';

@GenerateMocks([GetLoggedDriverUseCase, EditProfileUseCase, UploadPhotoUseCase])
void main() {
  late MockGetLoggedDriverUseCase mockGetLogged;
  late MockEditProfileUseCase mockEditProfile;
  late MockUploadPhotoUseCase mockUploadPhoto;
  late EditProfileViewModel vm;

  setUpAll(() {
    provideDummy<ApiResult<GetLoggedDriverResponseEntity>>(
      ApiErrorResult(failure: Failure(errorMessage: 'dummy')),
    );
    provideDummy<ApiResult<EditProfileResponseEntity>>(
      ApiErrorResult(failure: Failure(errorMessage: 'dummy')),
    );
    provideDummy<ApiResult<UploadPhotoResponseEntity>>(
      ApiErrorResult(failure: Failure(errorMessage: 'dummy')),
    );
  });

  setUp(() {
    mockGetLogged = MockGetLoggedDriverUseCase();
    mockEditProfile = MockEditProfileUseCase();
    mockUploadPhoto = MockUploadPhotoUseCase();
    vm = EditProfileViewModel(mockGetLogged, mockEditProfile, mockUploadPhoto);
  });

  test('getLoggedUserData success updates state and controllers', () async {
    final response = GetLoggedDriverResponseEntity(
      message: 'ok',
      driver: _driver(),
    );

    when(
      mockGetLogged.call(),
    ).thenAnswer((_) async => ApiSuccessResult(data: response));

    await vm.doIntend(GetLoggedUserDataEvent());

    expect(vm.state.isLoading, false);
    expect(vm.state.loggedUserDataResponseEntity, response);
  });

  test('getLoggedUserData error updates failure', () async {
    final failure = Failure(errorMessage: 'e');
    when(
      mockGetLogged.call(),
    ).thenAnswer((_) async => ApiErrorResult(failure: failure));

    await vm.doIntend(GetLoggedUserDataEvent());
    expect(vm.state.isLoading, false);
    expect(vm.state.failure, failure);
  });

  test('image selection updates selectedImage and state', () {
    final file = File('test_assets/p.jpg');
    vm.doIntend(OnImageSelectedEvent(file: file));
    expect(vm.selectedImageFile, file);
    expect(vm.state.selectedImage, file);
  });

  testWidgets('editProfile success flow (with no image)', (tester) async {
    // attach a Form with the key so validate() returns true
    vm.editProfileFormKey = GlobalKey<FormState>();
    await tester.pumpWidget(
      Directionality(
        textDirection: TextDirection.ltr,
        child: Form(key: vm.editProfileFormKey, child: Container()),
      ),
    );

    when(mockEditProfile.invoke(any)).thenAnswer(
      (_) async => ApiSuccessResult(
        data: EditProfileResponseEntity(message: 'done', driver: _driver()),
      ),
    );

    await vm.doIntend(EditProfileSubmitEvent());
    expect(vm.state.editSuccess, true);
    expect(vm.state.isLoading, false);
  });

  testWidgets('editProfile stops on image upload error', (tester) async {
    vm.editProfileFormKey = GlobalKey<FormState>();
    await tester.pumpWidget(
      Directionality(
        textDirection: TextDirection.ltr,
        child: Form(key: vm.editProfileFormKey, child: Container()),
      ),
    );
    vm.selectedImageFile = File('test_assets/p.jpg');

    when(mockUploadPhoto.invoke(any)).thenAnswer(
      (_) async =>
          ApiErrorResult(failure: Failure(errorMessage: 'upload failed')),
    );

    await vm.doIntend(EditProfileSubmitEvent());
    expect(vm.state.isLoading, false);
    expect(vm.state.editSuccess, false);
    expect(vm.state.failure?.errorMessage, 'upload failed');
  });

  testWidgets('editProfile error updates failure and resets selectedImage', (
    tester,
  ) async {
    vm.editProfileFormKey = GlobalKey<FormState>();
    await tester.pumpWidget(
      Directionality(
        textDirection: TextDirection.ltr,
        child: Form(key: vm.editProfileFormKey, child: Container()),
      ),
    );

    when(mockEditProfile.invoke(any)).thenAnswer(
      (_) async =>
          ApiErrorResult(failure: Failure(errorMessage: 'update failed')),
    );

    await vm.doIntend(EditProfileSubmitEvent());
    expect(vm.state.isLoading, false);
    expect(vm.state.editSuccess, false);
    expect(vm.state.failure?.errorMessage, 'update failed');
    expect(vm.selectedImageFile, null);
  });
}

DriverEntity _driver() => DriverEntity(
  id: '1',
  country: 'EG',
  firstName: 'A',
  lastName: 'B',
  vehicleType: 'Car',
  vehicleNumber: '111',
  vehicleLicense: 'LIC',
  NID: 'NID',
  NIDImg: 'img',
  email: 'a@b.com',
  password: 'p',
  gender: 'M',
  phone: '+201234567890',
  photo: 'ph',
  role: 'driver',
  createdAt: 'now',
);
