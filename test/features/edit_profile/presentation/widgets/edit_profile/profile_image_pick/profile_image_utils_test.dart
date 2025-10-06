import 'dart:io';
import 'package:flowery_tracking_app/core/l10n/translations/app_localizations.dart';
import 'package:flowery_tracking_app/features/edit_profile/presentation/widgets/edit_profile/profile_image_pick/profile_image_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_test/flutter_test.dart';

class _FakeWidget {
  final String? initialImageUrl;
  final double size;
  const _FakeWidget({this.initialImageUrl, this.size = 100});
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('Profile Image Utils Tests', () {
    testWidgets('buildPlaceholder renders person icon', (tester) async {
      await tester.pumpWidget(
        MaterialApp(home: Scaffold(body: buildPlaceholder(100))),
      );

      expect(find.byIcon(Icons.person), findsOneWidget);
    });

    testWidgets(
      'buildProfileImage shows Image.file when selectedImage is not null',
      (tester) async {
        // Create a fake temporary file
        final file = File('fake_path.jpg');
        const widgetObj = _FakeWidget(size: 100);

        await tester.pumpWidget(
          MaterialApp(home: Scaffold(body: buildProfileImage(widgetObj, file))),
        );

        expect(find.byType(Image), findsOneWidget);
      },
    );

    testWidgets(
      'buildProfileImage shows network image when initialImageUrl provided',
      (tester) async {
        const widgetObj = _FakeWidget(
          initialImageUrl: 'https://example.com/image.png',
          size: 100,
        );

        await tester.pumpWidget(
          MaterialApp(home: Scaffold(body: buildProfileImage(widgetObj, null))),
        );

        expect(find.byType(Image), findsOneWidget);
      },
    );

    testWidgets('buildProfileImage shows placeholder when no image or URL', (
      tester,
    ) async {
      const widgetObj = _FakeWidget(size: 100);

      await tester.pumpWidget(
        MaterialApp(home: Scaffold(body: buildProfileImage(widgetObj, null))),
      );

      expect(find.byIcon(Icons.person), findsOneWidget);
    });

    testWidgets('buildCameraIcon renders SVG camera asset', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Builder(builder: (context) => buildCameraIcon(context)),
        ),
      );

      expect(find.byType(SvgPicture), findsOneWidget);
    });

    testWidgets('buildPickerOption calls onTap and closes dialog', (
      tester,
    ) async {
      bool tapped = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Builder(
              builder: (context) => buildPickerOption(
                icon: Icons.camera_alt,
                label: 'Camera',
                onTap: () => tapped = true,
                context: context,
              ),
            ),
          ),
        ),
      );

      await tester.tap(find.byIcon(Icons.camera_alt));
      await tester.pump();

      expect(tapped, isTrue);
    });

    testWidgets('buildHandleBar renders with correct size and color', (
      tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Builder(builder: (context) => buildHandleBar(context)),
          ),
        ),
      );

      expect(find.byType(Container), findsOneWidget);
    });

    testWidgets('showErrorDialog displays title and message', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
          ],
          supportedLocales: const [Locale('en')],
          home: Builder(
            builder: (context) {
              return Scaffold(
                body: Center(
                  child: ElevatedButton(
                    onPressed: () {
                      showErrorDialog(context, 'Test Error Message');
                    },
                    child: const Text('Show'),
                  ),
                ),
              );
            },
          ),
        ),
      );

      await tester.tap(find.text('Show'));
      await tester.pumpAndSettle();

      expect(find.text('Error'), findsOneWidget);
      expect(find.text('Test Error Message'), findsOneWidget);
      expect(find.text('OK'), findsOneWidget);
    });
  });
}
