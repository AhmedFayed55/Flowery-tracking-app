sealed class LoginEvent {}

class GoToLoginEvent extends LoginEvent {
  final String email;
  final String password;

  GoToLoginEvent({required this.email, required this.password});
}

class IsRememberMeEvent extends LoginEvent {
  final bool isRemember;

  IsRememberMeEvent({required this.isRemember});
}

class EmailChangedEvent extends LoginEvent {
  final String email;

  EmailChangedEvent({required this.email});
}

class PasswordChangedEvent extends LoginEvent {
  final String password;

  PasswordChangedEvent({required this.password});
}
