import 'package:flowery_tracking_app/core/l10n/translations/app_localizations.dart';
import 'package:flowery_tracking_app/features/order_details/presentation/pages/widget/order_status.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('OrderStatus displays correct data', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: Scaffold(
          body: OrderStatus(orderId: '123', date: '2025-10-05'),
        ),
      ),
    );

    expect(find.textContaining('Status'), findsOneWidget);
    expect(find.textContaining('123'), findsOneWidget);
    expect(find.text('2025-10-05'), findsOneWidget);
  });
}
