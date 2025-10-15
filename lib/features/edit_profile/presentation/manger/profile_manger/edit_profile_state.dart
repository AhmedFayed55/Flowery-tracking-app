import 'dart:io';
import 'package:equatable/equatable.dart';
import 'package:flowery_tracking_app/core/errors/failures.dart';
import 'package:flowery_tracking_app/features/edit_profile/domain/entities/response/edit_profile_response_entity.dart';
import 'package:flowery_tracking_app/features/edit_profile/domain/entities/response/get_logged_driver_response_entity.dart';

class EditProfileState extends Equatable {
  final bool isLoading;
  final Failure? failure;
  final GetLoggedDriverResponseEntity? loggedUserDataResponseEntity;
  final EditProfileResponseEntity? editProfileResponseEntity;
  final File? selectedImage;
  final bool editSuccess;

  const EditProfileState({
    this.isLoading = true,
    this.failure,
    this.loggedUserDataResponseEntity,
    this.editProfileResponseEntity,
    this.selectedImage,
    this.editSuccess = false,
  });

  @override
  List<Object?> get props => [
    isLoading,
    failure,
    loggedUserDataResponseEntity,
    editProfileResponseEntity,
    selectedImage,
    editSuccess,
  ];

  EditProfileState copyWith({
    bool? isLoading,
    Failure? failure,
    GetLoggedDriverResponseEntity? loggedUserDataResponseEntity,
    EditProfileResponseEntity? editProfileResponseEntity,
    File? selectedImage,
    bool? editSuccess,
  }) {
    return EditProfileState(
      isLoading: isLoading ?? this.isLoading,
      failure: failure ?? this.failure,
      loggedUserDataResponseEntity:
          loggedUserDataResponseEntity ?? this.loggedUserDataResponseEntity,
      editProfileResponseEntity:
          editProfileResponseEntity ?? this.editProfileResponseEntity,
      selectedImage: selectedImage ?? this.selectedImage,
      editSuccess: editSuccess ?? this.editSuccess,
    );
  }
}
