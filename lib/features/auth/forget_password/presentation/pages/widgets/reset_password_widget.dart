import 'package:flowery_tracking_app/config/routing/app_routes.dart';
import 'package:flowery_tracking_app/config/routing/routing_extensions.dart';
import 'package:flowery_tracking_app/core/helpers/spacing.dart';
import 'package:flowery_tracking_app/core/helpers/validators.dart';
import 'package:flowery_tracking_app/core/l10n/translations/app_localizations.dart';
import 'package:flowery_tracking_app/features/auth/forget_password/presentation/view_model/cubit/forget_password_cubit.dart';
import 'package:flowery_tracking_app/features/auth/forget_password/presentation/view_model/cubit/forget_password_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ResetPasswordWidget extends StatefulWidget {
  const ResetPasswordWidget({super.key});

  @override
  State<ResetPasswordWidget> createState() => _ResetPasswordWidgetState();
}

class _ResetPasswordWidgetState extends State<ResetPasswordWidget> {
  late TextEditingController newPasswordController;
  late TextEditingController confirmPasswordController;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;

  @override
  void initState() {
    newPasswordController = TextEditingController();
    confirmPasswordController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var trans = AppLocalizations.of(context)!;

    return Form(
      key: formKey,
      autovalidateMode: autovalidateMode,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            verticalSpace(40),
            Text(
              trans.reset_password,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            verticalSpace(16),
            Text(
              textAlign: TextAlign.center,
              trans.reset_password_desc,
              style: Theme.of(
                context,
              ).textTheme.bodyMedium!.copyWith(color: Colors.grey),
            ),
            verticalSpace(32),
            TextFormField(
              controller: newPasswordController,
              validator: (value) =>
                  Validations.validatePassword(context, value),
              decoration: InputDecoration(
                labelText: trans.new_password,
                hint: Text(trans.enter_new_password),
              ),
            ),
            verticalSpace(24),
            TextFormField(
              controller: confirmPasswordController,
              validator: (value) => Validations.validateConfirmPassword(
                context,
                value,
                newPasswordController.text,
              ),
              decoration: InputDecoration(
                labelText: trans.enter_confirm_password,
                hint: Text(trans.enter_confirm_password),
              ),
            ),
            verticalSpace(32),
            BlocConsumer<ForgetPasswordCubit, ForgetPasswordState>(
              listener: (BuildContext context, ForgetPasswordState state) {
                if (state.isPasswordReset == true) {
                  context.pushReplacementNamed(AppRoutes.login);
                }
              },
              builder: (context, state) {
                return ElevatedButton(
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      context.read<ForgetPasswordCubit>().doIntent(
                        ResetPasswordEvent(newPasswordController.text),
                      );
                    } else {
                      setState(() {
                        autovalidateMode = AutovalidateMode.always;
                      });
                    }
                  },
                  child: state.isPasswordResetLoading
                      ? const CircularProgressIndicator(color: Colors.white)
                      : Text(trans.confirm),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
