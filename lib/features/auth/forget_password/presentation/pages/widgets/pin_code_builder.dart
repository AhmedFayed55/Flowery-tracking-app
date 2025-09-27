import 'package:flowery_tracking_app/config/theme/colors.dart';
import 'package:flowery_tracking_app/features/auth/forget_password/presentation/view_model/cubit/forget_password_cubit.dart';
import 'package:flowery_tracking_app/features/auth/forget_password/presentation/view_model/cubit/forget_password_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pinput/pinput.dart';

class PinCodeBuilder extends StatefulWidget {
  const PinCodeBuilder({
    super.key,
  });



  @override
  State<PinCodeBuilder> createState() => _PinCodeBuilderState();
}


class _PinCodeBuilderState extends State<PinCodeBuilder> {
  final pinController = TextEditingController();
  final focusNode = FocusNode();
  final formKey = GlobalKey<FormState>();


  @override
  void dispose() {
    pinController.dispose();
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
  var cubit = context.watch<ForgetPasswordCubit>();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: cubit.state.loading.isOtpCorrectLoading
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
                  if (cubit.state.errors.errorOtp != null &&
                      cubit.state.errors.errorOtp!.isNotEmpty) ...[
                    const SizedBox(height: 8),
                    Text(
                      cubit.state.errors.errorOtp!,
                      style: const TextStyle(color: Colors.red),
                    ),
                  ],
                ],
              ),
            ),
    );
  }
}
