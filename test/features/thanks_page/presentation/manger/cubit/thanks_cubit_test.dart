import 'package:bloc_test/bloc_test.dart';
import 'package:flowery_tracking_app/features/thanks_page/domain/usecase/delete_order_local.dart';
import 'package:flowery_tracking_app/features/thanks_page/domain/usecase/set_order_as_completed_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:flowery_tracking_app/core/errors/api_results.dart';
import 'package:flowery_tracking_app/core/errors/failures.dart';
import 'package:flowery_tracking_app/core/utils/constants.dart';
import 'package:flowery_tracking_app/features/thanks_page/presentation/manger/cubit/thanks_cubit.dart';
import 'package:flowery_tracking_app/features/thanks_page/presentation/manger/cubit/thanks_state.dart';
import 'package:flowery_tracking_app/features/thanks_page/presentation/manger/cubit/thanks_event.dart';

import 'thanks_cubit_test.mocks.dart';

@GenerateMocks([SetOrderAsCompletedUsecase, DeleteOrderLocal])
void main() {
  late MockSetOrderAsCompletedUsecase mockSetOrderAsCompletedUsecase;
  late MockDeleteOrderLocal mockDeleteOrderLocal;
  late ThanksCubit cubit;
  provideDummy<ApiResult>(ApiSuccessResult(data: null));

  setUp(() {
    mockSetOrderAsCompletedUsecase = MockSetOrderAsCompletedUsecase();
    mockDeleteOrderLocal = MockDeleteOrderLocal();
    cubit = ThanksCubit(mockSetOrderAsCompletedUsecase, mockDeleteOrderLocal);
  });

  const String orderId = '123';

  tearDown(() {
    cubit.close();
  });

  group('ThanksCubit', () {
    blocTest<ThanksCubit, ThanksState>(
      'emits [loading, success] when setOrderAsCompletedUsecase returns success',
      build: () {
        when(
          mockSetOrderAsCompletedUsecase.invoke(orderId),
        ).thenAnswer((_) async => ApiSuccessResult(data: null));

        when(mockDeleteOrderLocal.invoke()).thenAnswer((_) async {});
        return cubit;
      },
      act: (cubit) => cubit.doIntent(InitialThanksEvent(orderId: orderId)),
      expect: () => [
        const ThanksState(isLoading: true),
        const ThanksState(isSuccess: true, isLoading: false),
      ],
      verify: (_) {
        verify(mockSetOrderAsCompletedUsecase.invoke(orderId)).called(1);
        verify(mockDeleteOrderLocal.invoke()).called(1);
      },
    );

    blocTest<ThanksCubit, ThanksState>(
      ' emits [loading, error] when setOrderAsCompletedUsecase returns failure',
      build: () {
        when(mockSetOrderAsCompletedUsecase.invoke(orderId)).thenAnswer(
          (_) async => ApiErrorResult(
            failure: Failure(errorMessage: AppConstants.noInternet),
          ),
        );
        return cubit;
      },
      act: (cubit) => cubit.doIntent(InitialThanksEvent(orderId: orderId)),
      expect: () => [
        const ThanksState(isLoading: true),
        const ThanksState(
          isLoading: false,
          errorMessage: AppConstants.noInternet,
        ),
      ],
      verify: (_) {
        verify(mockSetOrderAsCompletedUsecase.invoke(orderId)).called(1);
        verifyNever(mockDeleteOrderLocal.invoke());
      },
    );
  });
}
