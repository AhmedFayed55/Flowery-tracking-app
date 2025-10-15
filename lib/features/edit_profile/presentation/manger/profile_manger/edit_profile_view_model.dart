import 'dart:io';
import 'package:flowery_tracking_app/core/errors/api_results.dart';
import 'package:flowery_tracking_app/features/edit_profile/domain/entities/request/edit_profile_request_entity.dart';
import 'package:flowery_tracking_app/features/edit_profile/domain/entities/response/edit_profile_response_entity.dart';
import 'package:flowery_tracking_app/features/edit_profile/domain/entities/response/get_logged_driver_response_entity.dart';
import 'package:flowery_tracking_app/features/edit_profile/domain/entities/response/upload_photo_response_entity.dart';
import 'package:flowery_tracking_app/features/edit_profile/domain/use_cases/edit_profile_use_case.dart';
import 'package:flowery_tracking_app/features/edit_profile/domain/use_cases/get_logged_driver_use_case.dart';
import 'package:flowery_tracking_app/features/edit_profile/domain/use_cases/upload_photo_use_case.dart';
import 'package:flowery_tracking_app/features/edit_profile/presentation/manger/profile_manger/edit_profile_event.dart';
import 'package:flowery_tracking_app/features/edit_profile/presentation/manger/profile_manger/edit_profile_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class EditProfileViewModel extends Cubit<EditProfileState> {
  final GetLoggedDriverUseCase _getLoggedUserUseCase;
  final EditProfileUseCase _editProfileUseCase;
  final UploadPhotoUseCase _uploadPhotoUseCase;

  final TextEditingController editProfileFirstNameController =
      TextEditingController();

  final TextEditingController editProfileLastNameController =
      TextEditingController();

  final TextEditingController editProfileEmailController =
      TextEditingController();

  final TextEditingController editProfilePhoneController =
      TextEditingController();

  GlobalKey<FormState> editProfileFormKey = GlobalKey<FormState>();

  File? selectedImageFile;
  String? initialImage;

  EditProfileViewModel(
    this._getLoggedUserUseCase,
    this._editProfileUseCase,
    this._uploadPhotoUseCase,
  ) : super(const EditProfileState());

  Future<void> doIntend(EditProfileEvent event) async {
    switch (event) {
      case GetLoggedUserDataEvent():
        await _getLoggedUserData();
      case EditProfileSubmitEvent():
        await _updateProfileWithOptionalImage();
      case LoadUserDataEvent():
        await _getLoggedUserData();
      case OnImageSelectedEvent():
        _onImageSelected(event.file);
        break;
      case ResetSuccessStateEvent():
        _resetSuccessState();
      case CloseEvent():
        _close();
    }
  }

  Future<void> _getLoggedUserData() async {
    emit(state.copyWith(isLoading: true, failure: null));
    final result = await _getLoggedUserUseCase();
    switch (result) {
      case ApiSuccessResult<GetLoggedDriverResponseEntity>():
        final response = result.data;
        _onUserDataLoaded(response);
        emit(
          state.copyWith(
            isLoading: false,
            failure: null,
            loggedUserDataResponseEntity: response,
          ),
        );

        break;
      case ApiErrorResult<GetLoggedDriverResponseEntity>():
        emit(state.copyWith(isLoading: false, failure: result.failure));
        break;
    }
  }

  void _onUserDataLoaded(GetLoggedDriverResponseEntity response) {
    editProfileFirstNameController.text = response.driver.firstName;
    editProfileLastNameController.text = response.driver.lastName;
    editProfileEmailController.text = response.driver.email;
    editProfilePhoneController.text = response.driver.phone;
    initialImage = response.driver.photo;
  }

  Future<void> _updateProfileWithOptionalImage() async {
    if (!_isFormValid()) return;

    emit(state.copyWith(isLoading: true, failure: null, editSuccess: false));

    try {
      final uploadSuccess = await _handleImageUploadIfNeeded();
      if (!uploadSuccess) return;

      await _updateProfileData();
    } catch (e) {
      emit(state.copyWith(isLoading: false, failure: null, editSuccess: false));
    }
  }

  Future<bool> _handleImageUploadIfNeeded() async {
    if (selectedImageFile == null) return true;

    final uploadResult = await _uploadPhotoUseCase.invoke(selectedImageFile!);
    switch (uploadResult) {
      case ApiErrorResult<UploadPhotoResponseEntity>():
        emit(
          state.copyWith(
            isLoading: false,
            failure: uploadResult.failure,
            editSuccess: false,
          ),
        );
        return false;

      case ApiSuccessResult<UploadPhotoResponseEntity>():
        return true;
    }
  }

  Future<void> _updateProfileData() async {
    final request = EditProfileRequestEntity(
      firstName: editProfileFirstNameController.text.trim(),
      lastName: editProfileLastNameController.text.trim(),
      email: editProfileEmailController.text.trim(),
      phone: editProfilePhoneController.text.trim(),
    );

    final result = await _editProfileUseCase.invoke(request);

    switch (result) {
      case ApiSuccessResult<EditProfileResponseEntity>():
        emit(
          state.copyWith(
            isLoading: false,
            editSuccess: true,
            failure: null,
            editProfileResponseEntity: result.data,
          ),
        );
        break;

      case ApiErrorResult<EditProfileResponseEntity>():
        emit(
          state.copyWith(
            isLoading: false,
            failure: result.failure,
            editSuccess: false,
          ),
        );
        selectedImageFile = null;
        break;
    }
  }

  void _onImageSelected(File file) {
    selectedImageFile = file;
    emit(state.copyWith(selectedImage: file));
  }

  bool _isFormValid() {
    return editProfileFormKey.currentState?.validate() ?? false;
  }

  void _resetSuccessState() {
    emit(state.copyWith(editSuccess: false, failure: null));
  }

  Future<void> _close() {
    editProfileFirstNameController.dispose();
    editProfileLastNameController.dispose();
    editProfileEmailController.dispose();
    editProfilePhoneController.dispose();
    return super.close();
  }
}
