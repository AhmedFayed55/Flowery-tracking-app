part of 'forget_password_cubit.dart';

class ForgetPasswordState extends Equatable {
  final bool isvrifyCodeSent;
  final bool isVerifyCodeSentLoading;
  final bool isOtpCorrect;
  final bool isOtpCorrectLoading;
  final bool isPasswordReset;
  final bool isPasswordResetLoading;

  final String? email;

  final String? errorOtp;
  final String? errorEmail;
  final String? errorPassword;

  const ForgetPasswordState({
    this.isvrifyCodeSent = false,
    this.isOtpCorrect = false,
    this.isPasswordReset = false,
    this.isOtpCorrectLoading = false,
    this.isPasswordResetLoading = false,
    this.isVerifyCodeSentLoading = false,
    this.email = '',
    this.errorOtp = '',
    this.errorEmail = '',
    this.errorPassword = '',
  });

  ForgetPasswordState copyWith({
    bool? isvrifyCodeSent,
    bool? isOtpCorrect,
    bool? isPasswordReset,
    bool? isOtpCorrectLoading,
    bool? isPasswordResetLoading,
    bool? isVerifyCodeSentLoading,
    String? email,
    String? errorOtp,
    String? errorEmail,
    String? errorPassword,
  }) {
    return ForgetPasswordState(
      isvrifyCodeSent: isvrifyCodeSent ?? this.isvrifyCodeSent,
      isOtpCorrect: isOtpCorrect ?? this.isOtpCorrect,
      isPasswordReset: isPasswordReset ?? this.isPasswordReset,
      email: email ?? this.email,
      isOtpCorrectLoading: isOtpCorrectLoading ?? this.isOtpCorrectLoading,
      isPasswordResetLoading:
          isPasswordResetLoading ?? this.isPasswordResetLoading,
      isVerifyCodeSentLoading:
          isVerifyCodeSentLoading ?? this.isVerifyCodeSentLoading,
      errorOtp: errorOtp ?? this.errorOtp,
      errorEmail: errorEmail ?? this.errorEmail,
      errorPassword: errorPassword ?? this.errorPassword,
    );
  }

  @override
  List<Object?> get props => [
    isvrifyCodeSent,
    isOtpCorrect,
    isPasswordReset,
    email,
    errorOtp,
    errorEmail,
    errorPassword,
    isOtpCorrectLoading,
    isPasswordResetLoading,
    isVerifyCodeSentLoading,
  ];
}
