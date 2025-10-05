import 'package:flowery_tracking_app/core/l10n/translations/app_localizations.dart';
import 'package:flowery_tracking_app/features/main_layout/home_screen/domain/entities/orders_entity.dart';
import 'package:flowery_tracking_app/features/main_layout/home_screen/domain/entities/store_entity.dart';
import 'package:flowery_tracking_app/features/main_layout/home_screen/domain/entities/user_entity.dart';
import 'package:flowery_tracking_app/features/order_details/presentation/pages/widget/order_details_body.dart';
import 'package:flowery_tracking_app/features/order_details/presentation/pages/widget/order_details_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:flowery_tracking_app/core/helpers/shared_pref.dart';
import 'package:flowery_tracking_app/core/di/di.dart';
import 'package:flowery_tracking_app/features/order_details/presentation/manger/cubit/order_details_cubit.dart';
import 'package:flowery_tracking_app/core/utils/enums.dart';

import 'order_details_body_test.mocks.dart';

@GenerateMocks([OrderDetailsCubit, SharedPrefHelper])
void main() {
  late MockOrderDetailsCubit mockCubit;
  late MockSharedPrefHelper mockSharedPref;

  setUp(() {
    mockCubit = MockOrderDetailsCubit();
    mockSharedPref = MockSharedPrefHelper();

    getIt.allowReassignment = true;
    getIt.registerSingleton<SharedPrefHelper>(mockSharedPref);
  });

  Widget createWidgetUnderTest() {
    return MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: BlocProvider<OrderDetailsCubit>.value(
        value: mockCubit,
        child: const OrderDetailsBody(),
      ),
    );
  }

  testWidgets('calls GetOrderDetailsEvent on initState', (tester) async {
    when(
      mockSharedPref.getData(key: anyNamed('key')),
    ).thenReturn('68c13135a8bca307f9e31cda');

    when(mockCubit.state).thenReturn(
      const OrderDetailsState(
        isSceenLoading: true,
        isLoading: false,
        isUpdating: false,
        riderOrderStatus: RiderOrderStatus.pending,
        orderDetails: null,
      ),
    );

    when(mockCubit.stream).thenAnswer(
      (_) => Stream.value(
        const OrderDetailsState(
          isSceenLoading: true,
          isLoading: false,
          isUpdating: false,
          riderOrderStatus: RiderOrderStatus.pending,
          orderDetails: null,
        ),
      ),
    );

    await tester.pumpWidget(createWidgetUnderTest());
    verify(mockCubit.doIntent(any)).called(1);
  });

  testWidgets('shows shimmer when isSceenLoading is true', (tester) async {
    when(
      mockSharedPref.getData(key: anyNamed('key')),
    ).thenReturn('68c13135a8bca307f9e31cda');

    when(mockCubit.state).thenReturn(
      const OrderDetailsState(
        isSceenLoading: true,
        isLoading: false,
        isUpdating: false,
        riderOrderStatus: RiderOrderStatus.pending,
        orderDetails: null,
      ),
    );

    when(mockCubit.stream).thenAnswer(
      (_) => Stream.value(
        const OrderDetailsState(
          isSceenLoading: true,
          isLoading: false,
          isUpdating: false,
          riderOrderStatus: RiderOrderStatus.pending,
          orderDetails: null,
        ),
      ),
    );

    await tester.pumpWidget(createWidgetUnderTest());

    expect(find.byType(OrderDetailsShimmer), findsOneWidget);
  });

  testWidgets('renders data UI when state has order details', (tester) async {
    when(
      mockSharedPref.getData(key: anyNamed('key')),
    ).thenReturn('68c13135a8bca307f9e31cda');

    when(mockCubit.state).thenReturn(
      OrderDetailsState(
        isSceenLoading: false,
        isLoading: false,
        isUpdating: false,
        riderOrderStatus: RiderOrderStatus.pending,
        orderDetails: OrdersEntity(
          id: '1',
          orderNumber: 'ORD123',
          createdAt: '2025-10-05T10:00:00Z',
          store: StoreEntity(
            name: 'Test Store',
            phoneNumber: '0100000000',
            address: 'Test Address',
            image: 'test.png',
          ),
          user: UserEntity(
            firstName: 'Ahmed',
            lastName: 'Yehia',
            phone: '0100000000',
            photo: 'photo.png',
          ),
          orderItems: [],
          totalPrice: 200,
          isPaid: false,
        ),
      ),
    );

    when(mockCubit.stream).thenAnswer((_) => const Stream.empty());

    await tester.pumpWidget(createWidgetUnderTest());
    await tester.pump();

    expect(find.textContaining('ORD123'), findsOneWidget);
    expect(find.textContaining('Total'), findsWidgets);
  });
}
