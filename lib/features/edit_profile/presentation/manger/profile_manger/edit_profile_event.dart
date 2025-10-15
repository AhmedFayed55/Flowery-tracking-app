import 'dart:io';

sealed class EditProfileEvent {}

class GetLoggedUserDataEvent extends EditProfileEvent {}

class EditProfileSubmitEvent extends EditProfileEvent {}

class LoadUserDataEvent extends EditProfileEvent {}

class OnImageSelectedEvent extends EditProfileEvent {
  final File file;
  OnImageSelectedEvent({required this.file});
}

class ResetSuccessStateEvent extends EditProfileEvent {}

class CloseEvent extends EditProfileEvent {}
