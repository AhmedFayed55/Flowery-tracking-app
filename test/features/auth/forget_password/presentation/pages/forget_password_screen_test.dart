import 'package:flowery_tracking_app/core/l10n/translations/app_localizations.dart';
import 'package:flowery_tracking_app/features/auth/forget_password/presentation/pages/forget_password_screen.dart';
import 'package:flowery_tracking_app/features/auth/forget_password/presentation/pages/widgets/email_verification_widget.dart';
import 'package:flowery_tracking_app/features/auth/forget_password/presentation/pages/widgets/forget_password_widget.dart';
import 'package:flowery_tracking_app/features/auth/forget_password/presentation/pages/widgets/reset_password_widget.dart';
import 'package:flowery_tracking_app/features/auth/forget_password/presentation/view_model/cubit/forget_password_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'forget_password_screen_test.mocks.dart';

@GenerateNiceMocks([MockSpec<ForgetPasswordCubit>()])
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
        child: const ForgetPasswordScreen(),
      ),
    );
  }

  testWidgets('renders ForgetPasswordWidget when isVerifyCodeSent = false', (
    tester,
  ) async {
    // Arrange
    when(
      mockCubit.state,
    ).thenReturn(const ForgetPasswordState(isVerifyCodeSent: false));
    when(mockCubit.stream).thenAnswer(
      (_) => Stream.value(const ForgetPasswordState(isVerifyCodeSent: false)),
    );

    // Act
    await tester.pumpWidget(createTestableWidget());
    await tester.pumpAndSettle();

    // Assert
    expect(find.byType(AppBar), findsOneWidget);
    expect(find.byType(ForgetPasswordWidget), findsOneWidget);
  });
  testWidgets('renders EmailVerificationWidget when isVerifyCodeSent = true', (
    tester,
  ) async {
    // Arrange
    when(
      mockCubit.state,
    ).thenReturn(const ForgetPasswordState(isVerifyCodeSent: true));
    when(mockCubit.stream).thenAnswer(
      (_) => Stream.value(const ForgetPasswordState(isVerifyCodeSent: true)),
    );

    // Act
    await tester.pumpWidget(createTestableWidget());
    await tester.pumpAndSettle();

    // Assert
    expect(find.byType(AppBar), findsOneWidget);
    expect(find.byType(EmailVerificationWidget), findsOneWidget);
  });
  testWidgets(
    'renders ResetPasswordWidget when isVerifyCodeSent = true and isOtpCorrect = true',
    (tester) async {
      // Arrange
      when(mockCubit.state).thenReturn(
        const ForgetPasswordState(isVerifyCodeSent: true, isOtpCorrect: true),
      );
      when(mockCubit.stream).thenAnswer(
        (_) => Stream.value(
          const ForgetPasswordState(isVerifyCodeSent: true, isOtpCorrect: true),
        ),
      );

      // Act
      await tester.pumpWidget(createTestableWidget());
      await tester.pumpAndSettle();

      // Assert
      expect(find.byType(AppBar), findsOneWidget);
      expect(find.byType(ResetPasswordWidget), findsOneWidget);
    },
  );
}
