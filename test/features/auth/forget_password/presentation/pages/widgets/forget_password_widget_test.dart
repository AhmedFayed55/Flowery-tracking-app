import 'package:flowery_tracking_app/core/l10n/translations/app_localizations.dart';
import 'package:flowery_tracking_app/features/auth/forget_password/presentation/view_model/cubit/forget_password_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flowery_tracking_app/features/auth/forget_password/presentation/pages/widgets/forget_password_widget.dart';
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
        child: const Scaffold(body: ForgetPasswordWidget()),
      ),
    );
  }

  testWidgets('Render ForgetPasswordWidget UI Correctly ', (
    WidgetTester tester,
  ) async {
    when(
      mockCubit.state,
    ).thenReturn(const ForgetPasswordState(isvrifyCodeSent: false));
    when(mockCubit.stream).thenAnswer(
      (_) => Stream.value(const ForgetPasswordState(isvrifyCodeSent: false)),
    );

    await tester.pumpWidget(createTestableWidget());
    expect(find.byType(Text), findsAtLeastNWidgets(5));
    expect(find.byType(TextField), findsOneWidget);
    expect(find.byType(ElevatedButton), findsOneWidget);
  });
  testWidgets(
    'Render ForgetPasswordWidget UI when user tap confirm button with no email ',
    (WidgetTester tester) async {
      when(
        mockCubit.state,
      ).thenReturn(const ForgetPasswordState(isvrifyCodeSent: false));
      when(mockCubit.stream).thenAnswer(
        (_) => Stream.value(const ForgetPasswordState(isvrifyCodeSent: false)),
      );

      await tester.pumpWidget(createTestableWidget());

      await tester.tap(find.byType(ElevatedButton));
      await tester.pump();
      expect(find.byType(Text), findsAtLeastNWidgets(6));
      expect(find.byType(TextField), findsOneWidget);
      expect(find.byType(ElevatedButton), findsOneWidget);
    },
  );
}
