import 'dart:async';
import 'package:flowery_tracking_app/core/di/di.dart';
import 'package:flowery_tracking_app/core/l10n/translations/app_localizations.dart';
import 'package:flowery_tracking_app/features/auth/login_screen/presentation/manager/login_view_model.dart';
import 'package:flowery_tracking_app/features/auth/login_screen/presentation/manager/login_state.dart';
import 'package:flowery_tracking_app/features/auth/login_screen/presentation/pages/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'login_screen_test.mocks.dart';

@GenerateMocks([LoginCubit])
void main() {
  late MockLoginCubit mockLoginCubit;
  late AppLocalizations localization;
  late String invalidEmail;
  late String invalidPassword;

  Widget materialAppToLoginScreen() {
    return MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      locale: const Locale("en"),
      home: BlocProvider(
        create: (context) => mockLoginCubit,
        child: const LoginScreen(),
      ),
    );
  }

  setUpAll(() async {
    invalidEmail = "Invalid Email";
    invalidPassword = "Invalid Password";
    localization = await AppLocalizations.delegate.load(const Locale("en"));
    mockLoginCubit = MockLoginCubit();
    when(mockLoginCubit.state).thenReturn(LoginState());
    when(mockLoginCubit.stream).thenAnswer((_) => Stream.value(LoginState()));
    if (!getIt.isRegistered<LoginCubit>()) {
      getIt.registerSingleton<LoginCubit>(mockLoginCubit);
    } else {
      getIt.unregister<LoginCubit>();
      getIt.registerSingleton<LoginCubit>(mockLoginCubit);
    }
  });

  group("Test LoginScreen UI ", () {
    testWidgets("Both empty fields, button is disabled", (
      WidgetTester tester,
    ) async {
      /// Arrange
      await tester.pumpWidget(materialAppToLoginScreen());

      /// Assert
      expect(find.byType(Text), findsNWidgets(8));
      expect(find.text(localization.login), findsOneWidget);
      expect(find.bySemanticsLabel(localization.email), findsOneWidget);
      expect(find.text(localization.enter_your_email), findsOneWidget);
      expect(find.bySemanticsLabel(localization.password), findsOneWidget);
      expect(find.text(localization.enter_your_password), findsOneWidget);
      expect(find.text(localization.remember_me), findsOneWidget);
      expect(find.text(localization.forget_password), findsOneWidget);
      expect(find.text(localization.continue_text), findsOneWidget);
      expect(find.byType(IconButton), findsNWidgets(2));
      expect(find.byType(ElevatedButton), findsOneWidget);
    });

    testWidgets("email field is empty, button is disabled", (
      WidgetTester tester,
    ) async {
      /// Arrange
      await tester.pumpWidget(materialAppToLoginScreen());

      /// Assert
      expect(find.byType(Text), findsNWidgets(8));
      expect(find.text(localization.login), findsOneWidget);
      expect(find.bySemanticsLabel(localization.email), findsOneWidget);
      expect(find.bySemanticsLabel(localization.password), findsOneWidget);
      expect(find.text(localization.enter_your_password), findsOneWidget);
      expect(find.text(localization.remember_me), findsOneWidget);
      expect(find.text(localization.forget_password), findsOneWidget);
      expect(find.text(localization.continue_text), findsOneWidget);
      expect(find.byType(IconButton), findsNWidgets(2));
      expect(find.byType(ElevatedButton), findsOneWidget);
    });

    testWidgets("password field is empty, button is disabled", (
      WidgetTester tester,
    ) async {
      /// Arrange
      await tester.pumpWidget(materialAppToLoginScreen());

      /// Assert
      expect(find.byType(Text), findsNWidgets(8));
      expect(find.text(localization.login), findsOneWidget);
      expect(find.bySemanticsLabel(localization.email), findsOneWidget);
      expect(find.text(localization.enter_your_email), findsOneWidget);
      expect(find.bySemanticsLabel(localization.password), findsOneWidget);
      expect(find.text(localization.remember_me), findsOneWidget);
      expect(find.text(localization.forget_password), findsOneWidget);
      expect(find.text(localization.continue_text), findsOneWidget);
      expect(find.byType(IconButton), findsNWidgets(2));
      expect(find.byType(ElevatedButton), findsOneWidget);
    });
  });

  group("Test LoginScreen UI Validation", () {
    testWidgets("email field is not valid, button is enabled", (
      WidgetTester tester,
    ) async {
      /// Arrange
      when(mockLoginCubit.state).thenReturn(LoginState(isButtonEnabled: false));
      when(mockLoginCubit.stream).thenAnswer(
        (_) => Stream.fromIterable([
          LoginState(isButtonEnabled: false),
          LoginState(isButtonEnabled: true),
        ]),
      );
      await tester.pumpWidget(materialAppToLoginScreen());

      /// Assert
      expect(find.byType(Text), findsNWidgets(8));
      expect(find.text(localization.login), findsOneWidget);
      expect(find.bySemanticsLabel(localization.email), findsOneWidget);
      await tester.enterText(
        find.bySemanticsLabel(localization.email),
        invalidEmail,
      );
      expect(find.bySemanticsLabel(localization.password), findsOneWidget);
      await tester.enterText(
        find.bySemanticsLabel(localization.password),
        invalidPassword,
      );
      expect(find.text(localization.remember_me), findsOneWidget);
      expect(find.text(localization.forget_password), findsOneWidget);
      expect(find.text(localization.continue_text), findsOneWidget);
      expect(find.byType(IconButton), findsNWidgets(2));
      expect(find.byType(ElevatedButton), findsOneWidget);
      await tester.tap(find.text(localization.continue_text));
      await tester.pump();
      expect(find.byType(Text), findsNWidgets(9));
      expect(find.text(localization.email_is_not_valid), findsOneWidget);
    });
  });

  group("Test Cubit emits with LoginState", () {
    testWidgets("test emit error with data wrong", (WidgetTester tester) async {
      /// Arrange
      when(
        mockLoginCubit.state,
      ).thenReturn(LoginState(isError: false, isButtonEnabled: true));
      when(mockLoginCubit.stream).thenAnswer(
        (_) => Stream.fromIterable([
          LoginState(isError: false, isButtonEnabled: true),
          LoginState(isError: true),
        ]),
      );
      await tester.pumpWidget(materialAppToLoginScreen());

      /// Assert
      expect(find.byType(Text), findsNWidgets(8));
      expect(find.text(localization.login), findsOneWidget);
      expect(find.bySemanticsLabel(localization.email), findsOneWidget);
      await tester.enterText(
        find.bySemanticsLabel(localization.email),
        invalidEmail,
      );
      expect(find.bySemanticsLabel(localization.password), findsOneWidget);
      await tester.enterText(
        find.bySemanticsLabel(localization.password),
        invalidPassword,
      );
      expect(find.text(localization.remember_me), findsOneWidget);
      expect(find.text(localization.forget_password), findsOneWidget);
      expect(find.text(localization.continue_text), findsOneWidget);
      expect(find.byType(IconButton), findsNWidgets(2));
      expect(find.byType(ElevatedButton), findsOneWidget);
      await tester.tap(
        find.text(localization.continue_text),
        warnIfMissed: false,
      );
      await tester.pump();
      expect(find.byType(Text), findsNWidgets(11));
      expect(find.text(localization.error), findsOneWidget);
      expect(find.text(localization.ok), findsOneWidget);
    });
  });
}
