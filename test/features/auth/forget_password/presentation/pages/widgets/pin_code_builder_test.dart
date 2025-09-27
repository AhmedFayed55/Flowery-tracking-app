import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'package:flowery_tracking_app/features/auth/forget_password/presentation/pages/widgets/pin_code_builder.dart';
import 'package:flowery_tracking_app/features/auth/forget_password/presentation/view_model/cubit/forget_password_cubit.dart';
import 'package:pinput/pinput.dart';

import '../forget_password_screen_test.mocks.dart';

void main() {
  late MockForgetPasswordCubit mockCubit;

  setUp(() {
    mockCubit = MockForgetPasswordCubit();
  });

  Widget makeTestableWidget(Widget child) {
    return MaterialApp(
      home: BlocProvider<ForgetPasswordCubit>.value(
        value: mockCubit,
        child: Scaffold(body: child),
      ),
    );
  }

  testWidgets('shows loading indicator when isOtpCorrectLoading is true', (
    tester,
  ) async {
    when(mockCubit.state).thenReturn(
      const ForgetPasswordState(
        loading: ForgetPasswordLoading(
          isOtpCorrectLoading: true,
          isVerifyCodeSentLoading: false,
          isPasswordResetLoading: false,
        ),
      ),
    );

    await tester.pumpWidget(makeTestableWidget(const PinCodeBuilder()));

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('shows Pinput when not loading', (tester) async {
    when( mockCubit.state).thenReturn(
    const ForgetPasswordState(
        loading: ForgetPasswordLoading(
          isOtpCorrectLoading: false,
          isVerifyCodeSentLoading: false,
          isPasswordResetLoading: false,
        ),
      ),
    );

    await tester.pumpWidget(makeTestableWidget(const PinCodeBuilder()));

    expect(find.byType(Pinput), findsOneWidget);
  });

  testWidgets('shows error message when errorOtp exists', (tester) async {
    when( mockCubit.state).thenReturn(
      const ForgetPasswordState(
        errors: ForgetPasswordErrors(
          errorOtp: 'Invalid OTP',
          errorEmail: '',
          errorPassword: '',
        ),
        loading: ForgetPasswordLoading(
          isOtpCorrectLoading: false,
          isVerifyCodeSentLoading: false,
          isPasswordResetLoading: false,
        ),
      ),
    );

    await tester.pumpWidget(makeTestableWidget(const PinCodeBuilder()));

    expect(find.text('Invalid OTP'), findsOneWidget);
  });
}
