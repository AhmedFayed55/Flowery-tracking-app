import 'package:flowery_tracking_app/config/theme/colors.dart';
import 'package:flowery_tracking_app/core/extensions/extensions.dart';
import 'package:flowery_tracking_app/core/helpers/dialogue_utils.dart';
import 'package:flowery_tracking_app/core/utils/constants.dart';
import 'package:flowery_tracking_app/core/utils/custom_elevated_button.dart';
import 'package:flowery_tracking_app/features/edit_profile/presentation/manger/profile_manger/edit_profile_event.dart';
import 'package:flowery_tracking_app/features/edit_profile/presentation/manger/profile_manger/edit_profile_state.dart';
import 'package:flowery_tracking_app/features/edit_profile/presentation/manger/profile_manger/edit_profile_view_model.dart';
import 'package:flowery_tracking_app/features/edit_profile/presentation/widgets/edit_profile/build_email_field.dart';
import 'package:flowery_tracking_app/features/edit_profile/presentation/widgets/edit_profile/build_first_and_last_name_field.dart';
import 'package:flowery_tracking_app/features/edit_profile/presentation/widgets/edit_profile/build_gender_filed.dart';
import 'package:flowery_tracking_app/features/edit_profile/presentation/widgets/edit_profile/build_password.dart';
import 'package:flowery_tracking_app/features/edit_profile/presentation/widgets/edit_profile/build_phone_field.dart';
import 'package:flowery_tracking_app/features/edit_profile/presentation/widgets/edit_profile/profile_image_pick/profile_image_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditProfileForm extends StatefulWidget {
  const EditProfileForm({super.key});

  @override
  State<EditProfileForm> createState() => _EditProfileFormState();
}

class _EditProfileFormState extends State<EditProfileForm> {
  late final EditProfileViewModel viewModel;

  @override
  void initState() {
    super.initState();
    viewModel = context.read<EditProfileViewModel>();
    viewModel.doIntend(LoadUserDataEvent());
  }

  @override
  void dispose() {
    super.dispose();
    viewModel.doIntend(CloseEvent());
  }

  @override
  Widget build(BuildContext context) {
    final spaceSmall = context.height * 0.01;
    final spaceMed = context.height * 0.02;
    final spaceLarge = context.height * 0.04;
    final profileImageSize = context.width * 0.25;

    return BlocConsumer<EditProfileViewModel, EditProfileState>(
      listener: (context, state) {
        if (state.failure != null && !state.isLoading) {
          DialogueUtils.showMessage(
            context: context,
            message: state.failure!.errorMessage,
            posActionName: context.localization.ok,
            posAction: () {
              viewModel.doIntend(ResetSuccessStateEvent());
              Navigator.pop(context);
            },
          );
        }

        if (state.editSuccess && !state.isLoading) {
          DialogueUtils.showMessage(
            context: context,
            message: context.localization.profile_updated,
            title: context.localization.success,
            posActionName: context.localization.ok,
            posAction: () {
              viewModel.doIntend(ResetSuccessStateEvent());
              Navigator.pop(context);
            },
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(title: Text(context.localization.edit_profile)),
          body: SafeArea(
            child: SingleChildScrollView(
              child: Form(
                key: viewModel.editProfileFormKey,
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: context.width * 0.046,
                  ),
                  child: AutofillGroup(
                    child: Column(
                      children: [
                        SizedBox(height: spaceSmall),
                        ProfileImagePickerWidget(
                          size: profileImageSize,
                          initialImageUrl:
                              state.selectedImage?.path ??
                              viewModel.initialImage,
                          onImageSelected: (file) {
                            if (file != null) {
                              viewModel.doIntend(
                                OnImageSelectedEvent(file: file),
                              );
                            }
                          },
                        ),
                        SizedBox(height: spaceMed),
                        BuildFirstAndLastNameField(
                          firstNameController:
                              viewModel.editProfileFirstNameController,
                          secondNameController:
                              viewModel.editProfileLastNameController,
                        ),
                        SizedBox(height: spaceMed),
                        BuildEmailField(
                          controller: viewModel.editProfileEmailController,
                        ),
                        SizedBox(height: spaceMed),
                        BuildPhoneField(
                          controller: viewModel.editProfilePhoneController,
                        ),
                        SizedBox(height: spaceMed),
                        BuildPasswordField(
                          onChangePressed: () {
                            Navigator.pushNamed(context, "/changePassword");
                          },
                        ),
                        SizedBox(height: spaceMed),
                        BuildGenderField(
                          selectedGender:
                              state
                                  .loggedUserDataResponseEntity
                                  ?.driver
                                  .gender ??
                              AppConstants.male,
                        ),
                        SizedBox(height: spaceLarge),
                        CustomElevatedButton(
                          onPressed: () {
                            FocusManager.instance.primaryFocus?.unfocus();
                            viewModel.doIntend(EditProfileSubmitEvent());
                          },
                          isLoading: state.isLoading,
                          widget: Text(
                            context.localization.update,
                            style: const TextStyle(color: AppColors.white),
                          ),
                        ),

                        SizedBox(height: spaceSmall),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
