import 'package:flowery_tracking_app/config/routing/app_routes.dart';
import 'package:flowery_tracking_app/core/l10n/translations/app_localizations.dart';
import 'package:flowery_tracking_app/features/auth/login_screen/presentation/pages/login_screen.dart';
import 'package:flowery_tracking_app/features/auth/onboarding/onboarding.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late AppLocalizations localization;
  Widget buildMaterialAppToOnBoarding() {
    return MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      locale: const Locale("en"),
      initialRoute: AppRoutes.onBoarding,
      routes: {
        AppRoutes.login: (context) => const LoginScreen(),
        AppRoutes.onBoarding: (context) => const OnBoardingScreen(),
      },
    );
  }

  setUp(() async {
    localization = await AppLocalizations.delegate.load(const Locale("en"));
  });

  group("OnBoardingScreen Localization Tests", () {
    testWidgets("onBoarding Screen UI", (WidgetTester tester) async {
      /// Arrange
      await tester.pumpWidget(buildMaterialAppToOnBoarding());

      /// Assert
      expect(find.byType(Image), findsOneWidget);
      expect(find.byType(Text), findsNWidgets(4));
      expect(
        find.text(localization.welcome_to_flowery_rider_app),
        findsOneWidget,
      );
      expect(find.text(localization.login), findsOneWidget);
      expect(find.text(localization.apply_now), findsOneWidget);
      expect(find.text(localization.app_version), findsOneWidget);
      expect(find.byType(ElevatedButton), findsNWidgets(2));
      await tester.tap(find.widgetWithText(ElevatedButton, localization.login));
      await tester.pumpAndSettle();
      expect(find.byType(LoginScreen), findsOneWidget);
    });
  });
}
