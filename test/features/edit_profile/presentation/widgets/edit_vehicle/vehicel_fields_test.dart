import 'package:flowery_tracking_app/core/l10n/translations/app_localizations.dart';
import 'package:flowery_tracking_app/features/edit_profile/presentation/manger/vehicle_manger/vehicle_state.dart';
import 'package:flowery_tracking_app/features/edit_profile/presentation/manger/vehicle_manger/vehicle_view_model.dart';
import 'package:flowery_tracking_app/features/edit_profile/presentation/widgets/edit_vehicle/vehicel_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';

import 'vehicel_fields_test.mocks.dart';

@GenerateMocks([VehicleViewModel])
void main() {
  late MockVehicleViewModel mockCubit;
  late GlobalKey<FormState> formKey;

  setUp(() {
    mockCubit = MockVehicleViewModel();

    when(mockCubit.carNumberController).thenReturn(TextEditingController());

    when(mockCubit.state).thenReturn(VehicleState());
    when(
      mockCubit.stream,
    ).thenAnswer((_) => const Stream<VehicleState>.empty());

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
      home: BlocProvider<VehicleViewModel>.value(
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

  group('VehicelFields Widget Test (Mockito)', () {
    testWidgets('shows validation error when car number is empty', (
      tester,
    ) async {
      await tester.pumpWidget(buildTestWidget());

      formKey.currentState!.validate();
      await tester.pump();

      expect(find.text('Enter vehicle number'), findsOneWidget);
    });

    testWidgets('shows validation error when license image not uploaded', (
      tester,
    ) async {
      await tester.pumpWidget(buildTestWidget());

      formKey.currentState!.validate();
      await tester.pump();

      expect(find.text('Please upload license image'), findsOneWidget);
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
