import 'package:flowery_tracking_app/core/di/di.dart';
import 'package:flowery_tracking_app/core/l10n/translations/app_localizations.dart';
import 'package:flowery_tracking_app/features/auth/change_password/view/page/change_password_screen.dart';
import 'package:flowery_tracking_app/features/auth/change_password/view/view_model/change_password_cubit.dart';
import 'package:flowery_tracking_app/features/auth/change_password/view/view_model/change_password_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'change_password_screen_test.mocks.dart';

@GenerateMocks([ChangePasswordViewModel])
void main() {
  late MockChangePasswordViewModel mockViewModel;

  setUp(() async {
    mockViewModel = MockChangePasswordViewModel();
    when(mockViewModel.state).thenReturn(ChangePasswordState());
    when(mockViewModel.stream).thenAnswer(
      (realInvocation) => Stream.fromIterable([ChangePasswordState()]),
    );

    if (!getIt.isRegistered<ChangePasswordViewModel>()) {
      getIt.registerSingleton<ChangePasswordViewModel>(mockViewModel);
    } else {
      getIt.unregister<ChangePasswordViewModel>();
      getIt.registerSingleton<ChangePasswordViewModel>(mockViewModel);
    }
    when(
      mockViewModel.oldPasswordController,
    ).thenReturn(TextEditingController());
    when(
      mockViewModel.newPasswordController,
    ).thenReturn(TextEditingController());
    when(
      mockViewModel.confirmPasswordController,
    ).thenReturn(TextEditingController());
  });
  Widget buildWidget() {
    return MaterialApp(
      home: BlocProvider(
        create: (context) => mockViewModel,
        child: const ChangePasswordScreen(),
      ),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      locale: const Locale("en"),
    );
  }

  group('change password screnn', () {
    testWidgets('renders text fields and button', (tester) async {
      await tester.pumpWidget(buildWidget());
      expect(find.byType(AppBar), findsOneWidget);
      expect(find.byType(ElevatedButton), findsOneWidget);
      expect(find.byType(TextFormField), findsNWidgets(3));
      expect(find.byType(Text), findsNWidgets(8));
    });
    testWidgets(
      'calls change password when button is pressed in loadding state',
      (tester) async {
        when(
          mockViewModel.state,
        ).thenReturn(ChangePasswordState(isLoading: true));
        when(mockViewModel.stream).thenAnswer(
          (realInvocation) =>
              Stream.fromIterable([ChangePasswordState(isLoading: true)]),
        );
        await tester.pumpWidget(buildWidget());
        await tester.tap(find.byType(ElevatedButton));
        expect(find.byType(CircularProgressIndicator), findsOneWidget);
      },
    );
    testWidgets('verify the button is disable', (tester) async {
      await tester.pumpWidget(buildWidget());
      final button = tester.widget<ElevatedButton>(find.byType(ElevatedButton));
      expect(button.enabled, false);
    });
    testWidgets('verify the button is enable', (tester) async {
      await tester.pumpWidget(buildWidget());
      await tester.enterText(
        find.byType(TextFormField).at(0),
        'yahya11@gmail.com',
      );
      await tester.enterText(find.byType(TextFormField).at(1), 'Yahya111!');
      await tester.enterText(find.byType(TextFormField).at(2), 'Yahya111!');
      await tester.pump();
      final button = tester.widget<ElevatedButton>(find.byType(ElevatedButton));
      expect(button.enabled, true);
    });
  });
}
