import 'package:flowery_tracking_app/core/l10n/translations/app_localizations.dart';
import 'package:flowery_tracking_app/features/auth/onboarding/onboarding.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group("OnBoardingScreen Localization Tests", () {
    testWidgets("onBoarding Screen English UI", (WidgetTester tester) async {
      /// Arrange
      await tester.pumpWidget(
        const MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          locale: Locale("en"),
          home: OnBoardingScreen(),
        ),
      );
      final localization = await AppLocalizations.delegate.load(
        const Locale("en"),
      );

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
    });
  });
}
