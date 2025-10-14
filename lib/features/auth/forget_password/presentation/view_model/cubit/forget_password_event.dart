sealed class ForgetPasswordpPageEvent {}

class ForgetPasswordEvent extends ForgetPasswordpPageEvent {
  final String email;
  ForgetPasswordEvent(this.email);
}

class ResetPasswordEvent extends ForgetPasswordpPageEvent {
  final String password;
  ResetPasswordEvent(this.password);
}

class VerifyCodeEvent extends ForgetPasswordpPageEvent {
  final String code;
  VerifyCodeEvent(this.code);
}
