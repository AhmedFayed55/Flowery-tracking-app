import 'dart:async';
import 'package:flowery_tracking_app/config/theme/colors.dart';
import 'package:flowery_tracking_app/core/helpers/spacing.dart';
import 'package:flowery_tracking_app/core/l10n/translations/app_localizations.dart';
import 'package:flowery_tracking_app/features/auth/forget_password/presentation/view_model/cubit/forget_password_cubit.dart';
import 'package:flowery_tracking_app/features/auth/forget_password/presentation/view_model/cubit/forget_password_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pinput/pinput.dart';

class EmailVerificationWidget extends StatefulWidget {
  const EmailVerificationWidget({super.key});

  @override
  State<EmailVerificationWidget> createState() =>
      _EmailVerificationWidgetState();
}

class _EmailVerificationWidgetState extends State<EmailVerificationWidget> {
  final pinController = TextEditingController();
  final focusNode = FocusNode();
  final formKey = GlobalKey<FormState>();

  int _secondsRemaining = 0;
  Timer? _timer;

  void startTimer() {
    setState(() {
      _secondsRemaining = 30;
    });

    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_secondsRemaining == 0) {
        timer.cancel();
      } else {
        setState(() {
          _secondsRemaining--;
        });
      }
    });
  }

  @override
  void initState() {
    startTimer();
    super.initState();
  }

  @override
  void dispose() {
    _timer?.cancel();
    pinController.dispose();
    focusNode.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var trans = AppLocalizations.of(context)!;
    var cubit = context.read<ForgetPasswordCubit>();

    return BlocBuilder<ForgetPasswordCubit, ForgetPasswordState>(
      builder: (context, state) {
        return Column(
          children: [
            verticalSpace(40),
            Text(
              trans.email_verification,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            verticalSpace(16),
            Text(
              textAlign: TextAlign.center,
              trans.email_verification_desc,
              style: Theme.of(
                context,
              ).textTheme.bodyMedium!.copyWith(color: Colors.grey),
            ),
            verticalSpace(32),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: state.isOtpCorrectLoading
                  ? const CircularProgressIndicator()
                  : Form(
                      key: formKey,
                      child: Column(
                        children: [
                          Pinput(
                            length: 6,
                            controller: pinController,
                            focusNode: focusNode,
                            showCursor: true,
                            onCompleted: (pin) async {
                              await cubit.doIntent(VerifyCodeEvent(pin));
                            },
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter OTP';
                              }

                              return null;
                            },
                            errorPinTheme: PinTheme(
                              width: 68,
                              height: 74,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.red),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              textStyle: const TextStyle(
                                fontSize: 20,
                                color: Colors.red,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            defaultPinTheme: PinTheme(
                              width: 68,
                              height: 74,
                              decoration: BoxDecoration(
                                color: AppColors.darkGrey.withValues(
                                  alpha: 0.2,
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              textStyle: const TextStyle(
                                fontSize: 20,
                                color: AppColors.black,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          if (state.errorOtp != null &&
                              state.errorOtp!.isNotEmpty) ...[
                            const SizedBox(height: 8),
                            Text(
                              state.errorOtp!,
                              style: const TextStyle(color: Colors.red),
                            ),
                          ],
                        ],
                      ),
                    ),
            ),
            verticalSpace(32),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  trans.did_not_receive_code,
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: Colors.black,
                    fontWeight: FontWeight.normal,
                  ),
                ),
                TextButton(
                  onPressed: _secondsRemaining == 0
                      ? () {
                          cubit.doIntent(ForgetPasswordEvent(state.email!));
                          startTimer();
                        }
                      : null,
                  child: Text(
                    _secondsRemaining == 0
                        ? trans.resend_code
                        : "${trans.resend_code} ($_secondsRemaining)",
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: _secondsRemaining == 0
                          ? AppColors.pink
                          : Colors.grey,
                    ),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
