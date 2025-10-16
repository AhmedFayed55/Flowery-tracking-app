import 'package:flowery_tracking_app/features/main_layout/home_screen/presentation/widgets/price_and_options_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flowery_tracking_app/core/l10n/translations/app_localizations.dart';

void main() {
  group('PriceAndOptionsWidget', () {
    testWidgets('renders price, reject, and accept buttons correctly', (
      WidgetTester tester,
    ) async {
      bool rejectCalled = false;
      bool acceptCalled = false;

      Future<void> pump(WidgetTester tester, Widget widget) async {
        await tester.pumpWidget(
          MaterialApp(
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: const [Locale('en')],
            home: Scaffold(body: widget),
          ),
        );
        await tester.pump(const Duration(milliseconds: 200));
      }

      await pump(
        tester,
        PriceAndOptionsWidget(
          price: 250,
          rejectOnTap: () => rejectCalled = true,
          acceptOnTap: () => acceptCalled = true,
        ),
      );

      expect(find.text('EGP 250'), findsOneWidget);

      expect(find.text('Reject'), findsOneWidget);
      expect(find.text('Accept'), findsOneWidget);

      await tester.tap(find.text('Reject'));
      await tester.pump();
      expect(rejectCalled, isTrue);

      await tester.tap(find.text('Accept'));
      await tester.pump();
      expect(acceptCalled, isTrue);
    });
  });
}
