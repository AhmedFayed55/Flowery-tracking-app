import 'package:flowery_tracking_app/core/l10n/translations/app_localizations.dart';
import 'package:flowery_tracking_app/features/auth/forget_password/presentation/view_model/cubit/forget_password_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flowery_tracking_app/features/auth/forget_password/presentation/pages/widgets/reset_password_widget.dart';
import 'package:mockito/mockito.dart';

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
        child: const Scaffold(body: ResetPasswordWidget()),
      ),
    );
  }

  testWidgets('ResetPasswordWidget UI Correctly ', (WidgetTester tester) async {
    when(mockCubit.state).thenReturn(
      const ForgetPasswordState(isVerifyCodeSent: true, isOtpCorrect: true),
    );
    when(mockCubit.stream).thenAnswer(
      (_) => Stream.value(
        const ForgetPasswordState(isVerifyCodeSent: true, isOtpCorrect: true),
      ),
    );

    await tester.pumpWidget(createTestableWidget());

    expect(find.byType(Text), findsAtLeastNWidgets(5));
    expect(find.byType(TextFormField), findsAtLeastNWidgets(2));
    expect(find.byType(ElevatedButton), findsAtLeastNWidgets(1));
  });
  testWidgets(
    'ResetPasswordWidget UI when tap on confirm button with no data ',
    (WidgetTester tester) async {
      when(mockCubit.state).thenReturn(
        const ForgetPasswordState(isVerifyCodeSent: true, isOtpCorrect: true),
      );
      when(mockCubit.stream).thenAnswer(
        (_) => Stream.value(
          const ForgetPasswordState(isVerifyCodeSent: true, isOtpCorrect: true),
        ),
      );

      await tester.pumpWidget(createTestableWidget());

      await tester.tap(find.byType(ElevatedButton));

      await tester.pump();

      expect(find.byType(Text), findsAtLeastNWidgets(7));
      expect(find.byType(TextFormField), findsAtLeastNWidgets(2));
      expect(find.byType(ElevatedButton), findsAtLeastNWidgets(1));
    },
  );
}
