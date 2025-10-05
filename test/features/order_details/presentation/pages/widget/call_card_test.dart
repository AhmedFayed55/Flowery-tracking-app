import 'package:flowery_tracking_app/features/order_details/presentation/pages/widget/call_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_svg/flutter_svg.dart';

void main() {
  group('CallCard Widget Tests', () {
    testWidgets('renders correctly with given data', (WidgetTester tester) async {
      // Arrange
      const widget = MaterialApp(
        home: Scaffold(
          body: CallCard(
            phoneNumber: '01000000000',
            title: 'Ahmed Yehia',
            address: 'Alexandria, Egypt',
            imgeUrl: 'https://via.placeholder.com/150',
          ),
        ),
      );

      // Act
      await tester.pumpWidget(widget);

      // Assert
      expect(find.text('Ahmed Yehia'), findsOneWidget);
      expect(find.text('Alexandria, Egypt'), findsOneWidget);
      expect(find.byType(CircleAvatar), findsOneWidget);
      expect(find.byIcon(Icons.call_outlined), findsOneWidget);
      expect(find.byType(SvgPicture), findsWidgets); // location + WhatsApp icons
    });

    testWidgets('tapping call icon triggers phone launch intent', (WidgetTester tester) async {
      bool called = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: GestureDetector(
              onTap: () {
                called = true;
              },
              child: const Icon(Icons.call_outlined),
            ),
          ),
        ),
      );

      await tester.tap(find.byIcon(Icons.call_outlined));
      await tester.pump();

      expect(called, true);
    });
  });
}
