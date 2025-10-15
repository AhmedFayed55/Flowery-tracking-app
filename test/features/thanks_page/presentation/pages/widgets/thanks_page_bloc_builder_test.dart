import 'package:flowery_tracking_app/core/l10n/translations/app_localizations.dart';
import 'package:flowery_tracking_app/features/thanks_page/presentation/manger/cubit/thanks_cubit.dart';
import 'package:flowery_tracking_app/features/thanks_page/presentation/manger/cubit/thanks_state.dart';
import 'package:flowery_tracking_app/features/thanks_page/presentation/pages/widgets/thanks_page_bloc_builder.dart';
import 'package:flowery_tracking_app/features/thanks_page/presentation/pages/widgets/thanks_page_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'thanks_page_bloc_builder_test.mocks.dart';

@GenerateMocks([ThanksCubit])
void main() {
  late MockThanksCubit mockThanksCubit;

  setUp(() {
    mockThanksCubit = MockThanksCubit();
  });

  Widget makeTestableWidget() {
    return MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: BlocProvider<ThanksCubit>.value(
        value: mockThanksCubit,
        child: const ThanksPageBlocBuilder(orderId: '123'),
      ),
    );
  }

  testWidgets('shows loading indicator when state is loading', (
    WidgetTester tester,
  ) async {
    when(mockThanksCubit.state).thenReturn(const ThanksState(isLoading: true));

    when(mockThanksCubit.stream).thenAnswer(
      (_) => Stream.fromIterable([const ThanksState(isLoading: true)]),
    );

    await tester.pumpWidget(makeTestableWidget());

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
    expect(find.byType(ThanksPageBody), findsNothing);
  });

  testWidgets('shows error message and retry button when error occurs', (
    WidgetTester tester,
  ) async {
    when(
      mockThanksCubit.state,
    ).thenReturn(const ThanksState(errorMessage: 'Something went wrong'));

    when(mockThanksCubit.stream).thenAnswer(
      (_) => Stream.fromIterable([
        const ThanksState(errorMessage: 'Something went wrong'),
      ]),
    );

    await tester.pumpWidget(makeTestableWidget());

    expect(find.text('Something went wrong'), findsOneWidget);
    expect(find.text('Try again'), findsOneWidget);
    expect(find.byType(CircularProgressIndicator), findsNothing);
  });

  testWidgets('shows ThanksPageBody when state is ready', (
    WidgetTester tester,
  ) async {
    when(mockThanksCubit.state).thenReturn(const ThanksState());

    when(
      mockThanksCubit.stream,
    ).thenAnswer((_) => Stream.fromIterable([const ThanksState()]));

    await tester.pumpWidget(makeTestableWidget());

    expect(find.byType(ThanksPageBody), findsOneWidget);
    expect(find.byType(CircularProgressIndicator), findsNothing);
  });
}
