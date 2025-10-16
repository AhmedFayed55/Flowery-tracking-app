import 'package:flowery_tracking_app/core/components/shimmer.dart';
import 'package:flowery_tracking_app/core/di/di.dart';
import 'package:flowery_tracking_app/core/l10n/translations/app_localizations.dart';
import 'package:flowery_tracking_app/features/main_layout/home_screen/presentation/manager/home_tab_state.dart';
import 'package:flowery_tracking_app/features/main_layout/home_screen/presentation/manager/home_tab_view_model.dart';
import 'package:flowery_tracking_app/features/main_layout/home_screen/presentation/pages/home_tab.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'home_tab_test.mocks.dart';

@GenerateMocks([HomeTabViewModel])
void main() {
  late MockHomeTabViewModel mockHomeTabViewModel;

  Widget buildMaterialApp() {
    return MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      locale: const Locale('en'),
      home: BlocProvider<HomeTabViewModel>(
        create: (context) => mockHomeTabViewModel,
        child: const HomeTab(),
      ),
    );
  }

  setUp(() async {
    mockHomeTabViewModel = MockHomeTabViewModel();

    when(mockHomeTabViewModel.state).thenReturn(const HomeTabState());
    when(
      mockHomeTabViewModel.stream,
    ).thenAnswer((_) => Stream.value(const HomeTabState()));
    when(mockHomeTabViewModel.doIntent(any)).thenAnswer((_) => null);
    when(
      mockHomeTabViewModel.refreshIndicatorKey,
    ).thenReturn(GlobalKey<RefreshIndicatorState>());

    if (!getIt.isRegistered<HomeTabViewModel>()) {
      getIt.registerSingleton<HomeTabViewModel>(mockHomeTabViewModel);
    } else {
      getIt.unregister<HomeTabViewModel>();
      getIt.registerSingleton<HomeTabViewModel>(mockHomeTabViewModel);
    }
  });

  testWidgets('AppBar title is rendered correctly', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(buildMaterialApp());

    expect(find.byType(AppBar), findsOneWidget);
    expect(find.text('Flowery Rider'), findsOneWidget);
  });

  testWidgets('HomeTab shows shimmer when loading', (
    WidgetTester tester,
  ) async {
    when(
      mockHomeTabViewModel.state,
    ).thenReturn(const HomeTabState(isLoadingGetOrders: true));
    when(mockHomeTabViewModel.stream).thenAnswer(
      (_) => Stream.value(const HomeTabState(isLoadingGetOrders: true)),
    );

    await tester.pumpWidget(buildMaterialApp());
    expect(find.byType(CustomShimmerWidget), findsOneWidget);
  });

  testWidgets('HomeTab triggers doIntent on  pull-to-refresh', (
    WidgetTester tester,
  ) async {
    when(mockHomeTabViewModel.state).thenReturn(const HomeTabState());
    when(
      mockHomeTabViewModel.stream,
    ).thenAnswer((_) => Stream.value(const HomeTabState()));

    await tester.pumpWidget(buildMaterialApp());

    final gesture = await tester.startGesture(const Offset(0, 150));
    await gesture.moveBy(const Offset(0, 150));
    await gesture.up();
  });
}
