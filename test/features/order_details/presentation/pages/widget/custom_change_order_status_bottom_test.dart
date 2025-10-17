import 'package:flowery_tracking_app/core/l10n/translations/app_localizations.dart';
import 'package:flowery_tracking_app/core/utils/enums.dart';
import 'package:flowery_tracking_app/features/main_layout/home_screen/domain/entities/get_pending_orders/orders_entity.dart';
import 'package:flowery_tracking_app/features/order_details/presentation/manger/cubit/order_details_cubit.dart';
import 'package:flowery_tracking_app/features/order_details/presentation/manger/cubit/order_details_event.dart';
import 'package:flowery_tracking_app/features/order_details/presentation/manger/cubit/order_details_state.dart';
import 'package:flowery_tracking_app/features/order_details/presentation/pages/widget/custom_change_order_status_bottom.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'custom_change_order_status_bottom_test.mocks.dart';

@GenerateMocks([OrderDetailsCubit])
void main() {
  late MockOrderDetailsCubit mockCubit;

  setUp(() {
    mockCubit = MockOrderDetailsCubit();
  });

  Widget createWidgetUnderTest() {
    return MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: BlocProvider<OrderDetailsCubit>.value(
        value: mockCubit,
        child: const Scaffold(body: CustomChangeOrderStatusBottom()),
      ),
    );
  }

  testWidgets('shows CircularProgressIndicator when updating', (tester) async {
    when(mockCubit.state).thenReturn(
      const OrderDetailsState(
        isOrderCompleted: false,
        isSceenLoading: false,
        isLoading: false,
        isUpdating: true,
      ),
    );
    when(mockCubit.stream).thenAnswer(
      (_) => Stream.fromIterable([
        const OrderDetailsState(
          isOrderCompleted: false,
          isSceenLoading: false,
          isLoading: false,
          isUpdating: true,
        ),
      ]),
    );

    await tester.pumpWidget(createWidgetUnderTest());
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('shows correct text when status is pending', (tester) async {
    when(mockCubit.state).thenReturn(
      const OrderDetailsState(
        isOrderCompleted: false,
        isSceenLoading: false,
        isLoading: false,
        isUpdating: false,
        riderOrderStatus: RiderOrderStatus.pending,
      ),
    );
    when(mockCubit.stream).thenAnswer(
      (_) => Stream.fromIterable([
        const OrderDetailsState(
          isOrderCompleted: false,
          isSceenLoading: false,
          isLoading: false,
          isUpdating: false,
          riderOrderStatus: RiderOrderStatus.pending,
        ),
      ]),
    );

    await tester.pumpWidget(createWidgetUnderTest());
    expect(find.text(RiderOrderStatus.pending.nextStatusButton), findsOneWidget);
  });

  testWidgets('disables button when status is delivered', (tester) async {
    when(mockCubit.state).thenReturn(
      const OrderDetailsState(
        isOrderCompleted: false,
        isSceenLoading: false,
        isLoading: false,
        isUpdating: false,
        riderOrderStatus: RiderOrderStatus.delivered,
      ),
    );
    when(mockCubit.stream).thenAnswer(
      (_) => Stream.fromIterable([
        const OrderDetailsState(
          isOrderCompleted: false,
          isSceenLoading: false,
          isLoading: false,
          isUpdating: false,
          riderOrderStatus: RiderOrderStatus.delivered,
        ),
      ]),
    );

    await tester.pumpWidget(createWidgetUnderTest());
    final button = tester.widget<ElevatedButton>(find.byType(ElevatedButton));
    expect(button.onPressed, isNull);
  });

  testWidgets('triggers ChangeToNextStatusEvent on button press', (
    tester,
  ) async {
    when(mockCubit.state).thenReturn(
      OrderDetailsState(
        isOrderCompleted: false,
        isSceenLoading: false,
        isLoading: false,
        isUpdating: false,
        riderOrderStatus: RiderOrderStatus.pending,
        orderDetails: OrdersEntity(id: 'abc123'),
      ),
    );
    when(mockCubit.stream).thenAnswer(
      (_) => Stream.fromIterable([
        OrderDetailsState(
          isOrderCompleted: false,
          isSceenLoading: false,
          isLoading: false,
          isUpdating: false,
          riderOrderStatus: RiderOrderStatus.pending,
          orderDetails: OrdersEntity(id: 'abc123'),
        ),
      ]),
    );

    when(mockCubit.doIntent(any)).thenAnswer((_) async {});

    await tester.pumpWidget(createWidgetUnderTest());
    await tester.tap(find.byType(ElevatedButton));
    await tester.pump();

    verify(
      mockCubit.doIntent(ChangeToNextStatusEvent(orderId: 'abc123')),
    ).called(1);
  });
}
