import 'package:flowery_tracking_app/core/l10n/translations/app_localizations.dart';
import 'package:flowery_tracking_app/features/auth/apply/presentation/view_model/apply_view_model.dart';
import 'package:flowery_tracking_app/features/auth/apply/presentation/widget/contact_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'contact_fields_test.mocks.dart';

@GenerateMocks([ApplyViewModel])
void main() {
  late ApplyViewModel cubit;

  setUp(() {
    cubit = MockApplyViewModel();
    when(cubit.emailController).thenReturn(TextEditingController());
    when(cubit.phoneController).thenReturn(TextEditingController());
  });

  Widget createWidgetUnderTest() {
    return MaterialApp(
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: const [Locale('en')],
      home: Scaffold(
        body: Form(
          key: GlobalKey<FormState>(),
          child: ContactFields(cubit: cubit),
        ),
      ),
    );
  }

  testWidgets('renders email and phone fields', (WidgetTester tester) async {
    await tester.pumpWidget(createWidgetUnderTest());

    expect(find.byType(TextFormField), findsNWidgets(2));
    expect(find.text('Email'), findsOneWidget);
    expect(find.text('Phone number'), findsOneWidget);
  });

  testWidgets('shows validation error when fields are empty', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(createWidgetUnderTest());
    expect(find.text('Enter your email'), findsOneWidget);
    expect(find.text('Enter phone number'), findsOneWidget);
  });

  testWidgets('removes error when valid input is entered', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(createWidgetUnderTest());

    await tester.enterText(find.byType(TextFormField).at(0), 'test@mail.com');
    await tester.enterText(find.byType(TextFormField).at(1), '0123456789');

    final formState = tester.state<FormState>(find.byType(Form));
    formState.validate();
    expect(formState.validate(), isTrue);
  });
}
