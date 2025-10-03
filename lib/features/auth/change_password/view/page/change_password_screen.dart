import 'package:flowery_tracking_app/config/routing/app_routes.dart';
import 'package:flowery_tracking_app/config/routing/routing_extensions.dart';
import 'package:flowery_tracking_app/config/theme/colors.dart';
import 'package:flowery_tracking_app/core/di/di.dart';
import 'package:flowery_tracking_app/core/extensions/extensions.dart';
import 'package:flowery_tracking_app/core/helpers/flutter_toast.dart';
import 'package:flowery_tracking_app/core/helpers/validators.dart';
import 'package:flowery_tracking_app/core/services/token_service.dart';
import 'package:flowery_tracking_app/features/auth/change_password/domain/entities/change_password_request_entity.dart';
import 'package:flowery_tracking_app/features/auth/change_password/view/view_model/change_password_cubit.dart';
import 'package:flowery_tracking_app/features/auth/change_password/view/view_model/change_password_event.dart';
import 'package:flowery_tracking_app/features/auth/change_password/view/view_model/change_password_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  bool isButtonEnabled = false;
  var cubit = getIt.get<ChangePasswordViewModel>();

  final formKey = GlobalKey<FormState>();

  void checkValidation() {
    final valid = formKey.currentState?.validate() ?? false;
    setState(() => isButtonEnabled = valid);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => cubit,
      child: BlocConsumer<ChangePasswordViewModel, ChangePasswordState>(
        listener: (context, state) {
          if (state.isSuccess == true) {
            ToastMessage.toastMsg(context.localization.update_successfully);
            getIt<TokenService>().deleteToken();
            context.pushReplacementNamed(AppRoutes.onBoarding);
          }
          if (state.message != null) {
            ToastMessage.toastMsg(state.message!);
          }
        },
        builder: (context, state) {
          final cubit = context.read<ChangePasswordViewModel>();

          return Scaffold(
            appBar: AppBar(title: Text(context.localization.change_password)),
            body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Form(
                key: formKey,
                child: Column(
                  spacing: 10,
                  children: [
                    TextFormField(
                      onChanged: (_) => checkValidation(),
                      controller: cubit.oldPasswordController,
                      decoration: InputDecoration(
                        labelText: context.localization.current_password,
                        hintText: context.localization.current_password,
                      ),
                    ),
                    TextFormField(
                      onChanged: (_) => checkValidation(),
                      validator: (value) =>
                          Validations.validatePassword(context, value),
                      controller: cubit.newPasswordController,
                      decoration: InputDecoration(
                        labelText: context.localization.new_password,
                        hintText: context.localization.new_password,
                      ),
                    ),
                    TextFormField(
                      onChanged: (_) => checkValidation(),
                      validator: (value) {
                        Validations.confirmPassword(
                          context,
                          cubit.newPasswordController.text,
                        );
                        return Validations.validateRequired(context, value);
                      },
                      controller: cubit.confirmPasswordController,
                      decoration: InputDecoration(
                        labelText: context.localization.confirm_password,
                        hintText: context.localization.confirm_password,
                      ),
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: isButtonEnabled
                          ? () {
                              if (formKey.currentState!.validate()) {
                                cubit.doIntent(
                                  ChangePasswordEvent(
                                    ChangePasswordRequestEntity(
                                      oldPassword:
                                          cubit.oldPasswordController.text,
                                      newPassword:
                                          cubit.newPasswordController.text,
                                    ),
                                  ),
                                );
                              }
                            }
                          : null,
                      child: state.isLoading == true
                          ? const CircularProgressIndicator(
                              color: AppColors.white,
                            )
                          : Text(
                              context.localization.up_date,
                              style: const TextStyle(color: AppColors.white),
                            ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
