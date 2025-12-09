import 'package:flowery_tracking_app/core/di/di.dart';
import 'package:flowery_tracking_app/features/orders_page/presentation/manager/get_all_orders_state.dart';
import 'package:flowery_tracking_app/features/orders_page/presentation/manager/get_all_orders_view_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'orders_page_test.mocks.dart';

@GenerateMocks([GetAllOrdersCubit])
void main() {
  late MockGetAllOrdersCubit mockGetAllOrdersCubit;

  setUp(() async {
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
}
