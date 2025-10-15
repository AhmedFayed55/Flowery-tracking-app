import 'package:flowery_tracking_app/core/l10n/translations/app_localizations.dart';
import 'package:flowery_tracking_app/features/thanks_page/presentation/pages/widgets/thanks_page_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group("ThanksPage implementation Tests", () {
    // English UI
    testWidgets("ThanksPage English UI", (WidgetTester tester) async {
      await _testThanksPageUI(tester, const Locale("en"));
    });

    // Arabic UI
    testWidgets("ThanksPage Arabic UI", (WidgetTester tester) async {
      await _testThanksPageUI(tester, const Locale("ar"));
    });
  });
}

_testThanksPageUI(WidgetTester tester, Locale locale) async {
  // Arrange
  await tester.pumpWidget(
    MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      locale: locale,
      home: const ThanksPageBody(),
    ),
  );

  final localization = await AppLocalizations.delegate.load(locale);

  // Assert
  expect(find.byType(Icon), findsOneWidget);
  expect(find.byType(Text), findsNWidgets(3));
  expect(find.byType(ElevatedButton), findsOneWidget);
  expect(find.text(localization.thank_you), findsOneWidget);
  expect(
    find.text(localization.the_order_delivered_successfully),
    findsOneWidget,
  );
  expect(find.text(localization.done), findsOneWidget);
}
