import 'package:flowery_tracking_app/core/l10n/translations/app_localizations.dart';
import 'package:flowery_tracking_app/features/auth/apply/presentation/view_model/apply_view_model.dart';
import 'package:flowery_tracking_app/features/auth/apply/presentation/widget/name_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'contact_fields_test.mocks.dart';

@GenerateMocks([ApplyViewModel])
void main() {
  late ApplyViewModel cubit;
  late GlobalKey<FormState> formKey;

  setUp(() {
    cubit = MockApplyViewModel();
    when(cubit.firstNameController).thenReturn(TextEditingController());
    when(cubit.lastNameController).thenReturn(TextEditingController());
    formKey = GlobalKey<FormState>();
  });

  Widget prepareWidget() {
    return MaterialApp(
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: const [Locale('en')],
      home: Scaffold(
        body: Form(
          key: formKey,
          child: NameFields(cubit: cubit),
        ),
      ),
    );
  }

  group('NameFields', () {
    testWidgets('renders name fields', (tester) async {
      await tester.pumpWidget(prepareWidget());
      expect(find.byType(TextFormField), findsNWidgets(2));
    });

    testWidgets('shows error when fields are empty', (tester) async {
      await tester.pumpWidget(prepareWidget());

      // trigger validation
      formKey.currentState!.validate();
      await tester.pump();

      expect(find.text('Enter first legal name'), findsOneWidget);
      expect(find.text('Enter last legal name'), findsOneWidget);
    });

    testWidgets('hides error when fields are filled', (tester) async {
      await tester.pumpWidget(prepareWidget());

      await tester.enterText(find.byType(TextFormField).at(0), 'yahya');
      await tester.enterText(find.byType(TextFormField).at(1), 'mohamed');
      await tester.pump();
      expect(find.text('yahya'), findsOneWidget);
      expect(find.text('mohamed'), findsOneWidget);
    });
  });
}
