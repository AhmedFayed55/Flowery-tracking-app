class LoginState {
  final bool isLoading;
  final bool isSuccess;
  final bool isError;
  final bool isRememberMe;
  final String showMessage;
  final String email;
  final String password;
  final bool isButtonEnabled;

  LoginState({
    this.isError = false,
    this.isSuccess = false,
    this.showMessage = "",
    this.isLoading = false,
    this.isRememberMe = false,
    this.isButtonEnabled = false,
    this.email = "",
    this.password = "",
  });

  LoginState copyWith({
    bool? isLoading,
    bool? isSuccess,
    bool? isError,
    bool? isRememberMe,
    bool? isButtonEnabled,
    String? showMessage,
    String? email,
    String? password,
  }) {
    return LoginState(
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      isError: isError ?? this.isError,
      isButtonEnabled: isButtonEnabled ?? this.isButtonEnabled,
      isRememberMe: isRememberMe ?? this.isRememberMe,
      showMessage: showMessage ?? this.showMessage,
      email: email ?? this.email,
      password: password ?? this.password,
    );
  }
}
