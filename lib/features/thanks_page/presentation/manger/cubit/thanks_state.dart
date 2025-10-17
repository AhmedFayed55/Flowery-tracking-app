import 'package:equatable/equatable.dart';

class ThanksState extends Equatable {
  final bool isLoading;
  final bool isSuccess;
  final String errorMessage;
  const ThanksState({
    this.isLoading = false,
    this.isSuccess = false,
    this.errorMessage = '',
  });

  ThanksState copyWith({
    bool? isLoading,
    bool? isSuccess,
    String? errorMessage,
  }) {
    return ThanksState(
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [isLoading, isSuccess, errorMessage];
}
