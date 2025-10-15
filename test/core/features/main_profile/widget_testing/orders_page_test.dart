import 'package:flowery_tracking_app/core/di/di.dart';
import 'package:flowery_tracking_app/core/l10n/translations/app_localizations.dart';
import 'package:flowery_tracking_app/features/orders_page/presentation/manager/get_all_orders_state.dart';
import 'package:flowery_tracking_app/features/orders_page/presentation/manager/get_all_orders_view_model.dart';
import 'package:flowery_tracking_app/features/orders_page/presentation/pages/orders_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'orders_page_test.mocks.dart';

@GenerateMocks([GetAllOrdersCubit])
void main() {
  late MockGetAllOrdersCubit mockGetAllOrdersCubit;
  late AppLocalizations localization;

  Widget materialAppToOrdersPage() {
    return MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      locale: const Locale('en'),
      home: BlocProvider(
        create: (_) => mockGetAllOrdersCubit,
        child: OrdersPage(),
      ),
    );
  }

  setUp(() async {
    localization = await AppLocalizations.delegate.load(const Locale('en'));
    mockGetAllOrdersCubit = MockGetAllOrdersCubit();

    when(mockGetAllOrdersCubit.state).thenReturn(GetAllOrdersState());
    when(
      mockGetAllOrdersCubit.stream,
    ).thenAnswer((_) => Stream.value(GetAllOrdersState()));

    if (!getIt.isRegistered<GetAllOrdersCubit>()) {
      getIt.registerSingleton<GetAllOrdersCubit>(mockGetAllOrdersCubit);
    } else {
      getIt.unregister<GetAllOrdersCubit>();
      getIt.registerSingleton<GetAllOrdersCubit>(mockGetAllOrdersCubit);
    }
  });

  testWidgets("test BlocBuilder when isLoading is true", (
    WidgetTester tester,
  ) async {
    when(
      mockGetAllOrdersCubit.state,
    ).thenReturn(GetAllOrdersState(isLoading: true));
    when(mockGetAllOrdersCubit.stream).thenAnswer(
      (_) => Stream.fromIterable([GetAllOrdersState(isLoading: true)]),
    );

    await tester.pumpWidget(materialAppToOrdersPage());

    expect(find.text(localization.my_orders), findsOneWidget);
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets("test BlocBuilder when isError is true", (
    WidgetTester tester,
  ) async {
    when(
      mockGetAllOrdersCubit.state,
    ).thenReturn(GetAllOrdersState(isError: true));
    when(mockGetAllOrdersCubit.stream).thenAnswer(
      (_) => Stream.fromIterable([GetAllOrdersState(isError: true)]),
    );

    await tester.pumpWidget(materialAppToOrdersPage());

    expect(find.text(localization.my_orders), findsOneWidget);
    expect(find.text(localization.no_orders_found), findsOneWidget);
  });
}
