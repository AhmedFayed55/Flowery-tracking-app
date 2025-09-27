import 'package:flowery_tracking_app/core/l10n/translations/app_localizations.dart';
import 'package:flowery_tracking_app/features/auth/forget_password/presentation/view_model/cubit/forget_password_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flowery_tracking_app/features/auth/forget_password/presentation/pages/widgets/email_verification_widget.dart';
import 'package:mockito/mockito.dart';
import 'package:pinput/pinput.dart';

import '../forget_password_screen_test.mocks.dart';

void main() {
  late MockForgetPasswordCubit mockCubit;

  setUp(() {
    mockCubit = MockForgetPasswordCubit();
  });

  Widget createTestableWidget() {
    return MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: BlocProvider<ForgetPasswordCubit>.value(
        value: mockCubit,
        child: const Scaffold(body: EmailVerificationWidget()),
      ),
    );
  }

  testWidgets('EmailVerificationWidget UI Correctly ', (
    WidgetTester tester,
  ) async {
    when(
      mockCubit.state,
    ).thenReturn(const ForgetPasswordState(isVerifyCodeSent: true));
    when(mockCubit.stream).thenAnswer(
      (_) => Stream.value(const ForgetPasswordState(isVerifyCodeSent: true)),
    );

    await tester.pumpWidget(createTestableWidget());
    expect(find.byType(Text), findsAtLeastNWidgets(3));
    expect(find.byType(TextButton), findsAtLeastNWidgets(1));
    expect(find.byType(Pinput), findsAtLeastNWidgets(1));
  });
}
