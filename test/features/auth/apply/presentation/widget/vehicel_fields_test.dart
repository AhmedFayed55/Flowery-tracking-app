import 'package:flowery_tracking_app/core/l10n/translations/app_localizations.dart';
import 'package:flowery_tracking_app/features/auth/apply/presentation/view_model/apply_state.dart';
import 'package:flowery_tracking_app/features/auth/apply/presentation/view_model/apply_view_model.dart';
import 'package:flowery_tracking_app/features/auth/apply/presentation/widget/vehicel_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'vehicel_fields_test.mocks.dart';

@GenerateMocks([ApplyViewModel])
void main() {
  late MockApplyViewModel mockCubit;
  late GlobalKey<FormState> formKey;

  setUp(() {
    mockCubit = MockApplyViewModel();

    // stub controllers
    when(mockCubit.carNumberController).thenReturn(TextEditingController());

    // stub state stream
    when(mockCubit.state).thenReturn(ApplyState());
    when(mockCubit.stream).thenAnswer((_) => const Stream<ApplyState>.empty());

    formKey = GlobalKey<FormState>();
  });

  Widget buildTestWidget() {
    return MaterialApp(
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: const [Locale('en')],
      home: BlocProvider<ApplyViewModel>.value(
        value: mockCubit,
        child: Scaffold(
          body: Form(
            key: formKey,
            child: VehicelFields(
              cubit: mockCubit,
              onCarSelected: (_) {},
              onLicensePicked: (_) {},
            ),
          ),
        ),
      ),
    );
  }

  group('VehicelFields Widget Test', () {
    testWidgets('renders all fields', (tester) async {
      await tester.pumpWidget(buildTestWidget());

      // SelectedCarTextField rendered
      expect(find.byType(TextFormField), findsNWidgets(3));

      // ImageField rendered
      expect(find.byKey(const Key('ImageFieldKey')), findsOneWidget);

      // label text
      expect(find.text('Vehicle number'), findsOneWidget);
      expect(find.text('License image'), findsOneWidget);
    });

    testWidgets('shows validation error when car number is empty', (
      tester,
    ) async {
      await tester.pumpWidget(buildTestWidget());

      // trigger validation
      formKey.currentState!.validate();
      await tester.pump();

      expect(find.text('Enter vehicle number'), findsOneWidget);
    });

    testWidgets('removes validation error when car number is filled', (
      tester,
    ) async {
      await tester.pumpWidget(buildTestWidget());

      await tester.enterText(find.byType(TextFormField).first, '1234');
      formKey.currentState!.validate();
      await tester.pump();

      expect(find.text('1234'), findsOneWidget);
    });
  });
}
