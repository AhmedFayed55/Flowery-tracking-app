class ChangePasswordState {
  final bool isLoading;
  final bool isSuccess;
  final String? message;
  ChangePasswordState({
    this.isLoading = false,
    this.isSuccess = false,
    this.message,
  });
  ChangePasswordState copyWith({
    bool? isLoading,
    bool? isSuccess,
    String? message,
  }) {
    return ChangePasswordState(
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      message: message ?? this.message,
    );
  }
}
