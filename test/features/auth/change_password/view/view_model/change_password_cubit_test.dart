import 'package:bloc_test/bloc_test.dart';
import 'package:flowery_tracking_app/core/errors/api_results.dart';
import 'package:flowery_tracking_app/features/auth/change_password/domain/entities/change_password_request_entity.dart';
import 'package:flowery_tracking_app/features/auth/change_password/domain/use%20case/change_password_use_case.dart';
import 'package:flowery_tracking_app/features/auth/change_password/view/view_model/change_password_cubit.dart';
import 'package:flowery_tracking_app/features/auth/change_password/view/view_model/change_password_event.dart';
import 'package:flowery_tracking_app/features/auth/change_password/view/view_model/change_password_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'change_password_cubit_test.mocks.dart';

@GenerateMocks([ChangePasswordUseCase])
void main() {
  provideDummy<ApiResult<void>>(ApiSuccessResult(data: null));

  MockChangePasswordUseCase mockChangePasswordUseCase =
      MockChangePasswordUseCase();
  blocTest(
    'verify ChangePasswordCubit',
    build: () {
      when(
        mockChangePasswordUseCase.call(any),
      ).thenAnswer((_) async => ApiSuccessResult(data: null));

      return ChangePasswordViewModel(mockChangePasswordUseCase);
    },

    act: (bloc) => bloc.doIntent(
      ChangePasswordEvent(
        ChangePasswordRequestEntity(
          newPassword: 'newPassword',
          oldPassword: 'oldPassword',
        ),
      ),
    ),
    expect: () => [
      predicate<ChangePasswordState>((state) => state.isLoading == true),

      predicate<ChangePasswordState>((state) => state.isSuccess == true),
    ],
  );
}
