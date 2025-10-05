import 'package:flowery_tracking_app/features/order_details/presentation/pages/widget/order_details_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('OrderDetailsShimmer builds correctly', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: OrderDetailsShimmer(),
        ),
      ),
    );

    expect(find.byType(OrderDetailsShimmer), findsOneWidget);
    expect(find.byType(Container), findsWidgets);
    expect(find.byType(Column), findsOneWidget);
  });
}
