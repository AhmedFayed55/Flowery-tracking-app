import 'package:flowery_tracking_app/core/di/di.dart';
import 'package:flowery_tracking_app/core/l10n/translations/app_localizations.dart';
import 'package:flowery_tracking_app/features/auth/forget_password/presentation/pages/widgets/email_verification_widget.dart';
import 'package:flowery_tracking_app/features/auth/forget_password/presentation/pages/widgets/forget_password_widget.dart';
import 'package:flowery_tracking_app/features/auth/forget_password/presentation/pages/widgets/reset_password_widget.dart';
import 'package:flowery_tracking_app/features/auth/forget_password/presentation/view_model/cubit/forget_password_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ForgetPasswordScreen extends StatelessWidget {
  const ForgetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var trans = AppLocalizations.of(context)!;
    return BlocProvider(
      create: (context) => getIt.get<ForgetPasswordCubit>(),
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new),
            onPressed: () => Navigator.pop(context),
          ),
          title: Text(
            trans.password,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ),
        body: BlocBuilder<ForgetPasswordCubit, ForgetPasswordState>(
          builder: (BuildContext context, ForgetPasswordState state) {
            if (state.isvrifyCodeSent != true) {
              return const ForgetPasswordWidget();
            } else if (state.isvrifyCodeSent == true &&
                state.isOtpCorrect != true) {
              return const EmailVerificationWidget();
            } else if (state.isOtpCorrect == true &&
                state.isPasswordReset != true) {
              return const ResetPasswordWidget();
            } else if (state.isPasswordReset == true) {
              return Center(child: Text(trans.password_reset_successfully));
            } else {
              return Center(child: Text(trans.something_went_wrong));
            }
          },
        ),
      ),
    );
  }
}
