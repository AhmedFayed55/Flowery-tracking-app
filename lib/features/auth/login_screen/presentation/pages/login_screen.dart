import 'package:flowery_tracking_app/config/routing/routing_extensions.dart';
import 'package:flowery_tracking_app/config/theme/colors.dart';
import 'package:flowery_tracking_app/core/di/di.dart';
import 'package:flowery_tracking_app/core/helpers/dialogue_utils.dart';
import 'package:flowery_tracking_app/core/helpers/spacing.dart';
import 'package:flowery_tracking_app/core/helpers/validators.dart';
import 'package:flowery_tracking_app/core/l10n/translations/app_localizations.dart';
import 'package:flowery_tracking_app/features/auth/login_screen/presentation/manager/login_cubit.dart';
import 'package:flowery_tracking_app/features/auth/login_screen/presentation/manager/login_event.dart';
import 'package:flowery_tracking_app/features/auth/login_screen/presentation/manager/login_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final LoginCubit loginCubit = getIt.get<LoginCubit>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => loginCubit,
      child: BlocListener<LoginCubit, LoginState>(
        listener: (context, state) {
          if (state.isSuccess) {
            /// pushNamedAndRemoveUntil to main_layout
          }
          if (state.isError) {
            return DialogueUtils.showAlertDialog(
              context,state.showMessage
            );
          }
        },
        child: Scaffold(
          appBar: AppBar(
            title: Text(AppLocalizations.of(context)!.login),
            leading: IconButton(
              onPressed: () {
                context.pop();
              },
              icon: const Icon(Icons.arrow_back_ios),
            ),
          ),
          body: Padding(
            padding: const EdgeInsetsDirectional.only(
              end: 16,
              start: 16,
              top: 24,
              bottom: 16,
            ),
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  TextFormField(
                    onChanged: (value) {
                      loginCubit.doIntent(EmailChangedEvent(email: value));
                    },
                    controller: emailController,
                    validator: (value) {
                      return Validations.validateEmail(context, value);
                    },
                    decoration: InputDecoration(
                      label: Text(AppLocalizations.of(context)!.email),
                      hintText: AppLocalizations.of(context)!.enter_your_email,
                    ),
                  ),
                  verticalSpace(24),
                  TextFormField(
                    onChanged: (value) {
                      loginCubit.doIntent(
                        PasswordChangedEvent(password: value),
                      );
                    },
                    obscureText: true,
                    obscuringCharacter: "★",
                    controller: passwordController,
                    validator: (value) {
                      return Validations.loginValidatePassword(context, value);
                    },
                    decoration: InputDecoration(
                      label: Text(AppLocalizations.of(context)!.password),
                      hintText: AppLocalizations.of(
                        context,
                      )!.enter_your_password,
                    ),
                  ),
                  Row(
                    children: [
                      BlocBuilder<LoginCubit, LoginState>(
                        builder: (context, state) {
                          return IconButton(
                            onPressed: () {
                              loginCubit.doIntent(
                                IsRememberMeEvent(
                                  isRemember: state.isRememberMe,
                                ),
                              );
                            },
                            icon: state.isRememberMe
                                ? const Icon(
                                    Icons.check_box,
                                    color: AppColors.pink,
                                  )
                                : const Icon(Icons.check_box_outline_blank),
                          );
                        },
                      ),
                      Text(
                        AppLocalizations.of(context)!.remember_me,
                        style: Theme.of(context).textTheme.displaySmall,
                      ),
                      const Spacer(),
                      TextButton(
                        onPressed: () {
                          /// Navigate to forget_Password screen
                        },
                        child: Text(
                          AppLocalizations.of(context)!.forget_password,
                          style: Theme.of(context).textTheme.bodySmall
                              ?.copyWith(
                                decoration: TextDecoration.underline,
                                decorationColor: AppColors.black,
                                decorationThickness: 1,
                              ),
                        ),
                      ),
                    ],
                  ),
                  verticalSpace(32),
                  BlocBuilder<LoginCubit, LoginState>(
                    builder: (context, state) {
                      return ElevatedButton(
                        onPressed: state.isButtonEnabled
                            ? () {
                                if (formKey.currentState!.validate()) {
                                  loginCubit.doIntent(
                                    GoToLoginEvent(
                                      email: emailController.text,
                                      password: passwordController.text,
                                    ),
                                  );
                                }
                              }
                            : null,
                        child: state.isLoading
                            ? const CircularProgressIndicator(
                                color: AppColors.white,
                              )
                            : Text(
                                AppLocalizations.of(context)!.continue_text,
                                style: const TextStyle(color: AppColors.white),
                              ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
