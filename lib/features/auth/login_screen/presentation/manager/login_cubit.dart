import 'package:flowery_tracking_app/core/di/di.dart';
import 'package:flowery_tracking_app/core/errors/api_results.dart';
import 'package:flowery_tracking_app/core/helpers/shared_pref.dart';
import 'package:flowery_tracking_app/core/utils/constants.dart';
import 'package:flowery_tracking_app/features/auth/login_screen/domain/entities/login_response_entity.dart';
import 'package:flowery_tracking_app/features/auth/login_screen/domain/usecases/login_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import 'login_event.dart';
import 'login_state.dart';

@injectable
class LoginCubit extends Cubit<LoginState> {
  final LoginUseCase loginUseCase;
  final sharedPreferences = getIt.get<SharedPrefHelper>();

  LoginCubit({required this.loginUseCase}) : super(LoginState());

  Future<void> doIntent(LoginEvent event) async {
    switch (event) {
      case GoToLoginEvent():
        await _login(event.email, event.password);
        break;
      case IsRememberMeEvent():
        await _isRememberMe(event.isRemember);
        break;
      case EmailChangedEvent():
        await _onChangedEmail(event.email);
      case PasswordChangedEvent():
        await _onChangedPassword(event.password);
    }
  }

  Future<void> _login(String email, String password) async {
    emit(state.copyWith(isLoading: true, isError: false, isSuccess: false));
    var result = await loginUseCase.call(email, password);
    switch (result) {
      case ApiSuccessResult<LoginResponseEntity>():
        emit(state.copyWith(isLoading: false, isSuccess: true));
        break;
      case ApiErrorResult<LoginResponseEntity>():
        emit(
          state.copyWith(
            isLoading: false,
            isError: true,
            showMessage: result.failure.errorMessage,
          ),
        );
    }
  }

  Future<void> _isRememberMe(bool isRemember) async {
    final changeRememberMe = !state.isRememberMe;
    sharedPreferences.saveData(
      key: AppConstants.isRemember,
      val: changeRememberMe,
    );
    emit(state.copyWith(isRememberMe: changeRememberMe, isError: false));
  }

  Future<void> _onChangedEmail(String email) async {
    emit(
      state.copyWith(
        isError: false,
        email: email,
        isButtonEnabled: email.isNotEmpty && state.password.isNotEmpty,
      ),
    );
  }

  Future<void> _onChangedPassword(String password) async {
    emit(
      state.copyWith(
        isError: false,
        password: password,
        isButtonEnabled: password.isNotEmpty && state.email.isNotEmpty,
      ),
    );
  }
}
