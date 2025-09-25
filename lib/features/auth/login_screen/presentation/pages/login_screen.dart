import 'package:flowery_tracking_app/config/routing/routing_extensions.dart';
import 'package:flowery_tracking_app/config/theme/colors.dart';
import 'package:flowery_tracking_app/core/helpers/spacing.dart';
import 'package:flowery_tracking_app/core/helpers/validators.dart';
import 'package:flowery_tracking_app/core/l10n/translations/app_localizations.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool isRememberMe = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                controller: emailController,
                validator: (value) {
                  return Validations.loginValidateEmail(context, value);
                },
                decoration: InputDecoration(
                  label: Text(AppLocalizations.of(context)!.email),
                  hintText: AppLocalizations.of(context)!.enter_your_email,
                ),
              ),
              verticalSpace(24),
              TextFormField(
                obscureText: true,
                obscuringCharacter: "★",
                controller: passwordController,
                validator: (value) {
                  return Validations.loginValidatePassword(context, value);
                },
                decoration: InputDecoration(
                  label: Text(AppLocalizations.of(context)!.password),
                  hintText: AppLocalizations.of(context)!.enter_your_password,
                ),
              ),
              Row(
                children: [
                  IconButton(
                    onPressed: () {
                      setState(() {
                        isRememberMe = !isRememberMe;
                      });
                    },
                    icon: isRememberMe
                        ? const Icon(Icons.check_box, color: AppColors.pink)
                        : const Icon(Icons.check_box_outline_blank),
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
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        decoration: TextDecoration.underline,
                        decorationColor: AppColors.black,
                        decorationThickness: 1,
                      ),
                    ),
                  ),
                ],
              ),
              verticalSpace(32),
              ElevatedButton(
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    /// Navigate to home_screen
                  }
                },
                child: Text(AppLocalizations.of(context)!.continue_text),
              ),
            ],
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
