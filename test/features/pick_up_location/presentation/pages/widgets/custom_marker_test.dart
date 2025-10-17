import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flowery_tracking_app/features/pick_up_location/presentation/pages/widgets/custom_marker.dart';
import 'package:flowery_tracking_app/config/theme/colors.dart';

void main() {
  testWidgets('renders customMarker with icon and title', (
    WidgetTester tester,
  ) async {
    // Arrange
    const testTitle = 'My Marker';
    const testIcon = Icon(Icons.location_on, color: Colors.white);

    // Act
    await tester.pumpWidget(
      MaterialApp(home: Scaffold(body: customMarker(testIcon, testTitle))),
    );

    // Assert
    expect(find.text(testTitle), findsOneWidget);
    expect(find.byIcon(Icons.location_on), findsOneWidget);

    final container = tester.widget<Container>(find.byType(Container).first);
    final decoration = container.decoration as BoxDecoration;

    expect(decoration.color, AppColors.pink);
    expect(decoration.borderRadius, BorderRadius.circular(20));
  });

  testWidgets('renders customMarker without icon', (WidgetTester tester) async {
    // Arrange
    const testTitle = 'Destination';

    // Act
    await tester.pumpWidget(
      MaterialApp(home: Scaffold(body: customMarker(null, testTitle))),
    );

    // Assert
    expect(find.text(testTitle), findsOneWidget);
    expect(find.byIcon(Icons.location_on), findsNothing);
  });
}
