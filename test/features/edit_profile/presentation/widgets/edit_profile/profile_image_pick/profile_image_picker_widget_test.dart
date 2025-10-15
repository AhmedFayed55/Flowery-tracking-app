import 'package:flowery_tracking_app/core/l10n/translations/app_localizations.dart';
import 'package:flowery_tracking_app/features/edit_profile/presentation/widgets/edit_profile/profile_image_pick/profile_image_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ProfileImagePickerWidget', () {
    testWidgets('renders default person icon when no image provided', (
      tester,
    ) async {
      await tester.pumpWidget(
        const MaterialApp(
          localizationsDelegates: [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
          ],
          supportedLocales: [Locale('en')],
          home: Scaffold(body: ProfileImagePickerWidget()),
        ),
      );

      await tester.pumpAndSettle();

      expect(find.byIcon(Icons.person), findsOneWidget);
    });
  });
}
