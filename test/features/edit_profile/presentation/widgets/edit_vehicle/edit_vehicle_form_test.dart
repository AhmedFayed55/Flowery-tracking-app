import 'package:flowery_tracking_app/core/l10n/translations/app_localizations.dart';
import 'package:flowery_tracking_app/features/edit_profile/presentation/manger/vehicle_manger/vehicle_state.dart';
import 'package:flowery_tracking_app/features/edit_profile/presentation/manger/vehicle_manger/vehicle_view_model.dart';
import 'package:flowery_tracking_app/features/edit_profile/presentation/widgets/edit_vehicle/form/edit_vehicle_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'edit_vehicle_form_test.mocks.dart';

@GenerateMocks([VehicleViewModel])
void main() {
  late MockVehicleViewModel mockViewModel;

  setUp(() {
    mockViewModel = MockVehicleViewModel();

    // Stub basic Cubit state/stream
    when(mockViewModel.state).thenReturn(VehicleState());
    when(
      mockViewModel.stream,
    ).thenAnswer((_) => const Stream<VehicleState>.empty());

    // Stub controller(s) used by fields
    when(mockViewModel.carNumberController).thenReturn(TextEditingController());

    // Stub intents called in initState
    when(mockViewModel.doIntent(any)).thenAnswer((_) async {});
  });

  Widget buildTestWidget() {
    return MaterialApp(
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: const [Locale('en')],
      home: BlocProvider<VehicleViewModel>.value(
        value: mockViewModel,
        child: const EditVehicleForm(),
      ),
    );
  }

  group('EditVehicleForm Widget Test', () {
    testWidgets('validates required fields when pressing Update', (
      tester,
    ) async {
      await tester.pumpWidget(buildTestWidget());

      // Tap the update button to trigger form validation
      await tester.tap(find.text('Update'));
      await tester.pump();

      // Vehicle number validation message
      expect(find.text('Enter vehicle number'), findsOneWidget);

      // Image field validation message
      expect(find.text('Please upload license image'), findsOneWidget);
    });

    testWidgets('calls doIntent on init to fetch vehicles', (tester) async {
      await tester.pumpWidget(buildTestWidget());
      await tester.pump();

      verify(mockViewModel.doIntent(any)).called(1);
    });
  });
}
