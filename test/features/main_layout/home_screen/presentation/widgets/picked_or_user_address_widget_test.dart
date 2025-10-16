import 'package:flowery_tracking_app/features/main_layout/home_screen/presentation/widgets/picked_or_user_address_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const testName = 'John Doe';
  const testAddress = '123 Main Street, Cairo';
  const testImage = 'https://example.com/image.jpg';

  Future<void> pumpWithFakeImage(WidgetTester tester, Widget widget) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(body: _FakeImageNetworkScope(child: widget)),
      ),
    );
  }

  group('PickedOrUserAddressWidget', () {
    testWidgets('renders name, address, and image correctly', (
      WidgetTester tester,
    ) async {
      await pumpWithFakeImage(
        tester,
        const PickedOrUserAddressWidget(
          name: testName,
          address: testAddress,
          image: testImage,
        ),
      );

      expect(find.text(testName), findsOneWidget);
      expect(find.text(testAddress), findsOneWidget);

      expect(find.byType(Image), findsOneWidget);
      expect(find.byType(CircleAvatar), findsOneWidget);
    });

    testWidgets('shows fallback icon when image fails to load', (
      WidgetTester tester,
    ) async {
      Future<void> pumpWithFakeImage(WidgetTester tester, Widget widget) async {
        await tester.pumpWidget(MaterialApp(home: Scaffold(body: widget)));
        await tester.pump(const Duration(milliseconds: 200));
      }

      await pumpWithFakeImage(
        tester,
        const PickedOrUserAddressWidget(
          name: testName,
          address: testAddress,
          image: 'invalid_url',
        ),
      );

      expect(find.byIcon(Icons.person), findsOneWidget);
    });

    testWidgets('shows loading indicator while image is loading', (
      WidgetTester tester,
    ) async {
      await pumpWithFakeImage(
        tester,
        const PickedOrUserAddressWidget(
          name: testName,
          address: testAddress,
          image: testImage,
        ),
      );

      expect(find.byType(CircularProgressIndicator), findsNothing);
    });
  });
}

class _FakeImageNetworkScope extends StatelessWidget {
  final Widget child;

  const _FakeImageNetworkScope({required this.child});

  @override
  Widget build(BuildContext context) {
    return _FakeImageNetwork(child: child);
  }
}

class _FakeImageNetwork extends StatelessWidget {
  final Widget child;

  const _FakeImageNetwork({required this.child});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Builder(
        builder: (_) {
          return MediaQuery(data: const MediaQueryData(), child: child);
        },
      ),
    );
  }
}
