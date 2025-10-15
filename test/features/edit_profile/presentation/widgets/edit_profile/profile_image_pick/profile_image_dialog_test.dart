import 'package:flowery_tracking_app/core/l10n/translations/app_localizations.dart';
import 'package:flowery_tracking_app/features/edit_profile/presentation/widgets/edit_profile/profile_image_pick/profile_image_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:image_picker/image_picker.dart';

void main() {
  Future<void> openDialog(
    WidgetTester tester,
    void Function(ImageSource) onPick,
  ) async {
    final widget = MaterialApp(
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
                key: const Key('openProfileImageDialogButton'),
                onPressed: () {
                  showProfileImageDialog(
                    context: context,
                    onPickImage: onPick,
                    hasImage: false,
                  );
                },
                child: const Text('Open'),
              ),
            ),
          );
        },
      ),
    );

    await tester.pumpWidget(widget);
    await tester.tap(find.byKey(const Key('openProfileImageDialogButton')));
    await tester.pumpAndSettle();
  }

  group('showProfileImageDialog', () {
    testWidgets('renders title and options', (tester) async {
      await openDialog(tester, (_) {});

      await tester.pumpAndSettle(const Duration(seconds: 1));

      expect(find.text('Select Profile Picture'), findsOneWidget);

      expect(find.text('Camera'), findsOneWidget);
      expect(find.text('Gallery'), findsOneWidget);
    });

    testWidgets(
      'invokes callback with ImageSource.gallery when Gallery tapped',
      (tester) async {
        ImageSource? picked;
        await openDialog(tester, (src) => picked = src);

        await tester.tap(find.text('Gallery'));
        await tester.pumpAndSettle();

        expect(picked, ImageSource.gallery);
      },
    );

    testWidgets('invokes callback with ImageSource.camera when Camera tapped', (
      tester,
    ) async {
      ImageSource? picked;
      await openDialog(tester, (src) => picked = src);

      await tester.tap(find.text('Camera'));
      await tester.pumpAndSettle();

      expect(picked, ImageSource.camera);
    });
  });
}
