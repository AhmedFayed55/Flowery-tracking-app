import 'package:flowery_tracking_app/config/routing/app_routes.dart';
import 'package:flowery_tracking_app/core/di/di.dart';
import 'package:flowery_tracking_app/core/l10n/translations/app_localizations.dart';
import 'package:flowery_tracking_app/features/auth/login_screen/presentation/manager/login_state.dart';
import 'package:flowery_tracking_app/features/auth/login_screen/presentation/manager/login_view_model.dart';
import 'package:flowery_tracking_app/features/auth/login_screen/presentation/pages/login_screen.dart';
import 'package:flowery_tracking_app/features/auth/onboarding/onboarding.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'onboarding_test.mocks.dart';

@GenerateMocks([LoginCubit])
void main() {
  late MockLoginCubit mockLoginCubit;
  late AppLocalizations localization;

  Widget buildMaterialAppToOnBoarding() {
    return MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      locale: const Locale("en"),
      routes: {
        AppRoutes.login: (context) => const LoginScreen(),
        AppRoutes.onBoarding: (context) => const OnBoardingScreen(),
      },
      initialRoute: AppRoutes.onBoarding,
    );
  }

  setUp(() async {
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

  testWidgets(
    'OnBoardingScreen renders correctly and navigates on button tap',
    (WidgetTester tester) async {
      await tester.pumpWidget(buildMaterialAppToOnBoarding());

      expect(find.byType(Image), findsOneWidget);
      expect(find.text(localization.login), findsOneWidget);
      expect(find.text(localization.apply_now), findsOneWidget);
      expect(find.text(localization.app_version), findsOneWidget);
      expect(find.byType(ElevatedButton), findsNWidgets(2));
      expect(find.byKey(const Key('loginButton')), findsOneWidget);
      expect(find.byKey(const Key('applyButton')), findsOneWidget);
      await tester.tap(find.byKey(const Key('loginButton')));
      await tester.pumpAndSettle();
      expect(find.text(localization.remember_me), findsOneWidget);
    },
  );
}
