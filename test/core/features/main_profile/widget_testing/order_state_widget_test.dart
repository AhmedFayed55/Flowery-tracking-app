import 'package:flowery_tracking_app/core/utils/constants.dart';
import 'package:flowery_tracking_app/features/orders_page/domain/entities/get_all_orders_entity.dart';
import 'package:flowery_tracking_app/features/orders_page/domain/entities/order_state_model.dart';
import 'package:flowery_tracking_app/features/orders_page/domain/entities/orders_dto_entity.dart';
import 'package:flowery_tracking_app/features/orders_page/domain/entities/order_dto_entity.dart';
import 'package:flowery_tracking_app/features/orders_page/domain/entities/metadata_dto_entity.dart';
import 'package:flowery_tracking_app/features/orders_page/presentation/manager/get_all_orders_state.dart';
import 'package:flowery_tracking_app/features/orders_page/presentation/manager/get_all_orders_view_model.dart';
import 'package:flowery_tracking_app/features/orders_page/presentation/widgets/order_state_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'order_state_widget_test.mocks.dart';

@GenerateMocks([GetAllOrdersCubit])
void main() {
  late MockGetAllOrdersCubit mockCubit;

  setUp(() {
    mockCubit = MockGetAllOrdersCubit();
  });

  Widget createWidgetUnderTest(OrderStateModel orderState, {int index = 0}) {
    // Dummy data
    final dummyOrders = GetAllOrdersEntity(
      ordersDtoEntity: [
        OrdersDtoEntity(
          orderDtoEntity: OrderDtoEntity(state: AppConstants.completed),
        ),
      ],
      metadataDtoEntity: MetadataDtoEntity(totalItems: 5),
    );

    final state = GetAllOrdersState(getAllOrdersEntity: dummyOrders);

    when(mockCubit.state).thenReturn(state);
    when(mockCubit.stream).thenAnswer((_) => Stream.value(state));

    return MaterialApp(
      home: BlocProvider<GetAllOrdersCubit>.value(
        value: mockCubit,
        child: Scaffold(
          body: OrderStateWidget(index: index, orderState: orderState),
        ),
      ),
    );
  }

  testWidgets("OrderStateWidget if state is matched", (
    WidgetTester tester,
  ) async {
    final orderState = OrderStateModel(
      state: AppConstants.completed,
      icon: const Icon(Icons.check_circle_outline),
    );

    await tester.pumpWidget(createWidgetUnderTest(orderState));
    await tester.pumpAndSettle();

    expect(find.text('5'), findsOneWidget);
    expect(find.byIcon(Icons.check_circle_outline), findsOneWidget);
  });

  testWidgets("OrderStateWidget if state is not matched", (
    WidgetTester tester,
  ) async {
    final orderState = OrderStateModel(
      state: AppConstants.cancelled,
      icon: const Icon(Icons.cancel_outlined),
    );

    await tester.pumpWidget(createWidgetUnderTest(orderState));
    await tester.pumpAndSettle();

    expect(find.text('0'), findsOneWidget);
    expect(find.byIcon(Icons.cancel_outlined), findsOneWidget);
  });
}
