import 'package:flowery_tracking_app/config/theme/colors.dart';
import 'package:flowery_tracking_app/features/order_details/presentation/pages/widget/details_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  Widget createWidgetUnderTest({
    required String first,
    required String second,
  }) {
    return MaterialApp(
      home: Scaffold(
        body: Builder(
          builder: (context) =>
              DetailsWidget(firstText: first, secondText: second),
        ),
      ),
    );
  }

  testWidgets('renders firstText and secondText correctly', (tester) async {
    await tester.pumpWidget(
      createWidgetUnderTest(first: 'Order ID', second: '#12345'),
    );

    expect(find.text('Order ID'), findsOneWidget);
    expect(find.text('#12345'), findsOneWidget);
  });

  testWidgets('has correct visual structure', (tester) async {
    await tester.pumpWidget(
      createWidgetUnderTest(first: 'Status', second: 'Delivered'),
    );

    final containerFinder = find.byType(Container);
    final container = tester.widget<Container>(containerFinder.first);
    final decoration = container.decoration as BoxDecoration;

    expect(decoration.color, AppColors.white[10]);
    expect(decoration.borderRadius, BorderRadius.circular(10));
  });
}
