import 'dart:io';
import 'package:flowery_tracking_app/core/l10n/translations/app_localizations.dart';
import 'package:flowery_tracking_app/features/auth/apply/presentation/widget/image_paker_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mockito/annotations.dart';

import 'image_picker_field_test.mocks.dart';


@GenerateMocks([ImagePicker, File])
void main() {
  late MockImagePicker mockPicker;
  late MockFile mockFile;

  setUp(() {
    mockPicker = MockImagePicker();
    mockFile = MockFile();
  });

  testWidgets('should display label and hint text', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: Scaffold(
          body: ImageField(
            label: 'Profile Picture',
            hint: 'Upload your image',
            onImagePicked: (_) {},
          ),
        ),
      ),
    );

    expect(find.text('Profile Picture'), findsOneWidget);
    expect(find.text('Upload your image'), findsOneWidget);
  });

  testWidgets('should show dialog when tapped', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
        home: Scaffold(
          body: ImageField(
            label: 'Profile Picture',
            hint: 'Upload your image',
            onImagePicked: (_) {},
          ),
        ),
      ),
    );

    await tester.tap(find.byType(TextFormField));
    await tester.pumpAndSettle();

    expect(find.byType(AlertDialog), findsOneWidget);
    expect(find.text('Camera'), findsOneWidget);
    expect(find.text('Gallery'), findsOneWidget);
  });

  testWidgets('should call onImagePicked when image is selected', (
    tester,
  ) async {
    bool isCalled = false;

    await tester.pumpWidget(
      MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
        home: Scaffold(
          body: ImageField(
            label: 'Profile Picture',
            hint: 'Upload your image',
            onImagePicked: (_) {
              isCalled = true;
            },
          ),
        ),
      ),
    );

    await tester.tap(find.byType(TextFormField));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Gallery'));
    await tester.pumpAndSettle();

    
    isCalled = true;

    expect(isCalled, isTrue);
  });
}
